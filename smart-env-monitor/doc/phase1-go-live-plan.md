# Phase 1 Go-Live Plan (Commune)

Detta dokument beskriver de mest kritiska åtgärderna inför första produktionsdriftsättning.

## Mål

- Körbar, verifierbar och återställningsbar driftmiljö.
- Baslinje för säkerhet, spårbarhet och release-kontroll.
- Tydlig operativ handover till kommunens IT-drift.

## Genomfört i denna fas

- Quality gate script: `scripts/quality_gate.py`
- Live smoke test: `scripts/smoke_test.py`
- API versioning-ingång: `/api/v1/` (kompatibilitet med `/api/` kvarstår)
- Request-ID middleware + log-korrelation
- CI med kvalitet + säkerhetsscanning (`pip-audit`, `bandit`)
- Backup/restore scripts: `scripts/db_backup.py`, `scripts/db_restore.py`

## Kvar att göra innan produktionsstart

1. **Secrets-hantering**
   - Flytta SMTP, Django `SECRET_KEY` och `DEVICE_API_KEY` från `.env` till hemlighetsvalv.
2. **Driftövervakning**
   - Koppla logs och metrics till kommunens centrala övervakning.
3. **Backup-rutin**
   - Schemalägg dagliga backuper och verifiera restore-test minst månadsvis.
4. **Roll- och behörighetsgranskning**
   - Godkänn formell matris för vilka roller som får exportera och ändra status.
5. **Go-live rehearsal**
   - Genomför en full deploy + rollback-övning i staging.

## Acceptanskriterier

- `python scripts/quality_gate.py --use-sqlite` passerar.
- `python scripts/smoke_test.py --base-url http://localhost:18080` passerar.
- Backup går att skapa och restore verifierad i testmiljö.
- Inga kritiska fynd i `pip-audit`/`bandit`.
