from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='dashboard'),
    path('manager/', views.manager_report, name='manager_report'),
    path('analyst/', views.analyst_tool, name='analyst_tool'),
    path("report/", views.incident_report_create, name="incident_report_create"),
    path("reports/", views.incident_report_list, name="incident_report_list"),
    path("reports/export/csv/", views.incident_report_export_csv, name="incident_report_export_csv"),
    path("reports/export/xlsx/", views.incident_report_export_xlsx, name="incident_report_export_xlsx"),
    path("reports/export/pdf/", views.incident_report_export_pdf, name="incident_report_export_pdf"),
    path(
        "reports/<int:report_id>/status/",
        views.incident_report_update_status,
        name="incident_report_update_status",
    ),
]
