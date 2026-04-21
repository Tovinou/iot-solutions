#!/usr/bin/env python
from __future__ import annotations

import argparse
import os
import subprocess
import sys
from pathlib import Path


def run_step(command: list[str], env: dict[str, str], title: str) -> None:
    print(f"[quality] {title}: {' '.join(command)}")
    completed = subprocess.run(command, env=env, check=False)
    if completed.returncode != 0:
        raise RuntimeError(f"{title} failed with exit code {completed.returncode}")


def main() -> int:
    parser = argparse.ArgumentParser(description="Run project quality gate checks.")
    parser.add_argument("--use-sqlite", action="store_true", help="Force SQLite by clearing DATABASE_URL.")
    parser.add_argument("--smoke-base-url", default="", help="Run smoke tests against this base URL if provided.")
    args = parser.parse_args()

    env = os.environ.copy()
    if args.use_sqlite:
        env["DATABASE_URL"] = ""

    project_root = Path(__file__).resolve().parents[1]
    os.chdir(project_root)

    run_step([sys.executable, "manage.py", "check"], env, "django check")
    run_step([sys.executable, "manage.py", "makemigrations", "--check", "--dry-run"], env, "migration drift check")
    run_step([sys.executable, "manage.py", "test"], env, "django test")
    run_step([sys.executable, "-m", "compileall", "api", "dashboard", "backend"], env, "compileall")

    if args.smoke_base_url:
        run_step(
            [sys.executable, "scripts/smoke_test.py", "--base-url", args.smoke_base_url],
            env,
            "smoke tests",
        )

    print("[quality] all checks passed")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"[quality] FAILED: {exc}", file=sys.stderr)
        raise SystemExit(1)
