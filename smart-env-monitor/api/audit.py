from __future__ import annotations

from django.contrib.auth.signals import user_logged_in, user_logged_out, user_login_failed
from django.dispatch import receiver

from api.models import SecurityAuditEvent


def _client_ip(request) -> str:
    if request is None:
        return ""
    forwarded = (request.headers.get("X-Forwarded-For") or "").strip()
    if forwarded:
        return forwarded.split(",")[0].strip()
    return (request.META.get("REMOTE_ADDR") or "").strip()


def log_security_event(*, event_type: str, request=None, actor=None, outcome: str = "", detail: str = "") -> None:
    path = (request.path if request is not None else "") or ""
    method = (request.method if request is not None else "") or ""
    user_agent = (request.headers.get("User-Agent") if request is not None else "") or ""
    SecurityAuditEvent.objects.create(
        event_type=event_type,
        actor=actor if getattr(actor, "is_authenticated", False) else None,
        outcome=outcome,
        detail=detail,
        path=path[:255],
        method=method[:10],
        ip_address=_client_ip(request)[:64],
        user_agent=user_agent[:255],
    )


@receiver(user_logged_in)
def on_user_logged_in(sender, request, user, **kwargs):
    log_security_event(
        event_type=SecurityAuditEvent.EventType.LOGIN_SUCCESS,
        request=request,
        actor=user,
        outcome="success",
    )


@receiver(user_logged_out)
def on_user_logged_out(sender, request, user, **kwargs):
    log_security_event(
        event_type=SecurityAuditEvent.EventType.LOGOUT,
        request=request,
        actor=user,
        outcome="success",
    )


@receiver(user_login_failed)
def on_user_login_failed(sender, credentials, request, **kwargs):
    username = (credentials or {}).get("username") or ""
    log_security_event(
        event_type=SecurityAuditEvent.EventType.LOGIN_FAILURE,
        request=request,
        outcome="denied",
        detail=f"username={username}",
    )
