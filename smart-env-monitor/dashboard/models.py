from django.db import models
from django.conf import settings

class IncidentReport(models.Model):
    class Status(models.TextChoices):
        OPEN = "OPEN", "Öppen"
        IN_PROGRESS = "IN_PROGRESS", "Pågår"
        CLOSED = "CLOSED", "Stängd"

    title = models.CharField(max_length=120)
    beach_name = models.CharField(max_length=120)
    description = models.TextField()
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.OPEN)
    assigned_to = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="assigned_incident_reports",
    )
    closed_comment = models.TextField(blank=True, default="")
    closed_at = models.DateTimeField(null=True, blank=True)
    created_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="incident_reports",
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.title} ({self.status})"


class IncidentAuditLog(models.Model):
    class Action(models.TextChoices):
        CREATED = "CREATED", "Skapad"
        STATUS_CHANGED = "STATUS_CHANGED", "Status ändrad"
        ASSIGNED = "ASSIGNED", "Tilldelad"

    incident = models.ForeignKey(
        IncidentReport, on_delete=models.CASCADE, related_name="audit_logs"
    )
    action = models.CharField(max_length=40, choices=Action.choices)
    actor = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="incident_audit_logs",
    )
    from_status = models.CharField(
        max_length=20, choices=IncidentReport.Status.choices, blank=True, default=""
    )
    to_status = models.CharField(
        max_length=20, choices=IncidentReport.Status.choices, blank=True, default=""
    )
    from_assigned_to = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="incident_audit_from_assignments",
    )
    to_assigned_to = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="incident_audit_to_assignments",
    )
    comment = models.TextField(blank=True, default="")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-created_at"]
