# Systemkonfiguration (Drift & Implementation)

Det här dokumentet beskriver hur Smart Env Monitor är konfigurerat i nuläget (drift med Docker), vilka centrala inställningar som finns, samt hur delarna hänger ihop. Dokumentet är skrivet för att vara praktiskt vid överlämning till kommun (IT/drift + verksamhet).

För en ren användarguide (hur man använder systemet i UI) se:
- `doc/user_guide.md`

## 1. Komponenter

- **proxy (Caddy)**: Tar emot trafik på `localhost:18080` och skickar vidare till Django‑appen.
- **web (Django + Gunicorn)**: API + Dashboard + Admin.
- **celery_worker / celery_beat**: Bakgrundsjobb (larmutvärdering, hälsokontroller, ev. event-publicering).
- **db (PostgreSQL)**: Lagrar sensordata, larmregler, larmhändelser och incidenter.
- **sensor/simulator.py**: Simulerar IoT‑flöde genom att skicka data från dataset till API.

## 2. Docker‑miljö (rekommenderad drift)

### 2.1 Start/stop

```bash
docker compose up -d --build
docker compose ps
docker compose down
```

### 2.2 URL:er (lokal drift)

- Dashboard: `http://localhost:18080/dashboard/`
- Admin: `http://localhost:18080/admin/`
- Health check: `http://localhost:18080/health/`
- Sensor ingest (för simulator): `http://localhost:18080/api/v1/data/`
- Swagger (API docs): `http://localhost:18080/swagger/`
- Prometheus metrics: `http://localhost:18080/metrics/`

## 3. Miljövariabler (.env)

Systemet är “env‑drivet”. `.env` (som inte committas) styr nycklar, databaskoppling, rate limiting och övervakning.

Viktiga variabler:

```env
SECRET_KEY=...
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1
DATABASE_URL=postgresql://smartenv:smartenv@db:5432/smart_env_monitor

PROXY_HTTP_PORT=18080
PROXY_HTTPS_PORT=18443
SITE_ADDRESS=:80

DEVICE_API_KEY=...
THROTTLE_SENSOR_INGEST=120/min
THROTTLE_SENSOR_READ=600/min

SENSOR_STALE_MINUTES=30
SENSOR_HEALTH_EMAIL_TO=

BACKEND_URL=http://localhost:18080/api/v1/data/
SENSOR_INTERVAL=10
DATASET_PATH=sensor/dataset/environment_data.csv
```

Noteringar:
- `DATABASE_URL` måste använda hostnamnet `db` (inte `localhost`) i Docker‑miljön.
- `DEVICE_API_KEY` används både av backend (för att validera ingest) och av simulatorn (för att skicka korrekt header).
- `BACKEND_URL` i Docker ska normalt vara `http://localhost:18080/api/v1/data/`.

Valfria variabler (enterprise add-ons):

```env
SENTRY_DSN=
SENTRY_TRACES_SAMPLE_RATE=0

OIDC_ENABLED=0
OIDC_RP_CLIENT_ID=
OIDC_RP_CLIENT_SECRET=
OIDC_OP_AUTHORIZATION_ENDPOINT=
OIDC_OP_TOKEN_ENDPOINT=
OIDC_OP_USER_ENDPOINT=
OIDC_OP_JWKS_ENDPOINT=
OIDC_GROUP_CLAIM=groups

KAFKA_ENABLED=0
KAFKA_BOOTSTRAP_SERVERS=kafka:9092
KAFKA_CLIENT_ID=smart-env-monitor

DEPLOY_SLOT=blue
WEB_IMAGE=smart-env-monitor-web:latest
```

## 4. Datamodell (nuvarande)

### 4.1 SensorReading

Sensoravläsningar lagras i modellen `SensorReading` med flera mätvärden per rad:
- `sensor_id` (t.ex. strandnamn)
- `timestamp`
- `water_temperature`
- `turbidity`
- `wave_height`
- `wave_period`
- `battery_life`
- `quality`

Implementation finns i `api/models.py`.

