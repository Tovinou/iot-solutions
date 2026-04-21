import io

from django.conf import settings
from django.db import IntegrityError
from django.http import HttpResponse
from django.utils.dateparse import parse_datetime
from rest_framework import status, permissions
from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response
from rest_framework.throttling import ScopedRateThrottle
from rest_framework.views import APIView
import pandas as pd

from dashboard.models import IncidentReport
from api.audit import log_security_event
from api.models import SecurityAuditEvent
from backend.policies import IsManagerOrAdmin
from dashboard.services.incidents import apply_incident_filters, incident_filters_from_request
from .models import SensorReading
from .serializers import IncidentReportSerializer, SensorReadingSerializer


class SensorDataView(APIView):
    throttle_classes = [ScopedRateThrottle]
    throttle_scope = "sensor_ingest"

    def post(self, request):
        expected_key = (getattr(settings, "DEVICE_API_KEY", "") or "").strip()
        if expected_key:
            provided_key = (request.headers.get("X-Device-Key") or "").strip()
            if not provided_key:
                auth_header = (request.headers.get("Authorization") or "").strip()
                if auth_header.lower().startswith("bearer "):
                    provided_key = auth_header[7:].strip()
            if provided_key != expected_key:
                return Response({"detail": "Unauthorized"}, status=status.HTTP_401_UNAUTHORIZED)

        serializer = SensorReadingSerializer(data=request.data)
        if not serializer.is_valid():
            sensor_id = request.data.get("sensor_id")
            timestamp = request.data.get("timestamp")
            if (
                sensor_id
                and timestamp
                and "non_field_errors" in serializer.errors
            ):
                try:
                    timestamp_dt = serializer.fields["timestamp"].to_internal_value(timestamp)
                except Exception:
                    timestamp_dt = None

                if timestamp_dt is not None:
                    instance = SensorReading.objects.filter(
                        sensor_id=sensor_id,
                        timestamp=timestamp_dt,
                    ).first()
                    if instance:
                        response_serializer = SensorReadingSerializer(instance)
                        return Response(response_serializer.data, status=status.HTTP_200_OK)

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        try:
            instance = serializer.save()
            from .tasks import evaluate_alert_rules_task, publish_sensor_reading_task

            evaluate_alert_rules_task.delay(instance.id)
            publish_sensor_reading_task.delay(instance.id)
            response_serializer = SensorReadingSerializer(instance)
            return Response(response_serializer.data, status=status.HTTP_201_CREATED)
        except IntegrityError:
            instance = SensorReading.objects.filter(
                sensor_id=serializer.validated_data["sensor_id"],
                timestamp=serializer.validated_data["timestamp"],
            ).first()
            if not instance:
                raise
            response_serializer = SensorReadingSerializer(instance)
            return Response(response_serializer.data, status=status.HTTP_200_OK)


class LatestSensorReadingView(APIView):
    permission_classes = [permissions.AllowAny]
    throttle_classes = [ScopedRateThrottle]
    throttle_scope = "sensor_read"

    def get(self, request):
        sensor_id = request.query_params.get("sensor_id")
        queryset = SensorReading.objects.all()
        if sensor_id:
            queryset = queryset.filter(sensor_id=sensor_id)
        instance = queryset.order_by("-timestamp").first()
        if not instance:
            return Response({"detail": "No data found"}, status=status.HTTP_404_NOT_FOUND)
        serializer = SensorReadingSerializer(instance)
        return Response(serializer.data)


class SensorHistoryPagination(PageNumberPagination):
    page_size = 100
    page_size_query_param = "page_size"
    max_page_size = 1000


class SensorHistoryView(APIView):
    permission_classes = [permissions.AllowAny]
    throttle_classes = [ScopedRateThrottle]
    throttle_scope = "sensor_read"
    pagination_class = SensorHistoryPagination

    def get(self, request):
        sensor_id = request.query_params.get("sensor_id")
        from_param = request.query_params.get("from")
        to_param = request.query_params.get("to")

        queryset = SensorReading.objects.all()

        if sensor_id:
            queryset = queryset.filter(sensor_id=sensor_id)

        if from_param:
            from_dt = parse_datetime(from_param)
            if from_dt is None:
                return Response(
                    {"from": ["Invalid datetime format"]},
                    status=status.HTTP_400_BAD_REQUEST,
                )
            queryset = queryset.filter(timestamp__gte=from_dt)

        if to_param:
            to_dt = parse_datetime(to_param)
            if to_dt is None:
                return Response(
                    {"to": ["Invalid datetime format"]},
                    status=status.HTTP_400_BAD_REQUEST,
                )
            queryset = queryset.filter(timestamp__lte=to_dt)

        paginator = self.pagination_class()
        page = paginator.paginate_queryset(queryset.order_by("timestamp"), request, view=self)
        serializer = SensorReadingSerializer(page, many=True)
        return paginator.get_paginated_response(serializer.data)


class IncidentReportExportView(APIView):
    permission_classes = [permissions.IsAuthenticated, IsManagerOrAdmin]

    def get(self, request):
        log_security_event(
            event_type=SecurityAuditEvent.EventType.EXPORT_INCIDENTS,
            request=request,
            actor=request.user,
            outcome="success",
        )
        qs = IncidentReport.objects.select_related("created_by", "assigned_to").all()
        filters = incident_filters_from_request(request)
        qs = apply_incident_filters(qs, filters, include_user_flags=False)

        serializer = IncidentReportSerializer(qs.order_by("-created_at"), many=True)
        return Response(serializer.data)


class DataExportView(APIView):
    def get(self, request):
        sensor_id = request.query_params.get("sensor_id")
        from_param = request.query_params.get("from")
        to_param = request.query_params.get("to")

        queryset = SensorReading.objects.all()

        if sensor_id:
            queryset = queryset.filter(sensor_id=sensor_id)

        if from_param:
            from_dt = parse_datetime(from_param)
            if from_dt is None:
                return Response(
                    {"from": ["Invalid datetime format"]},
                    status=status.HTTP_400_BAD_REQUEST,
                )
            queryset = queryset.filter(timestamp__gte=from_dt)

        if to_param:
            to_dt = parse_datetime(to_param)
            if to_dt is None:
                return Response(
                    {"to": ["Invalid datetime format"]},
                    status=status.HTTP_400_BAD_REQUEST,
                )
            queryset = queryset.filter(timestamp__lte=to_dt)

        rows = list(
            queryset.order_by("timestamp").values(
                "id",
                "sensor_id",
                "timestamp",
                "water_temperature",
                "turbidity",
                "wave_height",
                "wave_period",
                "battery_life",
                "quality",
            )
        )
        df = pd.DataFrame.from_records(rows)
        if "timestamp" in df.columns:
            df["timestamp"] = df["timestamp"].astype(str)

        buffer = io.BytesIO()
        with pd.ExcelWriter(buffer, engine="openpyxl") as writer:
            df.to_excel(writer, index=False, sheet_name="readings")
        buffer.seek(0)

        response = HttpResponse(
            buffer.getvalue(),
            content_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        )
        response["Content-Disposition"] = 'attachment; filename="sensor_readings.xlsx"'
        return response
