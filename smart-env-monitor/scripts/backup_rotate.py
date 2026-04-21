#!/usr/bin/env python
from __future__ import annotations

import argparse
import sys
from datetime import datetime, timedelta, timezone
from pathlib import Path


def main() -> int:
    parser = argparse.ArgumentParser(description="Delete old SQL backups by retention policy.")
    parser.add_argument("--backup-dir", default="backups", help="Directory containing *.sql backups.")
    parser.add_argument("--retention-days", type=int, default=30, help="Delete backups older than this age.")
    parser.add_argument("--keep-min", type=int, default=7, help="Always keep at least this many latest backups.")
    parser.add_argument("--dry-run", action="store_true", help="Show files that would be deleted.")
    args = parser.parse_args()

    backup_dir = Path(args.backup_dir)
    if not backup_dir.exists():
        print(f"[rotate] backup directory does not exist: {backup_dir}")
        return 0

    files = sorted(backup_dir.glob("*.sql"), key=lambda p: p.stat().st_mtime, reverse=True)
    if len(files) <= args.keep_min:
        print(f"[rotate] nothing to delete (files={len(files)}, keep_min={args.keep_min})")
        return 0

    cutoff = datetime.now(timezone.utc) - timedelta(days=args.retention_days)
    to_consider = files[args.keep_min:]
    to_delete = [p for p in to_consider if datetime.fromtimestamp(p.stat().st_mtime, timezone.utc) < cutoff]

    if not to_delete:
        print("[rotate] nothing exceeded retention policy")
        return 0

    for path in to_delete:
        if args.dry_run:
            print(f"[rotate] would delete: {path}")
        else:
            path.unlink(missing_ok=True)
            print(f"[rotate] deleted: {path}")

    print(f"[rotate] done (deleted={len(to_delete)})")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"[rotate] FAILED: {exc}", file=sys.stderr)
        raise SystemExit(1)
