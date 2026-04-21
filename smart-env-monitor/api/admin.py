from django.contrib import admin

from .models import AlertEvent, AlertRule, SecurityAuditEvent, SensorReading


@admin.register(SensorReading)
class SensorReadingAdmin(admin.ModelAdmin):
    list_display = ("id", "sensor_id", "timestamp", "water_temperature", "turbidity", "quality")
    list_filter = ("sensor_id", "quality")
    search_fields = ("sensor_id",)


@admin.register(AlertRule)
class AlertRuleAdmin(admin.ModelAdmin):
    list_display = (
        "id",
        "name",
        "enabled",
        "sensor_id",
        "metric",
        "operator",
        "threshold_number",
        "threshold_text",
        "cooldown_minutes",
        "last_triggered_at",
    )
    list_filter = ("enabled", "metric", "operator")
    search_fields = ("name", "sensor_id", "recipient_email")


@admin.register(AlertEvent)
class AlertEventAdmin(admin.ModelAdmin):
    list_display = ("id", "rule", "reading", "to_email", "triggered_at")
    list_filter = ("triggered_at", "rule")
    search_fields = ("rule__name", "reading__sensor_id", "to_email", "subject", "body")


@admin.register(SecurityAuditEvent)
class SecurityAuditEventAdmin(admin.ModelAdmin):
    list_display = ("id", "event_type", "actor", "outcome", "path", "ip_address", "created_at")
    list_filter = ("event_type", "outcome", "created_at")
    search_fields = ("actor__username", "path", "ip_address", "detail", "user_agent")
