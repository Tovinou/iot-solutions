from rest_framework import serializers

from .models import SensorReading
from dashboard.models import IncidentReport


class SensorReadingSerializer(serializers.ModelSerializer):
    class Meta:
        model = SensorReading
        fields = [
            "id",
            "sensor_id",
            "timestamp",
            "water_temperature",
            "turbidity",
            "wave_height",
            "wave_period",
            "battery_life",
            "quality",
        ]


class IncidentReportSerializer(serializers.ModelSerializer):
    assigned_to = serializers.SerializerMethodField()
    created_by = serializers.SerializerMethodField()

    class Meta:
        model = IncidentReport
        fields = [
            "id",
            "status",
            "title",
            "beach_name",
            "description",
            "assigned_to",
            "created_by",
            "created_at",
            "updated_at",
            "closed_at",
            "closed_comment",
        ]

    def get_assigned_to(self, obj):
        return obj.assigned_to.username if obj.assigned_to else None

    def get_created_by(self, obj):
        return obj.created_by.username if obj.created_by else None
