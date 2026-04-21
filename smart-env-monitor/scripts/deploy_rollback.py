#!/usr/bin/env python
from __future__ import annotations

import argparse
import os
import subprocess
import sys


def _run(command: list[str]) -> subprocess.CompletedProcess:
    return subprocess.run(command, check=False, capture_output=True, text=True)


def _get_recent_web_images() -> list[str]:
    result = _run(
        [
            "docker",
            "images",
            "smart-env-monitor-web",
            "--format",
            "{{.Repository}}:{{.Tag}}",
        ]
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip() or "Failed to list docker images")
    images = [line.strip() for line in result.stdout.splitlines() if line.strip() and ":<none>" not in line]
    # docker images returns newest first
    unique: list[str] = []
    for image in images:
        if image not in unique:
            unique.append(image)
    return unique


def main() -> int:
    parser = argparse.ArgumentParser(description="Rollback web service to a previous Docker image.")
    parser.add_argument("--image", default="", help="Explicit image tag to rollback to.")
    parser.add_argument(
        "--steps-back",
        type=int,
        default=1,
        help="If --image is not set: pick Nth previous image (1 = previous).",
    )
    parser.add_argument(
        "--check",
        action="store_true",
        help="Check rollback readiness without performing rollback.",
    )
    args = parser.parse_args()

    if args.check:
        # Just check if we can rollback
        try:
            images = _get_recent_web_images()
            if len(images) < 2:
                raise RuntimeError(f"Insufficient image history for rollback. Found {len(images)} images.")
            print(f"[rollback-check] Found {len(images)} images, rollback possible to: {images[1]}")
            return 0
        except Exception as exc:
            print(f"[rollback-check] FAILED: {exc}", file=sys.stderr)
            return 1

    if args.image:
        target = args.image.strip()
    else:
        images = _get_recent_web_images()
        index = max(1, args.steps_back)
        if len(images) <= index:
            raise RuntimeError(
                f"Not enough image history. found={len(images)} requested_previous={index}"
            )
        target = images[index]

    print(f"[rollback] target image: {target}")
    up = subprocess.run(
        ["docker", "compose", "up", "-d", "web", "proxy"],
        env={**os.environ, "WEB_IMAGE": target},
        check=False,
        text=True,
    )
    if up.returncode != 0:
        raise RuntimeError("docker compose rollback failed")

    print("[rollback] completed")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"[rollback] FAILED: {exc}", file=sys.stderr)
        raise SystemExit(1)
