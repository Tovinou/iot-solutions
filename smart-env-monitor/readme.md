# Smart Environmental Monitoring Platform

Smart Environmental Monitoring Platform är ett enterprise-grade IoT-system för övervakning av miljösensordata. Systemet simulerar en komplett IoT-arkitektur från sensor till dashboard med professionella verktyg för infrastruktur, övervakning, säkerhet och skalbarhet. Projektet är fullt förberett för produktion och kommunal överlämning med 8 professionella uppgraderingar implementerade.

## Enterprise Features Implemented

### 🏗️ **1. Infrastructure as Code (IaC)**
- Terraform-konfiguration för automatiserad infrastrukturprovisionering
- Docker provider för reproducerbara miljöer
- Lokalt körbar utan molnkostnader

### 📊 **2. Monitoring & Observability (ELK Stack)**
- Elasticsearch för datalagring och sökning
- Logstash för loggbehandling och pipeline
- Kibana för visualisering och dashboards
- Komplett övervakningsstack för loggar och metrics

### 🔄 **3. CI/CD Pipeline**
- GitHub Actions workflow för automatiserad testning
- Quality gates och smoke tests
- Deployment-validering på varje push/PR

### 🌐 **4. API Gateway (Kong)**
- Kong API Gateway med deklarativ konfiguration
- OAuth2-autentisering och auktorisering
- Rate limiting och CORS-skydd
- API-routing och plugins

### 📈 **5. Real-Time Analytics (Kafka)**
- Apache Kafka för event streaming
- Zookeeper för klusterkoordinering
- Realtidsdataflöde för sensorhändelser
- Kafka-producer integrerad i Django

### 🚢 **6. Container Orchestration (Kubernetes)**
- Kompletta Kubernetes-manifest för Minikube
- Deployment, Service och PersistentVolumeClaim
- Health checks och resource management
- Produktionsredo containerorkestrering

### ⚡ **7. Load Testing (Locust)**
- Locust-framework för prestandatestning
- Simulerade användarscenarier
- API- och dashboard-belastningstestning
- Realtidsmetrics och rapportering

### 🔒 **8. Advanced Security (OAuth)**
- OAuth2-implementering i Kong
- Token-baserad autentisering
- Scope-baserad auktorisering (read/write)
- Förbättrad API-säkerhet

## Arkitektur i korthet

- **Sensorsimulator** – Python-skript som läser CSV-data, tidsstämplar mätvärden, lägger till `sensor_id` och skickar dem säkert med jämna intervall.
- **API Gateway (Kong)** – Hanterar inkommande trafik, autentisering, rate limiting och routing till backend.
- **Backend** – Django + Django REST Framework (DRF) med REST-API för att ta emot, validera och exponera data.
- **Databas** – PostgreSQL (i produktion/Docker) eller SQLite (för lokal utveckling).
- **Message Queue** – Redis för Celery tasks, Kafka för realtidsanalys.
- **Monitoring** – ELK-stack (Elasticsearch, Logstash, Kibana) för loggning och visualisering.
- **Frontend** – Dashboard byggd med HTML, Bootstrap och Chart.js som visar aktuellt värde, status, historiska mätningar och sensorhälsa.
- **Load Testing** – Locust för prestandatestning och kapacitetsplanering.
- **Infrastruktur** – Dockeriserad miljö med Gunicorn som applikationsserver, Kong som API gateway, och Caddy som reverse proxy.

## Förutsättningar

- **Docker och Docker Compose** (Krävs för full enterprise-stack)
- **Python 3.12+** (Rekommenderas för lokal utveckling och körning av simulatorn)
- **Terraform** (För IaC-provisionering)
- **Minikube/Kubernetes** (För containerorkestrering)
- **Git**

Samtliga Python-beroenden finns listade i `requirements.txt` i projektroten.

## Installation och körning (Produktion med Docker)

Det rekommenderade sättet att köra plattformen är via den medföljande Docker-stacken.

