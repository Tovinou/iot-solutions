from __future__ import annotations

import json
import os
from typing import Any


def is_kafka_enabled() -> bool:
    return (os.getenv("KAFKA_ENABLED") or "").strip().lower() in {"1", "true", "yes", "on"}


def publish_event(topic: str, payload: dict[str, Any]) -> None:
    if not is_kafka_enabled():
        return

    bootstrap = (os.getenv("KAFKA_BOOTSTRAP_SERVERS") or "").strip() or "kafka:9092"
    client_id = (os.getenv("KAFKA_CLIENT_ID") or "").strip() or "smart-env-monitor"

    from kafka import KafkaProducer

    producer = KafkaProducer(
        bootstrap_servers=[part.strip() for part in bootstrap.split(",") if part.strip()],
        client_id=client_id,
        value_serializer=lambda v: json.dumps(v, separators=(",", ":"), default=str).encode("utf-8"),
        retries=0,
        request_timeout_ms=int((os.getenv("KAFKA_REQUEST_TIMEOUT_MS") or "2000").strip()),
        api_version_auto_timeout_ms=int((os.getenv("KAFKA_API_VERSION_TIMEOUT_MS") or "2000").strip()),
    )
    try:
        producer.send(topic, payload).get(timeout=2)
    finally:
        producer.flush(timeout=2)
        producer.close(timeout=2)
