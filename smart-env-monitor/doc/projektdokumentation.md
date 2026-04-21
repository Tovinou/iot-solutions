# Projektdokumentation - Smart Environment Monitor

## 1. Inledning
Detta projekt är en fullstack IoT-lösning för övervakning av miljösensordata (strandvattenkvalitet). Systemet simulerar en IoT-enhet, samlar in data via ett REST API, lagrar det i en databas och visualiserar det i realtid via en webb-dashboard. Projektet är nu fullt förberett för produktion och kommunal överlämning med Docker, PostgreSQL, säkerhetsmekanismer och inbyggd övervakning.

## 2. Arkitektur
Systemet är uppbyggt av fyra huvudkomponenter, paketerade i en modern container-arkitektur:

1.  **Sensor (Simulator):** En Python-applikation som simulerar en IoT-enhet. Den hämtar verklig data från ett öppet dataset, autentiserar sig med en API-nyckel och skickar datan till backend.
2.  **Infrastruktur & Nätverk:** En reverse proxy (Caddy) hanterar inkommande trafik och dirigerar den till applikationsservern (Gunicorn) som kör Django-applikationen.
3.  **Backend (API & Databas):** Django + Django REST Framework (DRF) tar emot, validerar och rate-limitar datan. Datan lagras persistent i en PostgreSQL-databas.
4.  **Frontend (Dashboard):** Ett webbgränssnitt som visar data i realtid, historiska trender, aktuella larm samt övervakar sensorernas hälsa (Monitoring).

### Arkitekturdiagram

```mermaid
graph TD
    subgraph "IoT Device (Simulator)"
        S[Sensor Script] -->|Hämtar data| D[Open Dataset (CSV)]
        S -->|POST JSON + API Key| RP[Reverse Proxy - Caddy]
    end

    subgraph "Docker Miljö (Produktion)"
        RP -->|HTTP| WSGI[Gunicorn + Django]
        WSGI -->|Validerar & Throttling| API[REST API]
        API -->|Sparar| DB[(PostgreSQL)]
        API -->|Utvärderar regler| AR[Alert Rules]
    end

    AR -->|Skickar e-post| SMTP[SMTP Provider]
    SMTP -->|Levererar| M[Mail inbox]

    subgraph "Frontend (Dashboard/Admin)"
        B[Browser] -->|GET HTML/JSON| RP
        B -->|Visualiserar| C[Chart.js]
    end
```

## 3. Teknikval

### Backend: Django & DRF (Python)
*   **Varför:** Ett robust, säkert och skalbart ramverk. Har inbyggt stöd för ORM, admin-gränssnitt och REST API. DRF erbjuder kraftfulla verktyg för throttling (rate limiting) och serialisering.

### Databas: PostgreSQL
*   **Varför:** Standardvalet för relationsdatabaser i produktion. Hanterar stora datamängder och hög samtidighet mycket bättre än SQLite. (SQLite stöds dock fortfarande för snabb lokal utveckling utan Docker).

### Infrastruktur: Docker, Gunicorn & Caddy
*   **Docker:** Garanterar att applikationen körs likadant oavsett miljö och förenklar deployment.
*   **Gunicorn:** En robust WSGI-server anpassad för produktion.
*   **Caddy:** En extremt snabb reverse proxy som automatiskt kan hantera HTTPS/TLS (även om den här agerar HTTP-proxy i lokal Docker-miljö).
*   **WhiteNoise:** För effektiv servering av statiska filer direkt från Gunicorn/Django.

### Frontend: Bootstrap 5 & Chart.js
*   **Bootstrap:** För responsiv design.
*   **Chart.js:** Ett enkelt men kraftfullt bibliotek för datavisualisering.

## 4. Kravuppfyllelse

