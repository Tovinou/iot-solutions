from __future__ import annotations

import os
import random
from datetime import datetime, timezone

from locust import HttpUser, between, task


def _device_headers() -> dict[str, str]:
    key = (os.getenv("DEVICE_API_KEY") or "").strip()
    if not key:
        return {}
    return {"X-Device-Key": key}


class SensorUser(HttpUser):
    wait_time = between(0.1, 1.0)

    def on_start(self) -> None:
        self.sensor_id = f"sensor-{random.randint(1, 5000)}"

    @task(5)
    def ingest(self) -> None:
        payload = {
            "sensor_id": self.sensor_id,
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "temperature": round(random.uniform(10.0, 35.0), 2),
            "humidity": round(random.uniform(10.0, 95.0), 2),
            "air_quality": round(random.uniform(0.0, 500.0), 2),
        }
        self.client.post("/api/v1/data/", json=payload, headers=_device_headers(), name="POST /api/v1/data/")

    @task(2)
    def latest(self) -> None:
        self.client.get(
            "/api/v1/data/latest/",
            params={"sensor_id": self.sensor_id},
            headers=_device_headers(),
            name="GET /api/v1/data/latest/",
        )

    @task(1)
    def history(self) -> None:
        self.client.get(
            "/api/v1/data/history/",
            params={"sensor_id": self.sensor_id, "page_size": 50},
            headers=_device_headers(),
            name="GET /api/v1/data/history/",
        )
