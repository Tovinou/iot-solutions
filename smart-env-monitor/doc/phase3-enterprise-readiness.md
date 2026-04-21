# Phase 3 Enterprise Readiness (Implemented)

## Levererat

1. **SSO-ready scaffold**
   - Ny auth backend: `backend/auth_backends.py`
   - Header-baserad SSO (via trusted reverse proxy) kan aktiveras med:
     - `ENABLE_SSO_HEADER_AUTH=True`
     - `SSO_HEADER_USERNAME`
     - `SSO_HEADER_EMAIL`

2. **Skärpt säkerhetsaudit**
   - Ny modell: `SecurityAuditEvent` i `api/models.py`
   - Fångar:
     - Login success/failure
     - Logout
     - Access denied (policy-brott)
     - Incident export (spårbarhet av känslig dataexport)
   - Signals registreras via `api/apps.py` (`ready()` -> `api.audit`)
   - Synligt i Django Admin

3. **Rollback automation**
   - `scripts/deploy_rollback.py`
   - Kan rollbacka `web` + `proxy` till tidigare image
   - `docker-compose.yml` stöder nu `WEB_IMAGE` override

## Exempel

- Aktivera SSO-header auth:
  - `ENABLE_SSO_HEADER_AUTH=True`
- Rollback till föregående image:
  - `python scripts/deploy_rollback.py --steps-back 1`
- Rollback till specifik image:
  - `python scripts/deploy_rollback.py --image smart-env-monitor-web:previous`