### Funktionella Krav
| Krav | Status | Beskrivning |
| :--- | :--- | :--- |
| **Simulerad sensor** | ✅ Uppfyllt | Hämtar data, tidsstämplar, autentiserar sig och skickar till API. |
| **Datakommunikation** | ✅ Uppfyllt | Överför data via REST API (POST) säkert med API-nyckel. |
| **Backend & API** | ✅ Uppfyllt | Exponerar REST API. Validerar input och tillämpar Rate Limiting. |
| **Dataplattform** | ✅ Uppfyllt | Lagrar sensordata persistent i PostgreSQL (eller SQLite lokalt). |
| **Frontend** | ✅ Uppfyllt | Visar mätvärden, diagram, sensorstatus och aktiva larm. |
| **Ärendehantering** | ✅ Uppfyllt | Formulär och flöde för inloggade användare och managers. |
| **Larm & Notifieringar** | ✅ Uppfyllt | E-post skickas baserat på regler (`water_temperature > 20`). |
| **Övervakning (Monitoring)**| ✅ Uppfyllt | `/health/` endpoint, sensorhälsa i UI, och driftlarm via CLI. |

### Icke-funktionella Krav
| Krav | Status | Beskrivning |
| :--- | :--- | :--- |
| **Produktionsmiljö** | ✅ Uppfyllt | Containeriserad med Docker, Gunicorn och Caddy. Miljövariabler används. |
| **Säkerhet** | ✅ Uppfyllt | Enhetsautentisering (API-nyckel) för IoT, RBAC för webb, Rate Limiting för API. |
| **Versionshantering** | ✅ Uppfyllt | Git-användning genom hela projektet. |

## 5. Instruktioner för körning

### 5.1 Produktion (Docker Compose) - Rekommenderas
1. Kopiera `.env.example` till `.env` och sätt unika värden (t.ex. `DEVICE_API_KEY` och `SECRET_KEY`).
2. Kör `docker compose up -d --build`.
   - Detta startar PostgreSQL, bygger webbcontainern, kör migreringar (`migrate`), samlar in statiska filer (`collectstatic`), och startar Caddy-proxyn.
3. Tjänsten nås via `http://localhost:18080` (Standardport i `.env.example`).
4. Starta simulatorn: `python sensor/simulator.py`.
   - Simulatorn läser automatiskt konfiguration från `.env` (inkl. `BACKEND_URL` och `DEVICE_API_KEY`).
   - I Docker-körning ska `BACKEND_URL` peka på versionerad ingest-endpoint via proxyn: `http://localhost:18080/api/v1/data/`.
   - Simulatorn skickar sensordata för alla stränder i datasetet och sorterar datan kronologiskt (baserat på `Measurement Timestamp`) för att simulera ett realistiskt flöde.
5. Dashboard nås via `http://localhost:18080/dashboard/`.

### 5.2 Lokal utveckling (Utan Docker)
1. Aktivera en venv och kör `pip install -r requirements.txt`.
2. Kör `python manage.py migrate` för att sätta upp SQLite-databasen.
3. Starta servern med `python manage.py runserver`.
4. Starta simulatorn med rätt `DEVICE_API_KEY` i miljön.

### 5.3 Övervakning och Driftlarm
Systemet övervakar kontinuerligt om sensorer slutar skicka data (blir "stale").
- **Health Check:** `GET /health/` returnerar `200 OK` och en JSON som bekräftar att webb och databas fungerar (t.ex. `{"status":"ok","database":"connected"}`).
- **Driftlarm (CLI):** Kör `docker compose exec web python manage.py check_sensor_health --stale-minutes 30 --email-to larm@kommun.se` för att få rapport om inaktiva sensorer (lämpligt för Cron-jobb).

## 6. Säkerhet och Åtkomstkontroll

### 6.1 Enhetsautentisering (IoT) & Rate Limiting
För att förhindra skräpdata och överbelastning har REST-API:et skyddats:
1. **API-nyckel:** Anrop till `POST /api/v1/data/` kräver en hemlig nyckel. Den kan skickas antingen via headern `X-Device-Key` eller som en `Authorization: Bearer <nyckel>`. Ogiltig nyckel ger `401 Unauthorized`.
2. **Rate Limiting (Throttling):** Djangos REST Framework begränsar antalet anrop:
   - `sensor_ingest`: Max 120 anrop/minut (skyddar mot spam av mätdata).
   - `sensor_read`: Max 600 anrop/minut (skyddar API-läsningar från dashboard/tredjepart).

