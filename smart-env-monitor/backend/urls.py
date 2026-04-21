"""
URL configuration for backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/6.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.contrib import admin
from django.db import connections
from django.http import HttpResponse
from django.http import JsonResponse
from django.urls import include, path
from django.utils import timezone
from django.views.generic import RedirectView
from rest_framework import permissions
from drf_yasg import openapi
from drf_yasg.views import get_schema_view
from django_prometheus.exports import ExportToDjangoView


def health(request):
    db_ok = True
    db_error = ""
    try:
        conn = connections["default"]
        conn.ensure_connection()
        with conn.cursor() as cursor:
            cursor.execute("SELECT 1;")
            cursor.fetchone()
    except Exception as e:
        db_ok = False
        db_error = f"{type(e).__name__}: {e}"
    payload = {
        "status": "ok" if db_ok else "degraded",
        "db": "ok" if db_ok else "error",
        "db_error": db_error,
        "time": timezone.now().isoformat(),
    }
    return JsonResponse(payload, status=200 if db_ok else 503)


schema_view = get_schema_view(
    openapi.Info(
        title="Smart Env Monitor API",
        default_version="v1",
        description="API for environmental monitoring",
    ),
    public=True,
    permission_classes=[permissions.AllowAny],
)


urlpatterns = [
    path("admin/", admin.site.urls),
    path("accounts/", include("django.contrib.auth.urls")),
    path("mfa/", include("mfa.urls")),
    path("api/", include("api.urls")),
    path("swagger/", schema_view.with_ui("swagger", cache_timeout=0), name="schema-swagger-ui"),
    path("metrics/", ExportToDjangoView, name="prometheus-django-metrics"),
    path("dashboard/", include("dashboard.urls")),
    path("health/", health),
    path("", RedirectView.as_view(url="/dashboard/", permanent=False)),
]

if getattr(settings, "OIDC_ENABLED", False):
    urlpatterns.insert(2, path("oidc/", include("mozilla_django_oidc.urls")))
