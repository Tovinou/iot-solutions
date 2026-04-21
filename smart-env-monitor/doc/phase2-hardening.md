# Phase 2 Hardening (Implemented)

## Levererat i denna fas

1. **API kontrakt och dokumentation**
   - OpenAPI schema endpoint: `/api/schema/`
   - API docs (ReDoc): `/api/docs/`
   - Versionerad API-ingång används via `/api/v1/`

2. **Centraliserad behörighetspolicy**
   - Ny modul: `backend/policies.py`
   - Delad policy mellan dashboard-vyer och DRF-API
   - DRF permission class: `IsManagerOrAdmin`

3. **Behörighetstester**
   - Tester för policyfunktioner i `dashboard/tests.py`
   - API-export behörighetstester i `api/tests.py`

4. **Backup-livscykel**
   - Nytt script: `scripts/backup_rotate.py`
   - Retentionstyrning med `--retention-days` och `--keep-min`

## Exempelkommandon

- Kör docs lokalt:
  - `http://localhost:18080/api/docs/`
- Rensa gamla backups (dry run):
  - `python scripts/backup_rotate.py --backup-dir backups --retention-days 30 --keep-min 7 --dry-run`
- Rensa gamla backups (skarpt):
  - `python scripts/backup_rotate.py --backup-dir backups --retention-days 30 --keep-min 7`