1. **Klona projektet och gå in i katalogen**
   ```bash
   git clone https://github.com/Tovinou/IoT_project.git
   cd IoT_project/smart-env-monitor
   ```

2. **Konfigurera miljövariabler**
   Generera en nyckel med `python manage.py shell` och kör `from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())`.

   eller kör:
   python -c "import secrets; print('SECRET_KEY=' + secrets.token_urlsafe(48)); print('DEVICE_API_KEY=' + secrets.token_urlsafe(32))"

   Kopiera `.env.example` till `.env` och fyll i dina uppgifter:
   - `SECRET_KEY`: Din hemliga Django-nyckel.
   - `DEVICE_API_KEY`: API-nyckel som simulatorn använder för att autentisera sig.
   - Eventuella SMTP-inställningar för e-postlarm.

3. **Starta systemet**
   ```bash
   docker compose up -d --build
   ```
   *Detta startar databasen, kör Django-migreringar, samlar statiska filer och startar webbservern bakom Caddy-proxyn.*

4. **Kör sensorsimulatorn**
   För att skicka in data (i en separat terminal):
   ```bash
   python sensor/simulator.py
   ```
   *(Säkerställ att simulatorn har tillgång till samma `DEVICE_API_KEY` via en lokal `.env`-fil eller exporterad miljövariabel).*

5. **Åtkomst till plattformen**
   - Dashboard: `http://localhost:18080/dashboard/`
   - API Gateway (Kong): `http://localhost:8000/`
   - API (v1): `http://localhost:8000/api/v1/` (via Kong)
   - Swagger: `http://localhost:8000/swagger/` (via Kong)
   - Kibana (Monitoring): `http://localhost:5601/`
   - Kong Admin API: `http://localhost:8001/`

   **Viktigt:** Alla API-anrop ska gå genom Kong-gatewayn på port 8000 för autentisering och säkerhet.

## Säkerhet och Rate Limiting

Systemet är designat för att vara robust och motståndskraftigt i produktionsmiljö:

- **Enhetsautentisering:** För att skicka sensordata till `POST /api/v1/data/` krävs en giltig API-nyckel. Denna anges via HTTP-headern `X-Device-Key` eller som en `Bearer`-token. Om nyckeln saknas eller är ogiltig nekas anropet (401 Unauthorized).
- **Rate Limiting (DRF Throttling):** För att förhindra överbelastning (DDoS/Spam) tillämpas anropsbegränsningar:
  - `sensor_ingest`: Begränsar inkommande sensordata (Standard: 120 anrop/minut).
  - `sensor_read`: Begränsar dataläsningar från API:et (Standard: 600 anrop/minut).

## Övervakning och Sensorhälsa (Monitoring)

Plattformen inkluderar inbyggd övervakning för att säkerställa hög tillgänglighet och snabb felupptäckt:

- **Health Check Endpoint:** Ett publikt endpoint på `/health/` verifierar att webbtjänsten svarar och att anslutningen till databasen är intakt. Svarar med 200 OK eller 503 Service Unavailable.
- **Sensorstatus i Dashboard:** I gränssnittet visas tydligt när en sensor senast rapporterade data, och om sensorn bedöms vara "stale" (inaktiv).
- **Driftlarm (CLI):** Ett inbyggt management command övervakar sensorernas hälsa och kan skicka e-postlarm vid avbrott. Kan schemaläggas (t.ex. via cron):
  ```bash
  docker compose exec web python manage.py check_sensor_health --stale-minutes 30 --email-to admin@kommun.se
  ```

---

## Installation och körning (Lokal utveckling utan Docker)

Om du enbart vill köra projektet lokalt för utveckling (med SQLite):

1. **Skapa och aktivera virtuell miljö, installera beroenden**
   ```bash
   python -m venv venv
   source venv/bin/activate  # (Mac/Linux) eller venv\Scripts\activate (Windows)
   pip install -r requirements.txt
   ```
