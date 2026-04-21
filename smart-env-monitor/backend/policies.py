from __future__ import annotations

from django.contrib.auth.decorators import user_passes_test
from rest_framework.permissions import BasePermission


def is_manager(user) -> bool:
    return bool(user and user.is_authenticated and (user.is_superuser or user.groups.filter(name="Manager").exists()))


def is_analyst(user) -> bool:
    return bool(user and user.is_authenticated and (user.is_superuser or user.groups.filter(name="Analyst").exists()))


def is_viewer(user) -> bool:
    return bool(user and user.is_authenticated and (user.is_superuser or user.groups.filter(name="Viewer").exists()))


def is_authenticated(user) -> bool:
    return bool(user and user.is_authenticated)


manager_required = user_passes_test(is_manager)
analyst_required = user_passes_test(is_analyst)
viewer_required = user_passes_test(is_viewer)
login_required = user_passes_test(is_authenticated)


class IsManagerOrAdmin(BasePermission):
    message = "Forbidden"

    def has_permission(self, request, view):
        allowed = is_manager(request.user)
        if not allowed:
            # Lazy import avoids app-loading import cycles.
            from api.audit import log_security_event
            from api.models import SecurityAuditEvent

            log_security_event(
                event_type=SecurityAuditEvent.EventType.ACCESS_DENIED,
                request=request,
                actor=request.user,
                outcome="denied",
                detail=f"view={view.__class__.__name__}",
            )
        return allowed


class IsAnalystOrAdmin(BasePermission):
    message = "Forbidden"

    def has_permission(self, request, view):
        return is_analyst(request.user)


class IsAuthenticatedUser(BasePermission):
    message = "Unauthorized"

    def has_permission(self, request, view):
        return is_authenticated(request.user)
