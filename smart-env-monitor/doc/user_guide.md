Smart Env Monitor – Användarguide
=================================

Den här guiden är skriven för kommunens användare (både tekniska och icke‑tekniska) som ska använda Smart Env Monitor för att övervaka badvattenkvalitet och relaterad miljödata.

Guiden beskriver:
- Hur systemet är uppbyggt
- Hur man startar systemet (Docker + simulator)
- Hur man använder dashboarden
- Hur roller och behörigheter fungerar
- Hur larmregler och övervakning fungerar
- Vanliga fel och hur man löser dem

> **Kortfattat:** Systemet simulerar ett verkligt IoT‑flöde: sensorer → API → databas → API → dashboard.


1. Systemöversikt
-----------------

Systemet består av följande huvuddelar:

- **Sensorsimulator** (Python)
  - Läser ett dataset med historiska mätvärden från automatiska sensorer i Chicago.
  - Skickar mätvärden löpande till backend via HTTP (`POST /api/v1/data/`) med en hemlig API‑nyckel.

- **Backend / API** (Django + Django REST Framework)
  - Tar emot mätdata och sparar i databasen.
  - Exponerar data via API‑endpoints för dashboard och ev. andra system.
  - Validerar API‑nyckel, begränsar trafik (rate limiting) och hanterar larmregler.

- **Databas** (PostgreSQL)
  - Lagrar alla sensoravläsningar, larmregler, larmhändelser och incidentrapporter.

- **Dashboard / Webbgränssnitt** (Django Templates)
  - Visar aktuell status, historiska grafer, sensorhälsa, larmregler och incidenter.
  - Har olika vyer baserat på användarens roll (Admin, Manager, Analyst, Viewer).

- **Övervakning**
  - Health endpoint på `/health/` för teknisk övervakning.
  - Kommandot `check_sensor_health` som kontrollerar om sensorer slutat skicka data.


2. Starta systemet (produktion med Docker)
------------------------------------------

Det här är det rekommenderade sättet för drift och demo.

### 2.1. Förbered `.env`

1. Kopiera filen `.env.example` till `.env` i projektroten:
   - På Windows: kopiera i Explorer eller via t.ex. `copy .env.example .env`.
2. Öppna `.env` och fyll i minst:

   ```env
   SECRET_KEY=<hemlig_django_nyckel>
   DEVICE_API_KEY=<hemlig_device_api_nyckel>

   DATABASE_URL=postgresql://smartenv:smartenv@db:5432/smart_env_monitor

   PROXY_HTTP_PORT=18080
   PROXY_HTTPS_PORT=18443

   SENSOR_STALE_MINUTES=30
   SENSOR_HEALTH_EMAIL_TO=
   ```

   Rekommenderat sätt att generera säkra nycklar:

   ```bash
   python -c "import secrets; print('SECRET_KEY=' + secrets.token_urlsafe(48)); print('DEVICE_API_KEY=' + secrets.token_urlsafe(32))"
   ```

   Kopiera värdena in i `.env`.

### 2.2. Starta Docker‑stacken

1. Starta **Docker Desktop**.
2. Öppna en terminal i projektmappen:

   ```bash
   cd c:\Jensen\LIA2\IoT_project\smart-env-monitor
   docker compose up -d --build
   ```

3. Kontrollera att containrarna är igång:

   ```bash
   docker compose ps
   ```

   Du ska se minst:
   - `db` (PostgreSQL)
   - `web` (Django/Gunicorn)
   - `proxy` (Caddy) på port 18080/18443

### 2.3. Skapa admin‑användare

1. Skapa en administratör:

   ```bash
   docker compose exec web python manage.py createsuperuser
   ```

2. Ange:
   - Användarnamn (t.ex. `admin`)
   - E‑postadress (måste vara giltig, t.ex. `admin@kommun.se`)
   - Lösenord (skrivs utan att synas; ange samma två gånger)

3. Logga in i admin via:

   - `http://localhost:18080/admin/`

### 2.4. Starta sensorsimulatorn

1. Öppna en **ny** terminal i projektroten.
2. Säkerställ att `.env` innehåller:

   ```env
   BACKEND_URL=http://localhost:18080/api/v1/data/
   SENSOR_ID=env-sensor-01
   SENSOR_INTERVAL=10
   DATASET_PATH=sensor/dataset/environment_data.csv
   DEVICE_API_KEY=<samma_nyckel_som_i_BACKEND>
   ```

3. Starta simulatorn:

   ```bash
   python sensor/simulator.py
   ```

4. Simulatorn skriver ut t.ex.:

   ```text
   Starting simulator. Target: http://localhost:18080/api/v1/data/

     Se dina grafer live här: http://localhost:18080/dashboard/

   Reading from: sensor/dataset/environment_data.csv
   Sent data for Ohio Street Beach: Temp=...
   ```


3. Dashboard – hur man läser av data
------------------------------------

### 3.1. Öppna dashboarden

