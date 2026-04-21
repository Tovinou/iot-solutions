#!/usr/bin/env python
from __future__ import annotations

import argparse
import os
import subprocess
import sys
from pathlib import Path

from dotenv import dotenv_values


def env_value(key: str, default: str) -> str:
    return (
        (os.getenv(key) or "").strip()
        or (dotenv_values(".env").get(key) or "").strip()
        or default
    )


def main() -> int:
    parser = argparse.ArgumentParser(description="Restore PostgreSQL backup into Docker db service.")
    parser.add_argument("backup_file", help="Path to .sql backup file")
    parser.add_argument(
        "--yes",
        action="store_true",
        help="Skip safety prompt. Use only in automated restore workflows.",
    )
    args = parser.parse_args()

    backup_path = Path(args.backup_file)
    if not backup_path.exists():
        raise RuntimeError(f"Backup file not found: {backup_path}")

    db_name = env_value("POSTGRES_DB", "smart_env_monitor")
    db_user = env_value("POSTGRES_USER", "smartenv")
    db_password = env_value("POSTGRES_PASSWORD", "smartenv")

    if not args.yes:
        answer = input(
            f"This will overwrite data in database '{db_name}'. Type 'restore' to continue: "
        ).strip()
        if answer != "restore":
            print("[restore] cancelled")
            return 1

    command = f'PGPASSWORD="{db_password}" psql -U "{db_user}" -d "{db_name}"'
    with backup_path.open("rb") as handle:
        proc = subprocess.run(
            ["docker", "compose", "exec", "-T", "db", "sh", "-c", command],
            stdin=handle,
            stderr=subprocess.PIPE,
            check=False,
        )
    if proc.returncode != 0:
        raise RuntimeError(proc.stderr.decode("utf-8", errors="replace"))

    print(f"[restore] restored from: {backup_path}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"[restore] FAILED: {exc}", file=sys.stderr)
        raise SystemExit(1)