### 6.2 Användarroller (RBAC) för webbgränssnitt
| Roll | Beskrivning | Behörighet |
| :--- | :--- | :--- |
| **Admin** | Systemadministratör | Fullständig tillgång (Django Admin + alla vyer). |
| **Manager** | Beslutsfattare | Tillgång till rapportvy och hantering av ärenden. |
| **Analyst** | Dataanalytiker | Tillgång till analysvy. |
| **Viewer** | Observatör | Endast läsrättigheter i dashboarden. |

## 7. API Dokumentation

| Metod | Endpoint | Beskrivning | Auth-krav |
| :--- | :--- | :--- | :--- |
| `GET` | `/health/` | Health check för övervakning av webb och DB. | Ingen |
| `POST` | `/api/v1/data/` | Tar emot nya sensorvärden från simulatorn. | ✅ API-nyckel (`X-Device-Key`) |
| `GET` | `/api/v1/data/latest/` | Hämtar senaste värdet. Query params: `sensor_id` | Ingen |
| `GET` | `/api/v1/data/history/` | Hämtar historik. Query params: `sensor_id`, `from`, `to` | Ingen |
| `GET` | `/api/v1/incidents/` | Exporterar ärenden som JSON. | ✅ Manager/Admin |

## 8. Projektstruktur
```text
smart-env-monitor/
├── api/                  # REST-API (DRF), auth, throttling och larm
│   └── management/       # Custom CLI commands (check_sensor_health)
├── backend/              # Django-projektkonfiguration
├── dashboard/            # Webb-dashboard (templates + vyer)
├── sensor/               # IoT-simulator
├── docker-compose.yml    # Konfiguration för Docker stack (DB, Web, Proxy)
├── Dockerfile            # Instruktioner för webb-containern
├── Caddyfile             # Konfiguration för reverse proxy
├── requirements.txt      # Python-beroenden
└── doc/                  # Dokumentation och bilagor
```

## 9. Framtida förbättringar
Eftersom plattformen nu är dockeriserad, säkrad och utrustad med produktionsdatabas (PostgreSQL), är de huvudsakliga framtida stegen:
1.  **Realtid:** Implementera WebSockets (Django Channels) för att pusha data till dashboarden utan polling.
2.  **Fysisk hårdvara:** Ersätta simulatorn med exempelvis Raspberry Pi/ESP32 och riktiga sensorer ute i fält.
3.  **E-post i produktion:** Verifiera egen domän (SPF/DKIM/DMARC) och skicka från `noreply@<egen-domän>` för bättre leveransbarhet.
4.  **K8s i drift:** Köra plattformen i en lokal Kubernetes-kluster (kind/minikube) och använda Helm-chart för reproducerbar installation.

## 10. Enterprise-förbättringar (lokal-first)
Utöver basfunktionalitet finns nu valfria, professionella “add-ons” som kan aktiveras utan molnleverantör:
- **CI**: GitHub Actions kör `scripts/quality_gate.py --use-sqlite`.
- **APM**: Sentry aktiveras via `SENTRY_DSN`.
- **SSO**: OIDC kan aktiveras via `OIDC_ENABLED=1` (t.ex. med lokal Keycloak).
- **API Gateway**: Kong kan startas via `docker-compose.gateway.yml`.
- **Observability**: Prometheus/Grafana/ELK via `docker-compose.observability.yml`.
- **Streaming**: Kafka-stöd (valfritt) via `KAFKA_ENABLED=1`.
- **IaC**: Terraform (Docker provider) under `terraform/`.
- **Load test**: Locust-skript under `loadtest/`.
