from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("api", "0006_sensorreading_indexes"),
    ]

    operations = [
        migrations.AddField(
            model_name="sensorreading",
            name="retention_days",
            field=models.PositiveIntegerField(default=365),
        ),
    ]
