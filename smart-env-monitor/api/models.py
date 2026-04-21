from django.db import models
from django.conf import settings
from django.utils import timezone


class SensorReading(models.Model):
    sensor_id = models.CharField(max_length=100)
    timestamp = models.DateTimeField(db_index=True)
    water_temperature = models.FloatField(null=True, blank=True)
    turbidity = models.FloatField(null=True, blank=True)
    wave_height = models.FloatField(null=True, blank=True)
    wave_period = models.FloatField(null=True, blank=True)
    battery_life = models.FloatField(null=True, blank=True)
    quality = models.CharField(max_length=50, default="OK")
    retention_days = models.PositiveIntegerField(default=365)

    class Meta:
        unique_together = [['sensor_id', 'timestamp']]
        indexes = [
            models.Index(fields=['sensor_id', 'timestamp'], name='api_sensorr_sensor__9238f9_idx'),
            models.Index(fields=['timestamp'], name='api_sensorr_timesta_7d4e8f_idx'),
        ]

    def __str__(self):
        return f"{self.sensor_id} - {self.timestamp} - {self.water_temperature}°C"


class AlertRule(models.Model):
    class Metric(models.TextChoices):
        WATER_TEMPERATURE = "water_temperature", "Vattentemperatur"
        TURBIDITY = "turbidity", "Turbiditet"
        WAVE_HEIGHT = "wave_height", "Våghöjd"
        WAVE_PERIOD = "wave_period", "Vågperiod"
        BATTERY_LIFE = "battery_life", "Batteri"
        QUALITY = "quality", "Kvalitet"

    class Operator(models.TextChoices):
        GT = "gt", ">"
        GTE = "gte", ">="
        LT = "lt", "<"
        LTE = "lte", "<="
        EQ = "eq", "="

    name = models.CharField(max_length=120)
    enabled = models.BooleanField(default=True)

    sensor_id = models.CharField(max_length=100, blank=True, default="")
    metric = models.CharField(max_length=40, choices=Metric.choices)
    operator = models.CharField(max_length=8, choices=Operator.choices, default=Operator.GT)

    threshold_number = models.FloatField(null=True, blank=True)
    threshold_text = models.CharField(max_length=80, blank=True, default="")

    recipient_user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="alert_rules",
    )
    recipient_email = models.EmailField(blank=True, default="")

    cooldown_minutes = models.PositiveIntegerField(default=15)
    last_triggered_at = models.DateTimeField(null=True, blank=True)

    subject_template = models.CharField(
        max_length=200, default="Larm från Smart Env Monitor: {name}"
    )
    body_template = models.TextField(
        default=(
            "Regel: {name}\n"
            "Sensor: {sensor_id}\n"
            "Tid: {timestamp}\n"
            "Mätvärde: {metric} = {value}\n"
            "Villkor: {metric} {operator} {threshold}\n"
        )
    )

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["name"]

    def __str__(self):
        return self.name

    def is_in_cooldown(self, now=None):
        if not self.last_triggered_at:
            return False
        now = now or timezone.now()
        return now < self.last_triggered_at + timezone.timedelta(minutes=self.cooldown_minutes)


class AlertEvent(models.Model):
    rule = models.ForeignKey(AlertRule, on_delete=models.CASCADE, related_name="events")
    reading = models.ForeignKey(
        SensorReading, on_delete=models.CASCADE, related_name="alert_events"
    )
    triggered_at = models.DateTimeField(auto_now_add=True)
    to_email = models.EmailField(blank=True, default="")
    subject = models.CharField(max_length=200)
    body = models.TextField()

    class Meta:
        ordering = ["-triggered_at"]


class SecurityAuditEvent(models.Model):
    class EventType(models.TextChoices):
        LOGIN_SUCCESS = "LOGIN_SUCCESS", "Login success"
        LOGIN_FAILURE = "LOGIN_FAILURE", "Login failure"
        LOGOUT = "LOGOUT", "Logout"
        ACCESS_DENIED = "ACCESS_DENIED", "Access denied"
        EXPORT_INCIDENTS = "EXPORT_INCIDENTS", "Export incidents"

    event_type = models.CharField(max_length=40, choices=EventType.choices, db_index=True)
    actor = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="security_audit_events",
    )
    outcome = models.CharField(max_length=20, blank=True, default="")
    detail = models.TextField(blank=True, default="")
    path = models.CharField(max_length=255, blank=True, default="")
    method = models.CharField(max_length=10, blank=True, default="")
    ip_address = models.CharField(max_length=64, blank=True, default="")
    user_agent = models.CharField(max_length=255, blank=True, default="")
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.event_type} @ {self.created_at:%Y-%m-%d %H:%M:%S}"