2. **Skapa `.env` baserat på `.env.example`**
3. **Skapa databas och kör migrationer**
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```
4. **Starta backend**
   ```bash
   python manage.py runserver
   ```

## Larm och notifieringar (Alert rules)
Systemet kan skicka e-post när inkommande sensordata matchar en fördefinierad regel.

- Skapa regel i admin: `http://localhost:18080/admin/` → **Api → Alert rules**
- Kontrollera triggar: `http://localhost:18080/admin/` → **Api → Alert events**
- Exempelregel för demo: `Vattentemperatur > 20` med mottagare `komlan.m@mail.com`

### E-postnotifieringar (SMTP)
Projektet kan antingen simulera e-post (skriva ut mailet i terminalen) eller skicka riktiga mail via SMTP.

- **Simulerad e-post (standard):**
  - Sätt `EMAIL_BACKEND=django.core.mail.backends.console.EmailBackend` (eller lämna tom)
- **Riktig e-post via SMTP (t.ex. MailerSend):**
  - Sätt `EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend` och fyll i SMTP-variablerna i `.env`.

## Inloggning och roller (RBAC)

Systemet har implementerat rollbaserad åtkomstkontroll (RBAC) för att begränsa åtkomst till funktioner och data.

- **Admin**: full åtkomst (Django Admin + alla vyer)
- **Manager**: rapportvy på `/dashboard/manager/`
- **Analyst**: analysvy på `/dashboard/analyst/`
- **Viewer**: endast läsrättigheter i dashboarden

Läs-API:et för dashboarden är publikt (men throttlat) och ligger under `/api/v1/`:
- `GET /api/v1/data/latest/?sensor_id=<id>`
- `GET /api/v1/data/history/?sensor_id=<id>`

Skapa konton via Django Admin:
- Skapa första admin: `docker compose exec web python manage.py createsuperuser`
- Gå till `http://localhost:18080/admin/` → Users → Add
- Tilldela grupper (Manager/Analyst/Viewer) under användarens “Groups”

| Roll    | Exempel-användarnamn | Exempel-lösenord |
| :---    | :---                 | :---             |
| Admin   | `?`                  | `?`              |
| Manager | `?`                  | `?`              |
| Analyst | `?`                  | `?`              |
| Viewer  | `?`                  | `?`              |

För att skapa en egen admin-användare:
`docker compose exec web python manage.py createsuperuser`

## Rapportera ärenden (formulär + databas)

Det finns ett formulär i webbgränssnittet där inloggade användare kan rapportera ett ärende kopplat till badvatten/sensorer. Ärenden sparas i databasen och kan granskas av rätt roll.

- **Skapa ärende:** `/dashboard/report/` (kräver inloggning)
- **Visa ärenden:** `/dashboard/reports/` (endast **Manager** eller **Admin**)
- **Export:** från ärendelistan (CSV/Excel/PDF) med samma filter som i vyn
- **API-export (JSON):** `GET /api/v1/incidents/` (endast **Manager** eller **Admin**)

### Statusflöde, historik och tilldelning
- **Statusflöde:** Öppen → Pågår → Stängd (stängda ärenden kan inte återöppnas i UI)
- **Kommentar vid stängning:** krävs när ett ärende sätts till Stängd (åtgärd/beslut)
- **Tilldelning:** Manager kan tilldela ett ärende till en användare
- **Åtgärdslogg:** sparar vem som ändrade status/tilldelning och när

## Projektstruktur (översikt)

