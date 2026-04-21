#!/usr/bin/env python3
"""
Pre-Release Readiness Script
Runs quality + smoke + backup + retention + rollback readiness checks in sequence.
Exit code 0 = all checks passed, ready for release.
Exit code 1 = checks failed, do not release.
"""

import subprocess
import sys
import os
from pathlib import Path

def run_command(cmd, description):
    """Run a command and return success status."""
    print(f"[pre-release] {description}: {' '.join(cmd)}")
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        print(f"[pre-release] {description}: PASSED")
        return True
    except subprocess.CalledProcessError as e:
        print(f"[pre-release] {description}: FAILED")
        print(f"STDOUT: {e.stdout}")
        print(f"STDERR: {e.stderr}")
        return False

def main():
    """Run all pre-release checks."""
    project_root = Path(__file__).resolve().parents[1]

    checks = [
        # Quality checks
        (["python", "manage.py", "check"], "Django system checks"),
        (["python", "manage.py", "makemigrations", "--check", "--dry-run"], "Migration drift check"),
        (["python", "manage.py", "test"], "Django tests"),

        # Smoke tests (external)
        (["python", "scripts/smoke_test.py"], "Smoke tests"),

        # Backup readiness (external)
        (["python", "scripts/db_backup.py"], "Database backup creation"),

        # Retention cleanup
        (["python", "-c", "from scripts.retention_cleanup import main; main()"], "Data retention cleanup"),

        # Rollback readiness
        (["python", "scripts/deploy_rollback.py", "--check"], "Rollback readiness check"),
    ]

    all_passed = True
    for cmd, desc in checks:
        if not run_command(cmd, desc):
            all_passed = False

    if all_passed:
        print("[pre-release] All checks PASSED - Ready for release!")
        sys.exit(0)
    else:
        print("[pre-release] Some checks FAILED - Do not release!")
        sys.exit(1)

if __name__ == "__main__":
    main()