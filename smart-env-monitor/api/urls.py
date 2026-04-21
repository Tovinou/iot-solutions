from django.urls import path

from .views import (
    DataExportView,
    IncidentReportExportView,
    LatestSensorReadingView,
    SensorDataView,
    SensorHistoryView,
)


app_name = "api"

urlpatterns = [
    path("v1/data/", SensorDataView.as_view(), name="sensor-data"),
    path("v1/data/latest/", LatestSensorReadingView.as_view(), name="latest-reading"),
    path("v1/data/history/", SensorHistoryView.as_view(), name="sensor-history"),
    path("v1/data/export/", DataExportView.as_view(), name="data-export"),
    path("v1/incidents/", IncidentReportExportView.as_view(), name="incident-export"),
    path("data/", SensorDataView.as_view(), name="sensor-data-legacy"),
    path("data/latest/", LatestSensorReadingView.as_view(), name="latest-reading-legacy"),
    path("data/history/", SensorHistoryView.as_view(), name="sensor-history-legacy"),
    path("data/export/", DataExportView.as_view(), name="data-export-legacy"),
    path("incidents/", IncidentReportExportView.as_view(), name="incident-export-legacy"),
]