```text
smart-env-monitor/
├── .github/workflows/                 # CI (GitHub Actions)
├── api/                               # REST-API (DRF), larm, audit, tasks
├── backend/                           # Django-projekt (settings/urls, celery, policies)
├── dashboard/                         # Dashboard UI (templates, views, static)
├── doc/                               # Drift-/handover-dokument (go-live, DR, runbook)
├── helm/smart-env-monitor/            # Helm chart (lokal Kubernetes)
├── k8s/                               # Kubernetes-manifest (lokal kluster)
├── kong/                              # Kong deklarativ config
├── loadtest/                          # Locust load testing (rekommenderad)
├── logstash/                          # Logstash pipeline (observability add-on)
├── observability/                     # Prometheus config (observability add-on)
├── scripts/                           # Quality gate, smoke, backup/restore, deploy/rollback
├── sensor/                            # Sensorsimulator + dataset (CSV)
├── terraform/                         # Terraform (Docker provider) för lokal IaC
├── tests/                             # Testsvit (pytest + e2e helpers)
├── docker-compose.yml                 # Bas-stack (proxy/web/db/redis/celery)
├── docker-compose.*.yml               # Valfria overlays (gateway, kafka, observability, keycloak)
├── Caddyfile                          # Reverse proxy (port 18080)
├── Dockerfile                         # Web image (Django/Gunicorn)
├── manage.py                          # Django entrypoint
└── requirements.txt                   # Python-beroenden
```

## Krav och dokumentation

Projektet är kopplat till en separat kravspecifikation (funktionella krav F‑xxx och icke‑funktionella krav NF‑xxx).  
Fullständig spårbarhet mellan krav och implementation finns beskriven i [projektdokumentation.md](doc/projektdokumentation.md).

## Quality Gate och smoke tests

För att snabbt verifiera att projektet är merge-ready finns två nya skript:

- `python scripts/quality_gate.py --use-sqlite`  
  Kör `manage.py check`, testsvit och `compileall` i en sekvens.
- `python scripts/smoke_test.py --base-url http://localhost:18080`  
  Kör live-smoke mot körande miljö: health, dashboard, ingest, latest och history.

### Rekommenderad verifieringsrutin

1. Starta stacken:
   ```bash
   docker compose up -d --build
   ```
2. Kör quality gate:
   ```bash
   python scripts/quality_gate.py --use-sqlite
   ```
3. Kör live-smoke mot proxy:
   ```bash
   python scripts/smoke_test.py --base-url http://localhost:18080
   ```

Projektet har även en CI-workflow i `.github/workflows/ci.yml` som automatiskt kör quality gate på varje push och pull request.

## Deployment hardening (Phase 1)

Följande finns nu för robust drift och kommunal överlämning:

- API-versionerad ingång: `/api/v1/` (nuvarande `/api/` finns kvar för bakåtkompatibilitet)
- Request tracing: varje svar innehåller `X-Request-ID`, och loggar korreleras med samma ID
- Databas-backup/restore:
  - `python scripts/db_backup.py`
  - `python scripts/db_restore.py backups/<file>.sql`

Se även:

- `doc/phase1-go-live-plan.md`
- `doc/operations-runbook.md`

## Phase 2 hardening

Ytterligare robusthet och förvaltningsstöd:

- API-dokumentation:
  - Swagger UI: `/swagger/`
- Centraliserad rollpolicy i `backend/policies.py`
- API-export skyddad via gemensam policyklass (`IsManagerOrAdmin`)
- Backup retention script:
  - `python scripts/backup_rotate.py --backup-dir backups --retention-days 30 --keep-min 7 --dry-run`

Mer detaljer finns i `doc/phase2-hardening.md`.

## Phase 3 enterprise readiness

- SSO-ready auth scaffold (trusted proxy headers)
- OIDC/OAuth2-stöd (valfritt) för SSO (t.ex. Keycloak) via `OIDC_ENABLED=1`
- APM felrapportering (valfritt) via Sentry (`SENTRY_DSN=...`)
- Security audit model for login/access/export events
- Deployment rollback automation (`scripts/deploy_rollback.py`)
- Blue/green-style deploy med labels + smoke (`scripts/deploy_blue_green.py`)
- Local-first “enterprise add-ons”: Kong API gateway, Prometheus/Grafana, Kafka, Kubernetes manifests och Helm chart

Mer detaljer finns i `doc/phase3-enterprise-readiness.md`.