Öppna webbläsaren och gå till:

- `http://localhost:18080/dashboard/`

Dashboarden kan läsas utan inloggning (publik vy). Inloggning behövs för vissa verktyg och rapportvyer.

### 3.2. Aktuella värden

Överst syns **aktuellt värde** för:
- Vattentemperatur (°C)
- Grumlighet (NTU)
- Våghöjd (m)
- Batterinivå (%)

Statusrutan (OK/varning) är en sammanfattning av kvalitetsbedömningen.

### 3.3. Historiska grafer

Mitt på sidan finns grafer för senaste 24 timmarna (eller ett valfritt intervall):
- X‑axel: tid
- Y‑axlar: temperatur, grumlighet, våghöjd m.m.

Man kan:
- Välja intervall (Från / Till) och klicka **Visa intervall**.
- Byta till live‑vy (24h) med knappen **Live (24h)**.

### 3.4. Sensorstatus (Stale/OK)

Längre ned finns en tabell **Sensorstatus**:

- Varje rad är en sensor (t.ex. en strand).
- Kolumner:
  - **Sensor** – sensor‑ID eller strandområde.
  - **Senast mottaget** – senaste tidpunkt då data kom in.
  - **Status** – OK eller Stale.
  - **Ålder** – hur många minuter sedan senaste mätning.

En sensor blir **Stale** om den inte rapporterat under `SENSOR_STALE_MINUTES` (default 30 min). Detta ger en snabb överblick över om någon sensor “dött” eller tappat anslutning.


4. Roller och behörigheter (RBAC)
---------------------------------

Systemet använder grupper i Django för att skilja på roller. De viktigaste rollerna:

- **Admin**
  - Full åtkomst.
  - Kan använda Django Admin (`/admin/`), skapa användare, ändra grupper och larmregler.

- **Manager**
  - Kan se managerspecifika rapportvyer, incidentlistor och exportera data.
  - Skyddade vyer:
    - `/dashboard/manager/`
    - `/dashboard/reports/`

- **Analyst**
  - Har tillgång till analysvyer (t.ex. `/dashboard/analyst/`) för djupare dataanalys.

- **Viewer**
  - Kan se dashboarden och all visualiserad data (read‑only).

Tekniskt:
- Gruppkontroller görs både i vyer och templates, via t.ex. `user|has_group:"Manager"` och `@user_passes_test(...)`.

Valfritt:
- Systemet kan även konfigureras för Single Sign-On (OIDC) (t.ex. via lokal Keycloak). Då sker inloggning via `/oidc/`.

### 4.1. Tilldela roller

1. Logga in som Admin på `/admin/`.
2. Gå till **Users**.
3. Öppna en användare.
4. Under **Groups** lägger du till t.ex.:
   - `Admin`
   - `Manager`
   - `Analyst`
   - `Viewer`
5. Spara.


5. Larmregler (Alert Rules)
---------------------------

Larmregler används för att automatiskt övervaka sensordata och skicka e‑post när vissa villkor uppfylls, t.ex.:
- “Grumlighet > 5 NTU på en viss strand”
- “Kvalitet = Poor”

### 5.1. Var finns larmreglerna?

Larmregler och larmhändelser finns i admin under:
- `/admin/api/alertrule/`
- `/admin/api/alertevent/`

De syns också sammanfattade i dashboardens nederdel:
- **Aktiva larmregler**
- **Senaste larmhändelser**

### 5.2. Skapa en ny larmregel (exempel)

1. Logga in som Admin.
2. Gå till `/admin/api/alertrule/` och klicka **Add Alert Rule**.
3. Fyll i t.ex.:
   - **Name:** `Hög grumlighet – Ohio Street Beach`
   - **Enabled:** ikryssad
   - **Sensor id:** lämna tomt för att gälla alla, eller sätt t.ex. `Ohio Street Beach`.
   - **Metric:** `Turbiditet (turbidity)`
   - **Operator:** `>` (gt)
   - **Threshold number:** t.ex. `5.0`
   - **Recipient email:** t.ex. `miljoansvarig@kommun.se`
   - **Cooldown minutes:** t.ex. `30` (minst 30 minuter mellan larm från samma regel)
4. Spara.

När nästa mätning kommer in som uppfyller villkoret (turbiditet > 5.0) kommer systemet:
- Skapa en **AlertEvent**.
- Försöka skicka ett e‑postmeddelande till angiven mottagare.

> Obs: För att e‑post ska fungera måste e‑postinställningar vara korrekt satta i `.env` (se nästa avsnitt).


6. E‑postinställningar
----------------------

För att larmregler och sensorhälsolarm ska kunna skicka e‑post behöver följande variabler i `.env` sättas:

```env
DEFAULT_FROM_EMAIL=smartenv@kommun.se
EMAIL_HOST=smtp.kommun.se
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=smartenv@kommun.se
EMAIL_HOST_PASSWORD=<lösenord_eller_app_lösenord>

SENSOR_HEALTH_EMAIL_TO=drift@kommun.se
```

