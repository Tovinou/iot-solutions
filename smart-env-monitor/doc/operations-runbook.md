# Operations Runbook

## 1) Start/stop

- Start:
  - `docker compose up -d --build`
- Stop:
  - `docker compose down`
- Status:
  - `docker compose ps`

## 1b) Rollback

- Rollback to previous image:
  - `python scripts/deploy_rollback.py --steps-back 1`
- Rollback to explicit tag:
  - `python scripts/deploy_rollback.py --image smart-env-monitor-web:<tag>`

## 1c) Blue/green deploy (label-based)

- Deploy with smoke test (auto-switches `DEPLOY_SLOT` label and rolls back on failure):
  - `python scripts/deploy_blue_green.py --base-url http://localhost:18080`
- Deploy explicit image tag:
  - `python scripts/deploy_blue_green.py --image smart-env-monitor-web:<tag> --base-url http://localhost:18080`

## 2) Health and smoke

- Health endpoint:
  - `http://localhost:18080/health/`
- Full smoke:
  - `python scripts/smoke_test.py --base-url http://localhost:18080`

## 3) Quality gate before deploy

- `python scripts/quality_gate.py --use-sqlite`

## 4) Backup

- Create DB backup:
  - `python scripts/db_backup.py`
- Custom output folder:
  - `python scripts/db_backup.py --output-dir backups/prod`

## 4b) Backup retention

- Dry-run retention cleanup:
  - `python scripts/backup_rotate.py --backup-dir backups --retention-days 30 --keep-min 7 --dry-run`
- Execute cleanup:
  - `python scripts/backup_rotate.py --backup-dir backups --retention-days 30 --keep-min 7`

## 4c) Data retention cleanup (sensor readings)

- Execute cleanup:
  - `docker compose exec web python scripts/retention_cleanup.py`

## 5) Restore

- Restore from backup:
  - `python scripts/db_restore.py backups/<file>.sql`
- Non-interactive restore:
  - `python scripts/db_restore.py backups/<file>.sql --yes`

## 6) Logs and correlation

- App logs include `request_id`.
- Response header includes `X-Request-ID`.
- Use `X-Request-ID` from user reports to trace request across logs.

## 6b) API docs and contract

- Swagger UI:
  - `/swagger/`
- Versioned API base:
  - `/api/v1/`

## 7) Incident procedure (minimum)

1. Confirm service status (`docker compose ps`).
2. Check `/health/`.
3. Inspect web logs (`docker compose logs web --tail=200`).
4. Validate with smoke test.
5. If unresolved, rollback to previous known good image/config.

## 8) SSO header auth (optional)

- Intended behind trusted proxy only.
- Enable in environment:
  - `ENABLE_SSO_HEADER_AUTH=True`
  - `SSO_HEADER_USERNAME=X-Forwarded-User`
  - `SSO_HEADER_EMAIL=X-Forwarded-Email`

## 9) SLA / SLO (handover baseline)

- Availability target: 99.5% per calendar month (excluding planned maintenance)
- RTO (restore time objective): 4 hours
- RPO (restore point objective): 24 hours (based on DB backup cadence)
- Incident response: triage within 1 business day
