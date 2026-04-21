from __future__ import annotations

from dataclasses import dataclass

from django.db.models import Q, QuerySet
from django.http import HttpRequest
from django.utils.dateparse import parse_date

from dashboard.models import IncidentReport


VALID_ORDERINGS = {
    "created_at",
    "-created_at",
    "updated_at",
    "-updated_at",
    "status",
    "-status",
}

VALID_STATUS = {
    IncidentReport.Status.OPEN,
    IncidentReport.Status.IN_PROGRESS,
    IncidentReport.Status.CLOSED,
}


@dataclass(frozen=True)
class IncidentFilters:
    status: str = ""
    from_date: str = ""
    to_date: str = ""
    query: str = ""
    beach: str = ""
    mine: str = ""
    assigned: str = ""
    ordering: str = ""


def incident_filters_from_request(request: HttpRequest) -> IncidentFilters:
    params = request.GET
    return IncidentFilters(
        status=(params.get("status") or "").strip(),
        from_date=(params.get("from") or "").strip(),
        to_date=(params.get("to") or "").strip(),
        query=(params.get("q") or "").strip(),
        beach=(params.get("beach") or "").strip(),
        mine=(params.get("mine") or "").strip(),
        assigned=(params.get("assigned") or "").strip(),
        ordering=(params.get("ordering") or "").strip(),
    )


def apply_incident_filters(
    queryset: QuerySet[IncidentReport],
    filters: IncidentFilters,
    *,
    user=None,
    include_user_flags: bool = True,
) -> QuerySet[IncidentReport]:
    qs = queryset

    if filters.status in VALID_STATUS:
        qs = qs.filter(status=filters.status)

    from_date = parse_date(filters.from_date)
    if from_date:
        qs = qs.filter(created_at__date__gte=from_date)

    to_date = parse_date(filters.to_date)
    if to_date:
        qs = qs.filter(created_at__date__lte=to_date)

    if filters.beach:
        qs = qs.filter(beach_name__icontains=filters.beach)

    if filters.query:
        qs = qs.filter(Q(title__icontains=filters.query) | Q(description__icontains=filters.query))

    if include_user_flags and user is not None:
        if filters.mine == "1":
            qs = qs.filter(created_by=user)
        if filters.assigned == "1":
            qs = qs.filter(assigned_to=user)

    if filters.ordering in VALID_ORDERINGS:
        qs = qs.order_by(filters.ordering)

    return qs
