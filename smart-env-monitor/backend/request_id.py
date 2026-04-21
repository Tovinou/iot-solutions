from __future__ import annotations

import contextvars
import uuid


request_id_ctx: contextvars.ContextVar[str] = contextvars.ContextVar("request_id", default="-")


def get_request_id() -> str:
    return request_id_ctx.get()


class RequestIDMiddleware:
    """Attach a request ID to context and response headers."""

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        incoming = (request.headers.get("X-Request-ID") or "").strip()
        request_id = incoming or str(uuid.uuid4())
        token = request_id_ctx.set(request_id)
        request.request_id = request_id
        try:
            response = self.get_response(request)
            response["X-Request-ID"] = request_id
            return response
        finally:
            request_id_ctx.reset(token)


class RequestIDLogFilter:
    """Inject request ID into every log record."""

    def filter(self, record):
        record.request_id = get_request_id()
        return True
