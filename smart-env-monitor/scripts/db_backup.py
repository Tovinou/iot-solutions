#!/usr/bin/env python
from __future__ import annotations

import argparse
import os
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

from dotenv import dotenv_values


def env_value(key: str, default: str) -> str:
    return (
        (os.getenv(key) or "").strip()
        or (dotenv_values(".env").get(key) or "").strip()
        or default
    )


def main() -> int:
    parser = argparse.ArgumentParser(description="Create a PostgreSQL backup from Docker db service.")
    parser.add_argument("--output-dir", default="backups", help="Directory where backup file is written.")
    parser.add_argument("--filename", default="", help="Optional custom filename.")
    args = parser.parse_args()

    db_name = env_value("POSTGRES_DB", "smart_env_monitor")
    db_user = env_value("POSTGRES_USER", "smartenv")
    db_password = env_value("POSTGRES_PASSWORD", "smartenv")

    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    filename = args.filename or f"smart_env_monitor_{stamp}.sql"
    output_path = output_dir / filename

    command = (
        f'PGPASSWORD="{db_password}" pg_dump -U "{db_user}" -d "{db_name}" --clean --if-exists'
    )
    with output_path.open("wb") as handle:
        proc = subprocess.run(
            ["docker", "compose", "exec", "-T", "db", "sh", "-c", command],
            stdout=handle,
            stderr=subprocess.PIPE,
            check=False,
        )
    if proc.returncode != 0:
        output_path.unlink(missing_ok=True)
        raise RuntimeError(proc.stderr.decode("utf-8", errors="replace"))

    print(f"[backup] created: {output_path}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"[backup] FAILED: {exc}", file=sys.stderr)
        raise SystemExit(1)
