#!/usr/bin/env python
from __future__ import annotations

import argparse
import os
import sys
from datetime import datetime, timezone

import requests
from dotenv import dotenv_values


def _load_device_key(cli_key: str | None) -> str:
    if cli_key:
        return cli_key.strip()
    env_key = (os.getenv("DEVICE_API_KEY") or "").strip()
    if env_key:
        return env_key
    dot_env = dotenv_values(".env")
    return (dot_env.get("DEVICE_API_KEY") or "").strip()


def _request_ok(response: requests.Response, label: str, expected_status: int) -> None:
    if response.status_code != expected_status:
        raise RuntimeError(
            f"{label} expected HTTP {expected_status}, got {response.status_code}: {response.text[:300]}"
        )


def main() -> int:
    parser = argparse.ArgumentParser(description="Run live smoke tests against Smart Env Monitor.")
    parser.add_argument("--base-url", default="http://localhost:18080", help="Base URL for proxy/API.")
    parser.add_argument("--sensor-id", default="smoke-sensor-01", help="Sensor ID used for ingest validation.")
    parser.add_argument("--device-key", default=None, help="Device API key (falls back to env/.env).")
    args = parser.parse_args()

    base_url = args.base_url.rstrip("/")
    sensor_id = args.sensor_id
    device_key = _load_device_key(args.device_key)

    print(f"[smoke] base_url={base_url}")

    health = requests.get(f"{base_url}/health/", timeout=15)
    _request_ok(health, "health endpoint", 200)
    print("[smoke] health OK")

    dashboard = requests.get(f"{base_url}/dashboard/", timeout=15)
    _request_ok(dashboard, "dashboard endpoint", 200)
    print("[smoke] dashboard OK")

    if not device_key:
        raise RuntimeError("DEVICE_API_KEY missing. Set env var or pass --device-key.")

    payload = {
        "sensor_id": sensor_id,
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "water_temperature": 19.8,
        "turbidity": 1.9,
        "wave_height": 0.5,
        "wave_period": 4.4,
        "battery_life": 90,
        "quality": "OK",
    }
    headers = {"X-Device-Key": device_key}
    ingest = requests.post(f"{base_url}/api/v1/data/", json=payload, headers=headers, timeout=15)
    _request_ok(ingest, "sensor ingest endpoint", 201)
    print("[smoke] ingest OK")

    latest = requests.get(f"{base_url}/api/v1/data/latest/?sensor_id={sensor_id}", timeout=15)
    _request_ok(latest, "latest endpoint", 200)
    print("[smoke] latest OK")

    history = requests.get(f"{base_url}/api/v1/data/history/?sensor_id={sensor_id}", timeout=15)
    _request_ok(history, "history endpoint", 200)
    data = history.json()
    if isinstance(data, dict) and isinstance(data.get("results"), list):
        rows = data["results"]
    elif isinstance(data, list):
        rows = data
    else:
        raise RuntimeError("history endpoint returned unexpected response shape.")

    if not rows:
        raise RuntimeError("history endpoint returned empty dataset after ingest.")
    print(f"[smoke] history OK ({len(rows)} rows)")

    print("[smoke] all checks passed")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"[smoke] FAILED: {exc}", file=sys.stderr)
        raise SystemExit(1)