Rekommendation:
- Använd ett dedikerat konto (t.ex. `smartenv@kommun.se`) med app‑lösenord.
- Testa sedan:

  ```bash
  docker compose exec web python manage.py check_sensor_health --stale-minutes 0 --email-to drift@kommun.se
  ```

  Detta tvingar fram ett testlarm (alla sensorer räknas som stale vid tröskel 0 min).


7. Övervakning och drift
------------------------

### 7.1. Health endpoint

Endpoint:
- `GET /health/`

Svarar:
- `200 OK` och JSON med status (t.ex. `{"status": "ok", "database": "connected"}`) när allt fungerar.
- `503 Service Unavailable` om backend inte kan nå databasen.

Användning:
- Kan kopplas till kommunens övervakningssystem (t.ex. ping var 30:e sekund).

### 7.2. Sensorhälsa (CLI‑kommando)

Kommandot:

```bash
docker compose exec web python manage.py check_sensor_health --stale-minutes 30 --email-to drift@kommun.se
```

Funktion:
- Räknar upp antal sensorer.
- Markerar vilka som är OK respektive Stale.
- Skickar e‑post om någon sensor är stale (om `--email-to` eller `SENSOR_HEALTH_EMAIL_TO` är satt).
- Kan kopplas till schemaläggare (cron, Windows Task Scheduler, etc.).


8. API‑översikt (för tekniker)
------------------------------

De viktigaste API‑endpoints:

- **Ingest (sensor → backend)**
  - `POST /api/v1/data/`
  - Auth: `X-Device-Key: <DEVICE_API_KEY>` eller `Authorization: Bearer <DEVICE_API_KEY>`
  - Rate limiting: `sensor_ingest` (t.ex. 120 anrop/minut).

- **Senaste värde**
  - `GET /api/v1/data/latest/?sensor_id=<id>`
  - Auth: ingen (publik läsning, men throttlad).
  - Rate limiting: `sensor_read`.

- **Historik**
  - `GET /api/v1/data/history/?sensor_id=<id>&from=YYYY-MM-DD&to=YYYY-MM-DD`
  - Auth: ingen (publik läsning, men throttlad).

- **Incidentexport**
  - `GET /api/v1/incidents/`
  - Auth: kräver Manager eller Admin.


9. Vanliga fel och lösningar
----------------------------

### 9.1. Dashboard visar 502 Bad Gateway

Orsak:
- `proxy` (Caddy) är igång, men `web`‑containern kraschar (ofta p.g.a. fel `DATABASE_URL`).

Åtgärd:
1. Kontrollera loggar:

   ```bash
   docker compose logs web
   ```

2. Kontrollera att `.env` har:

   ```env
   DATABASE_URL=postgresql://smartenv:smartenv@db:5432/smart_env_monitor
   ```

3. Starta om:

   ```bash
   docker compose up -d --build
   ```

### 9.2. Simulatorn visar “Connection Error”

Orsak:
- Backend svarar inte (web/proxy nere) eller fel `BACKEND_URL`.

Åtgärd:
- Kontrollera att Docker‑stacken är igång (`docker compose ps`).
- Kontrollera att `.env` har:

  ```env
  BACKEND_URL=http://localhost:18080/api/v1/data/
  ```

### 9.3. Simulatorn visar “Unauthorized”

Orsak:
- `DEVICE_API_KEY` i simulatorn matchar inte `DEVICE_API_KEY` i backend.

Åtgärd:
- Sätt samma värde i `.env`:

  ```env
  DEVICE_API_KEY=<samma_nyckel_i_backend_och_simulator>
  ```

### 9.4. `/api/v1/data/` visar “Method GET not allowed”

Orsak:
- Man öppnar endpointen i webbläsaren. Den är byggd för `POST` (sensor‑ingest), inte för `GET`.

Åtgärd:
- Detta är förväntat. Använd dashboarden (`/dashboard/`) eller läs‑API:et (`/api/v1/data/latest/`, `/api/v1/data/history/`) för att titta på data.


10. Sammanfattning
------------------

- Starta systemet: `.env` → `docker compose up -d --build`.
- Skapa admin: `docker compose exec web python manage.py createsuperuser`.
- Starta simulering: `python sensor/simulator.py`.
- Övervaka:
  - Dashboard: `http://localhost:18080/dashboard/`
  - Health: `http://localhost:18080/health/`
  - Sensorhälsa: `docker compose exec web python manage.py check_sensor_health`.
- Larm och regler:
  - Skapa larmregler i `/admin/api/alertrule/`.
  - Se larmhistorik i dashboardens nederdel och i `/admin/api/alertevent/`.

Med den här guiden ska både tekniska och verksamhetsnära användare kunna:
- Starta systemet
- Förstå vad de ser i dashboarden
- Använda roller och larmregler
- Förstå hur övervakning och drift fungerar

