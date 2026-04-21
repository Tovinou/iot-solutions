import csv
import io

import pandas as pd
from django import forms
from django.contrib import messages
from django.contrib.auth import get_user_model
from django.db import models
from django.db.models import Max
from django.shortcuts import redirect, render
from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.urls import reverse
from django.utils import timezone

from backend.policies import analyst_required, manager_required
from backend.services.notifications import send_email_safe
from .models import IncidentAuditLog, IncidentReport
from .services.incidents import apply_incident_filters, incident_filters_from_request


class IncidentReportForm(forms.ModelForm):
    class Meta:
        model = IncidentReport
        fields = ["title", "beach_name", "description"]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs.update({"class": "form-control"})
        self.fields["description"].widget.attrs.update({"rows": 5})

    def clean_title(self):
        title = (self.cleaned_data.get("title") or "").strip()
        if len(title) < 5:
            raise forms.ValidationError("Rubriken måste vara minst 5 tecken.")
        return title

    def clean_beach_name(self):
        beach_name = (self.cleaned_data.get("beach_name") or "").strip()
        if len(beach_name) < 3:
            raise forms.ValidationError("Badplats måste vara minst 3 tecken.")
        return beach_name

    def clean_description(self):
        description = (self.cleaned_data.get("description") or "").strip()
        if len(description) < 15:
            raise forms.ValidationError("Beskrivningen måste vara minst 15 tecken.")
        return description


class IncidentReportStatusForm(forms.Form):
    status = forms.ChoiceField(choices=IncidentReport.Status.choices)
    assigned_to = forms.ModelChoiceField(queryset=None, required=False)
    close_comment = forms.CharField(required=False, widget=forms.Textarea)

    def __init__(self, *args, **kwargs):
        report = kwargs.pop("report", None)
        super().__init__(*args, **kwargs)
        self.fields["status"].widget.attrs.update({"class": "form-select"})
        self.fields["assigned_to"].queryset = get_user_model().objects.order_by("username")
        self.fields["assigned_to"].widget.attrs.update({"class": "form-select"})
        self.fields["close_comment"].widget.attrs.update({"class": "form-control", "rows": 2})
        self.report = report

        if report is not None:
            self.fields["status"].initial = report.status
            self.fields["assigned_to"].initial = report.assigned_to_id
            self.fields["close_comment"].initial = report.closed_comment

    def clean(self):
        cleaned = super().clean()
        if self.report is None:
            return cleaned

        current_status = self.report.status
        next_status = cleaned.get("status")
        close_comment = (cleaned.get("close_comment") or "").strip()

        if current_status == IncidentReport.Status.CLOSED and next_status != IncidentReport.Status.CLOSED:
            raise forms.ValidationError("Stängda ärenden kan inte återöppnas i detta flöde.")

        allowed = {
            IncidentReport.Status.OPEN: {
                IncidentReport.Status.OPEN,
                IncidentReport.Status.IN_PROGRESS,
                IncidentReport.Status.CLOSED,
            },
            IncidentReport.Status.IN_PROGRESS: {
                IncidentReport.Status.IN_PROGRESS,
                IncidentReport.Status.CLOSED,
            },
            IncidentReport.Status.CLOSED: {IncidentReport.Status.CLOSED},
        }

        if next_status not in allowed.get(current_status, set()):
            raise forms.ValidationError("Otillåten statusändring för detta ärende.")

        if next_status == IncidentReport.Status.CLOSED and len(close_comment) < 10:
            raise forms.ValidationError(
                "När du stänger ett ärende måste du ange en kort åtgärds-/beslutstext (minst 10 tecken)."
            )

        cleaned["close_comment"] = close_comment
        return cleaned


