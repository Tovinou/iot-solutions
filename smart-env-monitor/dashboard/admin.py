from django.contrib import admin

from .models import IncidentAuditLog, IncidentReport


@admin.register(IncidentReport)
class IncidentReportAdmin(admin.ModelAdmin):
    list_display = (
        "id",
        "title",
        "beach_name",
        "status",
        "assigned_to",
        "created_by",
        "created_at",
    )
    list_filter = ("status", "created_at")
    search_fields = ("title", "beach_name", "description", "created_by__username")


@admin.register(IncidentAuditLog)
class IncidentAuditLogAdmin(admin.ModelAdmin):
    list_display = ("id", "incident", "action", "actor", "created_at")
    list_filter = ("action", "created_at")
    search_fields = ("incident__title", "actor__username", "comment")
