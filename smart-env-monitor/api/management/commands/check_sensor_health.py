from django.conf import settings
from django.core.management.base import BaseCommand
from django.db.models import Max
from django.utils import timezone

from api.models import SensorReading
from backend.services.notifications import send_email_task


class Command(BaseCommand):
    help = "Checks sensor freshness and optionally sends an email if any sensors are stale."

    def add_arguments(self, parser):
        parser.add_argument("--stale-minutes", type=int, default=None)
        parser.add_argument("--email-to", type=str, default=None)
        parser.add_argument("--fail-on-stale", action="store_true")

    def handle(self, *args, **options):
        now = timezone.now()
        stale_minutes = (
            options["stale_minutes"]
            if options["stale_minutes"] is not None
            else int(getattr(settings, "SENSOR_STALE_MINUTES", 30))
        )
        email_to = (
            (options["email_to"] or "").strip()
            if options["email_to"] is not None
            else (getattr(settings, "SENSOR_HEALTH_EMAIL_TO", "") or "").strip()
        )

        sensors = (
            SensorReading.objects.values("sensor_id")
            .annotate(last_seen=Max("timestamp"))
            .order_by("sensor_id")
        )

        stale = []
        ok = []
        for row in sensors:
            sensor_id = row.get("sensor_id")
            last_seen = row.get("last_seen")
            age_minutes = None
            is_stale = True
            if last_seen:
                age_minutes = int((now - last_seen).total_seconds() // 60)
                is_stale = age_minutes > stale_minutes
            entry = {
                "sensor_id": sensor_id,
                "last_seen": last_seen,
                "age_minutes": age_minutes,
            }
            if is_stale:
                stale.append(entry)
            else:
                ok.append(entry)

        self.stdout.write(f"Total sensors: {len(ok) + len(stale)}")
        self.stdout.write(f"OK sensors: {len(ok)}")
        self.stdout.write(f"Stale sensors: {len(stale)} (threshold: {stale_minutes} min)")

        if stale:
            lines = [
                f"Sensor health report ({now.isoformat()}), stale threshold: {stale_minutes} min",
                "",
                "STALE SENSORS:",
            ]
            for s in stale:
                last_seen_text = s["last_seen"].isoformat() if s["last_seen"] else "-"
                age_text = f"{s['age_minutes']} min" if s["age_minutes"] is not None else "-"
                lines.append(f"- {s['sensor_id']}: last_seen={last_seen_text}, age={age_text}")
            body = "\n".join(lines)
            self.stdout.write(body)

            if email_to:
                send_email_task.delay(
                    subject="Sensor health: stale sensors detected",
                    message=body,
                    recipient_list=[email_to],
                )
                self.stdout.write(f"Notification sent to: {email_to}")

            if options["fail_on_stale"]:
                raise SystemExit(2)
        else:
            self.stdout.write("All sensors are within freshness threshold.")
