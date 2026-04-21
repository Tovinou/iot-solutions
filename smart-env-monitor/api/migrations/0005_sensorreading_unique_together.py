from django.db import migrations
from django.db.models import Count, Max


def dedupe_sensorreadings(apps, schema_editor):
    SensorReading = apps.get_model("api", "SensorReading")

    duplicates = (
        SensorReading.objects.values("sensor_id", "timestamp")
        .annotate(cnt=Count("id"), keep_id=Max("id"))
        .filter(cnt__gt=1)
    )

    for row in duplicates.iterator():
        SensorReading.objects.filter(
            sensor_id=row["sensor_id"],
            timestamp=row["timestamp"],
        ).exclude(id=row["keep_id"]).delete()


class Migration(migrations.Migration):
    atomic = False

    dependencies = [
        ("api", "0004_securityauditevent"),
    ]

    operations = [
        migrations.RunSQL(
            sql="DROP INDEX IF EXISTS api_sensorreading_sensor_id_timestamp_3bd478e5_uniq;",
            reverse_sql=migrations.RunSQL.noop,
        ),
        migrations.RunPython(dedupe_sensorreadings, reverse_code=migrations.RunPython.noop),
        migrations.AlterUniqueTogether(
            name="sensorreading",
            unique_together={("sensor_id", "timestamp")},
        ),
    ]
