from celery import shared_task
from django.core.management import call_command

from api.models import SensorReading
from api.services.alerts import evaluate_alert_rules
from api.services.kafka import publish_event

@shared_task(name="api.tasks.check_sensor_health")
def check_sensor_health():
    call_command("check_sensor_health")


@shared_task
def evaluate_alert_rules_task(reading_id):
    try:
        reading = SensorReading.objects.get(id=reading_id)
        evaluate_alert_rules(reading)
    except SensorReading.DoesNotExist:
        pass


@shared_task
def publish_sensor_reading_task(reading_id):
    try:
        reading = SensorReading.objects.get(id=reading_id)
    except SensorReading.DoesNotExist:
        return

    publish_event(
        "sensor.readings",
        {
            "id": reading.id,
            "sensor_id": reading.sensor_id,
            "timestamp": reading.timestamp.isoformat(),
            "temperature": reading.temperature,
            "humidity": reading.humidity,
            "air_quality": reading.air_quality,
        },
    )