def index(request):
    from api.models import AlertEvent, AlertRule
    from api.models import SensorReading

    recent_events = (
        AlertEvent.objects.select_related("rule", "reading").order_by("-triggered_at")[
            :20
        ]
    )
    recent_events_display = []
    for event in recent_events:
        metric = event.rule.metric
        value = getattr(event.reading, metric, None)
        threshold_display = (
            event.rule.threshold_text
            if metric == AlertRule.Metric.QUALITY
            else event.rule.threshold_number
        )
        recent_events_display.append(
            {
                "triggered_at": event.triggered_at,
                "rule_name": event.rule.name,
                "sensor_id": event.reading.sensor_id,
                "metric_label": event.rule.get_metric_display(),
                "operator_label": event.rule.get_operator_display(),
                "threshold": threshold_display,
                "value": value,
                "to_email": event.to_email,
                "subject": event.subject,
            }
        )

    rules = AlertRule.objects.filter(enabled=True).order_by("name")
    rules_display = []
    for rule in rules:
        threshold_display = (
            rule.threshold_text
            if rule.metric == AlertRule.Metric.QUALITY
            else rule.threshold_number
        )
        rules_display.append(
            {
                "name": rule.name,
                "sensor_id": rule.sensor_id,
                "metric_label": rule.get_metric_display(),
                "operator_label": rule.get_operator_display(),
                "threshold": threshold_display,
                "cooldown_minutes": rule.cooldown_minutes,
                "last_triggered_at": rule.last_triggered_at,
                "recipient_email": rule.recipient_email
                or (rule.recipient_user.email if rule.recipient_user else ""),
            }
        )

    now = timezone.now()
    stale_minutes = int(getattr(settings, "SENSOR_STALE_MINUTES", 30))
    sensor_status = []
    sensors = (
        SensorReading.objects.values("sensor_id")
        .annotate(last_seen=Max("timestamp"))
        .order_by("sensor_id")
    )
    for row in sensors:
        last_seen = row.get("last_seen")
        age_minutes = None
        is_stale = True
        if last_seen:
            age_minutes = int((now - last_seen).total_seconds() // 60)
            is_stale = age_minutes > stale_minutes
        sensor_status.append(
            {
                "sensor_id": row.get("sensor_id"),
                "last_seen": last_seen,
                "age_minutes": age_minutes,
                "is_stale": is_stale,
            }
        )

    return render(
        request,
        "dashboard/index.html",
        {
            "threshold": settings.THRESHOLD_VALUE,
            "alert_rules": rules_display,
            "alert_events": recent_events_display,
            "sensor_status": sensor_status,
            "sensor_stale_minutes": stale_minutes,
        },
    )

@login_required
@manager_required
def manager_report(request):
    return render(request, 'dashboard/manager_report.html')

@login_required
@analyst_required
def analyst_tool(request):
    return render(request, 'dashboard/analyst_tool.html')


@login_required
def incident_report_create(request):
    if request.method == "POST":
        form = IncidentReportForm(request.POST)
        if form.is_valid():
            report = form.save(commit=False)
            report.created_by = request.user
            report.save()
            IncidentAuditLog.objects.create(
                incident=report,
                action=IncidentAuditLog.Action.CREATED,
                actor=request.user,
                to_status=report.status,
            )

            manager_emails = list(
                get_user_model()
                .objects.filter(groups__name="Manager")
                .exclude(email="")
                .values_list("email", flat=True)
                .distinct()
            )
            if manager_emails:
                send_email_safe(
                    subject=f"Nytt ärende rapporterat (ID {report.id})",
                    message=(
                        f"Ärende: {report.title}\n"
                        f"Badplats: {report.beach_name}\n"
                        f"Skapat av: {request.user.username}\n"
                    ),
                    recipient_list=manager_emails,
                    fail_silently=True,
                )
            return redirect(
                f"{reverse('incident_report_create')}?submitted=1&report_id={report.id}"
            )
    else:
        form = IncidentReportForm()
    submitted = request.GET.get("submitted") == "1"
    report_id = request.GET.get("report_id")
    report = None
    if submitted and (report_id or "").isdigit():
        report = IncidentReport.objects.filter(
            id=int(report_id), created_by=request.user
        ).first()
    return render(
        request,
        "dashboard/incident_report_form.html",
        {"form": form, "submitted": submitted, "report": report},
    )


@login_required
@manager_required
def incident_report_list(request):
    reports = get_incident_queryset_from_request(request).select_related(
        "created_by", "assigned_to"
    ).prefetch_related("audit_logs__actor")
    return render(
        request,
        "dashboard/incident_report_list.html",
        {
            "reports": reports,
            "filters": {
                "status": request.GET.get("status", ""),
                "from": request.GET.get("from", ""),
                "to": request.GET.get("to", ""),
                "q": request.GET.get("q", ""),
                "beach": request.GET.get("beach", ""),
                "mine": request.GET.get("mine", ""),
                "assigned": request.GET.get("assigned", ""),
                "ordering": request.GET.get("ordering", ""),
            },
            "users": get_user_model().objects.order_by("username"),
        },
    )


@login_required
@manager_required
def incident_report_update_status(request, report_id: int):
    report = IncidentReport.objects.select_related("created_by", "assigned_to").filter(
        id=report_id
    ).first()
    if not report:
        return redirect(reverse("incident_report_list"))

    if request.method != "POST":
        return redirect(reverse("incident_report_list"))

    form = IncidentReportStatusForm(request.POST, report=report)
    if form.is_valid():
        previous_status = report.status
        previous_assigned_to_id = report.assigned_to_id

        next_status = form.cleaned_data["status"]
        next_assigned_to = form.cleaned_data["assigned_to"]
        close_comment = form.cleaned_data["close_comment"]

        update_fields = ["updated_at"]

        if previous_assigned_to_id != (next_assigned_to.id if next_assigned_to else None):
            report.assigned_to = next_assigned_to
            update_fields.append("assigned_to")
            IncidentAuditLog.objects.create(
                incident=report,
                action=IncidentAuditLog.Action.ASSIGNED,
                actor=request.user,
                from_assigned_to_id=previous_assigned_to_id,
                to_assigned_to_id=(next_assigned_to.id if next_assigned_to else None),
            )

            if next_assigned_to and next_assigned_to.email:
                send_email_safe(
                    subject=f"Du har blivit tilldelad ett ärende (ID {report.id})",
                    message=(
                        f"Ärende: {report.title}\n"
                        f"Badplats: {report.beach_name}\n"
                        f"Status: {report.status}\n"
                        f"Skapad: {report.created_at:%Y-%m-%d %H:%M}\n"
                    ),
                    recipient_list=[next_assigned_to.email],
                    fail_silently=True,
                )

        if previous_status != next_status:
            report.status = next_status
            update_fields.append("status")

            if next_status == IncidentReport.Status.CLOSED:
                report.closed_comment = close_comment
                report.closed_at = timezone.now()
                update_fields.extend(["closed_comment", "closed_at"])

            IncidentAuditLog.objects.create(
                incident=report,
                action=IncidentAuditLog.Action.STATUS_CHANGED,
                actor=request.user,
                from_status=previous_status,
                to_status=next_status,
                comment=close_comment,
            )

            if report.created_by and report.created_by.email:
                send_email_safe(
                    subject=f"Status uppdaterad för ärende (ID {report.id})",
                    message=(
                        f"Ärende: {report.title}\n"
                        f"Badplats: {report.beach_name}\n"
                        f"Ny status: {next_status}\n"
                        f"Kommentar: {close_comment or '—'}\n"
                    ),
                    recipient_list=[report.created_by.email],
                    fail_silently=True,
                )

        report.save(update_fields=sorted(set(update_fields)))
        messages.success(request, "Ärendet uppdaterades.")
        return redirect(reverse("incident_report_list"))

    non_field = form.errors.get("__all__") or form.non_field_errors() or ["Ogiltiga värden."]
    messages.error(
        request,
        "Kunde inte uppdatera ärendet: " + "; ".join([str(e) for e in non_field]),
    )
    return redirect(reverse("incident_report_list"))


def get_incident_queryset_from_request(request):
    filters = incident_filters_from_request(request)
    return apply_incident_filters(IncidentReport.objects.all(), filters, user=request.user)


@login_required
@manager_required
def incident_report_export_csv(request):
    qs = get_incident_queryset_from_request(request).select_related("created_by", "assigned_to")
    output = io.StringIO()
    writer = csv.writer(output)
    writer.writerow(
        [
            "id",
            "status",
            "title",
            "beach_name",
            "assigned_to",
            "created_by",
            "created_at",
            "updated_at",
            "closed_at",
            "closed_comment",
        ]
    )
    for r in qs:
        writer.writerow(
            [
                r.id,
                r.status,
                r.title,
                r.beach_name,
                (r.assigned_to.username if r.assigned_to else ""),
                (r.created_by.username if r.created_by else ""),
                r.created_at.isoformat(),
                r.updated_at.isoformat(),
                (r.closed_at.isoformat() if r.closed_at else ""),
                r.closed_comment,
            ]
        )

    response = HttpResponse(output.getvalue(), content_type="text/csv; charset=utf-8")
    response["Content-Disposition"] = 'attachment; filename="incident_reports.csv"'
    return response


@login_required
@manager_required
def incident_report_export_xlsx(request):
    qs = get_incident_queryset_from_request(request).select_related("created_by", "assigned_to")
    rows = []
    for r in qs:
        rows.append(
            {
                "id": r.id,
                "status": r.status,
                "title": r.title,
                "beach_name": r.beach_name,
                "assigned_to": (r.assigned_to.username if r.assigned_to else ""),
                "created_by": (r.created_by.username if r.created_by else ""),
                "created_at": r.created_at,
                "updated_at": r.updated_at,
                "closed_at": r.closed_at,
                "closed_comment": r.closed_comment,
            }
        )

    df = pd.DataFrame(rows)
    buffer = io.BytesIO()
    try:
        df.to_excel(buffer, index=False, engine="openpyxl")
    except Exception:
        messages.error(request, "Excel-export kräver att openpyxl är installerat.")
        return redirect(reverse("incident_report_list"))
    buffer.seek(0)

    response = HttpResponse(
        buffer.getvalue(),
        content_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    )
    response["Content-Disposition"] = 'attachment; filename="incident_reports.xlsx"'
    return response


@login_required
@manager_required
def incident_report_export_pdf(request):
    try:
        from reportlab.lib.pagesizes import A4
        from reportlab.pdfgen import canvas
    except Exception:
        messages.error(request, "PDF-export kräver att reportlab är installerat.")
        return redirect(reverse("incident_report_list"))

    qs = get_incident_queryset_from_request(request)
    total = qs.count()
    open_count = qs.filter(status=IncidentReport.Status.OPEN).count()
    in_progress_count = qs.filter(status=IncidentReport.Status.IN_PROGRESS).count()
    closed_count = qs.filter(status=IncidentReport.Status.CLOSED).count()

    top_beaches = (
        qs.values("beach_name")
        .annotate(count=models.Count("id"))
        .order_by("-count", "beach_name")[:5]
    )

    response = HttpResponse(content_type="application/pdf")
    response["Content-Disposition"] = 'attachment; filename="incident_report_summary.pdf"'

    c = canvas.Canvas(response, pagesize=A4)
    width, height = A4

    y = height - 60
    c.setFont("Helvetica-Bold", 16)
    c.drawString(50, y, "Ärenderapport - sammanställning")

    y -= 30
    c.setFont("Helvetica", 11)
    c.drawString(50, y, f"Genererad: {timezone.now():%Y-%m-%d %H:%M}")
    y -= 18
    c.drawString(50, y, f"Totalt: {total}")
    y -= 18
    c.drawString(50, y, f"Öppna: {open_count}   Pågår: {in_progress_count}   Stängda: {closed_count}")

    y -= 28
    c.setFont("Helvetica-Bold", 12)
    c.drawString(50, y, "Top 5 badplatser (flest ärenden)")
    y -= 18
    c.setFont("Helvetica", 11)
    for row in top_beaches:
        c.drawString(60, y, f"- {row['beach_name']}: {row['count']}")
        y -= 16

    y -= 24
    c.setFont("Helvetica-Bold", 12)
    c.drawString(50, y, "Senaste ärenden (max 20)")
    y -= 18
    c.setFont("Helvetica", 9)

    for r in qs.order_by("-created_at")[:20]:
        line = f"#{r.id} [{r.status}] {r.beach_name} - {r.title}"
        if y < 60:
            c.showPage()
            y = height - 60
            c.setFont("Helvetica", 9)
        c.drawString(50, y, line[:110])
        y -= 14

    c.showPage()
    c.save()
    return response
