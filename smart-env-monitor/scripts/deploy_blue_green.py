#!/usr/bin/env python
from __future__ import annotations

import argparse
import os
import subprocess
import sys


def _run(command: list[str], *, env: dict[str, str] | None = None) -> subprocess.CompletedProcess:
    return subprocess.run(command, check=False, capture_output=True, text=True, env=env)


def _require_ok(result: subprocess.CompletedProcess, *, label: str) -> None:
    if result.returncode != 0:
        raise RuntimeError(f"{label} failed: {result.stderr.strip() or result.stdout.strip()}")


def _get_current_web_container_id() -> str:
    result = _run(["docker", "compose", "ps", "-q", "web"])
    _require_ok(result, label="docker compose ps -q web")
    return result.stdout.strip()


def _get_container_label(container_id: str, key: str) -> str:
    result = _run(["docker", "inspect", "-f", f"{{{{ index .Config.Labels \"{key}\" }}}}", container_id])
    _require_ok(result, label=f"docker inspect label {key}")
    return result.stdout.strip()


def _get_container_image(container_id: str) -> str:
    result = _run(["docker", "inspect", "-f", "{{.Config.Image}}", container_id])
    _require_ok(result, label="docker inspect image")
    return result.stdout.strip()


def _flip_slot(slot: str) -> str:
    if slot.lower() == "blue":
        return "green"
    return "blue"


def _smoke_test(base_url: str) -> None:
    result = subprocess.run(
        [sys.executable, "scripts/smoke_test.py", "--base-url", base_url],
        check=False,
        text=True,
    )
    if result.returncode != 0:
        raise RuntimeError("smoke test failed")


def main() -> int:
    parser = argparse.ArgumentParser(description="Blue/green style deployment using labels and smoke tests.")
    parser.add_argument(
        "--image",
        default="",
        help="Optional web image tag to deploy (e.g. smart-env-monitor-web:2026-04-21).",
    )
    parser.add_argument(
        "--base-url",
        default="http://localhost:18080",
        help="Base URL used for smoke tests (defaults to the local proxy).",
    )
    args = parser.parse_args()

    web_container_id = _get_current_web_container_id()
    current_slot = "blue"
    current_image = ""
    if web_container_id:
        current_slot = _get_container_label(web_container_id, "com.smart-env-monitor.deploy.slot") or "blue"
        current_image = _get_container_image(web_container_id)

    target_slot = _flip_slot(current_slot)
    env = {**os.environ, "DEPLOY_SLOT": target_slot}
    if args.image.strip():
        env["WEB_IMAGE"] = args.image.strip()

    print(f"[blue-green] current_slot={current_slot} target_slot={target_slot}")
    if current_image:
        print(f"[blue-green] current_image={current_image}")
    if env.get("WEB_IMAGE"):
        print(f"[blue-green] target_image={env['WEB_IMAGE']}")

    up = subprocess.run(["docker", "compose", "up", "-d", "--build", "web", "proxy"], env=env, check=False, text=True)
    if up.returncode != 0:
        raise RuntimeError("docker compose up failed")

    try:
        _smoke_test(args.base_url.rstrip("/"))
    except Exception as exc:
        if current_image:
            rollback_env = {**os.environ, "DEPLOY_SLOT": current_slot, "WEB_IMAGE": current_image}
            subprocess.run(
                ["docker", "compose", "up", "-d", "web", "proxy"],
                env=rollback_env,
                check=False,
                text=True,
            )
        raise RuntimeError(str(exc)) from exc

    print("[blue-green] completed")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"[blue-green] FAILED: {exc}", file=sys.stderr)
        raise SystemExit(1)