### 4.2 Larmregler och larmhändelser

Larm består av:
- `AlertRule`: vad som ska bevakas (metric/operator/threshold) och vart larm ska skickas.
- `AlertEvent`: logg när en regel triggas (tid, mottagare, subject/body).

Larmregler skapas och hanteras via Admin (Django admin).

## 5. API (nuvarande)

### 5.1 Sensor ingest (IoT → backend)

- Endpoint: `POST /api/v1/data/`
- Auth: Om `DEVICE_API_KEY` är satt krävs den via:
  - `X-Device-Key: <DEVICE_API_KEY>` eller
  - `Authorization: Bearer <DEVICE_API_KEY>`
- Rate limiting: `sensor_ingest` (styr via `THROTTLE_SENSOR_INGEST`)

### 5.2 Läs‑API (dashboard/interna användare)

Exempel:
- `GET /api/v1/data/latest/?sensor_id=<id>`
- `GET /api/v1/data/history/?sensor_id=<id>&from=YYYY-MM-DD&to=YYYY-MM-DD`

Rate limiting: `sensor_read` (styr via `THROTTLE_SENSOR_READ`)

## 6. Sensorsimulator (sensor/simulator.py)

Simulatorn:
- Läser dataset från `sensor/dataset/environment_data.csv`
- Sorterar rader kronologiskt (baserat på `Measurement Timestamp`)
- Skickar rader som JSON till `BACKEND_URL` med `X-Device-Key` om `DEVICE_API_KEY` finns i `.env`
- Skriver ut tydlig länk till dashboard i terminalen vid start

Start:

```bash
python sensor/simulator.py
```

## 7. Dashboard och roller (RBAC)

Dashboarden är publik för läsning på `/dashboard/`.

Inloggning/roller används för att visa och skydda funktioner:
- **Admin**: full åtkomst (inkl. `/admin/`)
- **Manager**: rapport/incident‑funktioner
- **Analyst**: analysvy
- **Viewer**: read‑only i dashboard

Roller implementeras via Django Groups och kontrolleras i vyer/templates.

## 8. Övervakning (Steg 3)

### 8.1 Health endpoint

- `GET /health/` returnerar:
  - `200 OK` om webb + databas fungerar
  - `503` om databasen inte går att nå

### 8.2 Sensorhälsa (stale detection)

Två nivåer:
- **UI**: Dashboard visar OK/Stale per sensor baserat på `SENSOR_STALE_MINUTES`.
- **CLI**: `check_sensor_health` kan köras schemalagt och kan skicka e‑post om sensorer blir stale.

Körning:

```bash
docker compose exec web python manage.py check_sensor_health --stale-minutes 30 --email-to drift@kommun.se
```

## 9. Driftkommandon (vanliga)

### 9.1 Skapa admin‑användare

```bash
docker compose exec web python manage.py createsuperuser
```

### 9.2 Se loggar

```bash
docker compose logs web
docker compose logs proxy
docker compose logs db
```

### 9.3 Nollställ databas (demo/test)

```bash
docker compose exec web python manage.py flush --no-input
```

## 10. Dataset

Datasetet ligger i repo under `sensor/dataset/environment_data.csv` och används av simulatorn. Syftet är att simulera ett realistiskt IoT‑flöde från flera sensorer (stränder) till dashboarden.

## 11. Add-ons (valfria)

Starta extra stacks som overlays:

- Observability (Prometheus/Grafana/ELK):
  - `docker compose -f docker-compose.yml -f docker-compose.observability.yml up -d`
- API Gateway (Kong):
  - `docker compose -f docker-compose.yml -f docker-compose.gateway.yml up -d`
- Keycloak (SSO):
  - `docker compose -f docker-compose.keycloak.yml up -d`
- Kafka (streaming):
  - `docker compose -f docker-compose.yml -f docker-compose.kafka.yml up -d`

Local IaC och kluster:
- Terraform (Docker provider) finns under `terraform/`.
- Kubernetes-manifest finns under `k8s/` och Helm-chart under `helm/smart-env-monitor/`.
