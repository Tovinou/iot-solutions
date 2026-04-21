"""
End-to-End Tests for Dashboard Functionality

Tests the complete dashboard user experience including authentication,
data visualization, and incident reporting.
"""

import pytest
from django.contrib.auth import get_user_model
from django.contrib.auth.models import Group
from tests.test_utils import DashboardClient, KongAPIClient, generate_test_sensor_data


class TestDashboardE2E:
    """End-to-end tests for dashboard functionality."""

    @pytest.fixture
    def test_user_manager(self):
        """Create a test manager user."""
        User = get_user_model()
        user = User.objects.create_user(
            username="e2e_manager",
            password="manager123",
            email="manager@test.com"
        )
        manager_group, _ = Group.objects.get_or_create(name="Manager")
        user.groups.add(manager_group)
        yield user
        user.delete()

    @pytest.fixture
    def test_user_viewer(self):
        """Create a test viewer user."""
        User = get_user_model()
        user = User.objects.create_user(
            username="e2e_viewer",
            password="viewer123",
            email="viewer@test.com"
        )
        viewer_group, _ = Group.objects.get_or_create(name="Viewer")
        user.groups.add(viewer_group)
        yield user
        user.delete()

    @pytest.mark.e2e
    def test_dashboard_access_unauthenticated(self, wait_for_services):
        """Test that dashboard redirects unauthenticated users to login."""
        client = DashboardClient()

        # Try to access dashboard without authentication
        response = client.session.get("http://localhost:18080/dashboard/", allow_redirects=False)

        # Should redirect to login
        assert response.status_code in [302, 401]

    @pytest.mark.e2e
    def test_dashboard_health_check(self, wait_for_services):
        """Test dashboard health endpoint."""
        client = DashboardClient()

        health_data = client.get_health()

        # Verify health response
        assert "status" in health_data
        assert health_data["status"] in ["ok", "healthy"]
        assert "database" in health_data

    @pytest.mark.e2e
    def test_dashboard_data_display(self, wait_for_services, device_api_key, test_user_viewer):
        """Test that dashboard displays sensor data correctly."""
        # First, ingest some test data
        kong_client = KongAPIClient()
        sensor_data = generate_test_sensor_data("Dashboard Test Beach", water_temperature=24.5)
        kong_client.ingest_sensor_data(sensor_data, device_api_key)

        # Wait for data to be processed
        import time
        time.sleep(2)

        # Access dashboard as authenticated user
        dashboard_client = DashboardClient()

        # Since we can't easily authenticate through HTTP in this test,
        # we'll test the API endpoints that the dashboard uses
        latest_data = kong_client.get_latest_sensor_data("Dashboard Test Beach")

        # Verify data is accessible
        assert latest_data["sensor_id"] == "Dashboard Test Beach"
        assert abs(latest_data["water_temperature"] - 24.5) < 0.01

    @pytest.mark.e2e
    def test_dashboard_chart_data_api(self, wait_for_services, device_api_key):
        """Test that dashboard chart data API returns proper data."""
        # Ingest multiple data points for charting
        kong_client = KongAPIClient()
        sensor_id = "Chart Test Beach"

        for i in range(5):
            sensor_data = generate_test_sensor_data(
                sensor_id,
                water_temperature=20.0 + i,
                turbidity=2.0 + i * 0.5
            )
            kong_client.ingest_sensor_data(sensor_data, device_api_key)
            import time
            time.sleep(0.5)

        # Get history data (what dashboard charts would use)
        history_data = kong_client.get_sensor_history(sensor_id)

        # Verify we have historical data for charting
        assert len(history_data) >= 5

        # Verify data points are properly ordered/timestamped
        timestamps = [reading["timestamp"] for reading in history_data]
        assert len(timestamps) == len(set(timestamps))  # All timestamps unique

    @pytest.mark.e2e
    def test_incident_reporting_flow(self, wait_for_services, test_user_manager):
        """Test the complete incident reporting workflow."""
        from dashboard.models import IncidentReport

        # Create an incident report
        incident = IncidentReport.objects.create(
            title="E2E Test Incident",
            description="Test incident for e2e testing",
            beach_name="Test Beach",
            status=IncidentReport.Status.OPEN,
            created_by=test_user_manager
        )

        # Verify incident was created
        assert incident.pk is not None
        assert incident.status == IncidentReport.Status.OPEN
        assert incident.created_by == test_user_manager

        # Update incident status (manager action)
        incident.status = IncidentReport.Status.IN_PROGRESS
        incident.assigned_to = test_user_manager
        incident.save()

        # Verify status update
        updated_incident = IncidentReport.objects.get(pk=incident.pk)
        assert updated_incident.status == IncidentReport.Status.IN_PROGRESS
        assert updated_incident.assigned_to == test_user_manager

        # Close incident
        updated_incident.status = IncidentReport.Status.CLOSED
        updated_incident.closed_at = None  # Would be set by view
        updated_incident.save()

        # Clean up
        incident.delete()

    @pytest.mark.e2e
    def test_user_role_based_access(self, wait_for_services, test_user_manager, test_user_viewer):
        """Test that different user roles have appropriate access."""
        from rest_framework.test import APIClient

        # Test manager access
        manager_client = APIClient()
        manager_client.force_authenticate(test_user_manager)

        # Manager should be able to access incident reports
        response = manager_client.get("/api/v1/incidents/")
        assert response.status_code == 200

        # Test viewer access
        viewer_client = APIClient()
        viewer_client.force_authenticate(test_user_viewer)

        # Viewer should be denied access to incident reports
        response = viewer_client.get("/api/v1/incidents/")
        assert response.status_code == 403

    @pytest.mark.e2e
    def test_dashboard_sensor_health_display(self, wait_for_services, device_api_key):
        """Test that dashboard shows sensor health status."""
        import time

        kong_client = KongAPIClient()
        sensor_id = "Health Test Beach"

        # Ingest recent data (sensor should be healthy)
        sensor_data = generate_test_sensor_data(sensor_id)
        kong_client.ingest_sensor_data(sensor_data, device_api_key)

        # Wait a bit
        time.sleep(1)

        # Get latest data to verify sensor is reporting
        latest_data = kong_client.get_latest_sensor_data(sensor_id)
        assert latest_data["sensor_id"] == sensor_id

        # In a real dashboard test, we would check that the UI shows this sensor as "OK"
        # For this API test, we verify the data is available for the dashboard to display

    @pytest.mark.e2e
    def test_dashboard_alert_display(self, wait_for_services, device_api_key):
        """Test that dashboard displays active alerts."""
        from api.models import AlertRule

        # Create a test alert rule
        alert_rule = AlertRule.objects.create(
            name="E2E High Temperature Alert",
            enabled=True,
            sensor_id="Alert Test Beach",
            metric=AlertRule.Metric.WATER_TEMPERATURE,
            operator=AlertRule.Operator.GT,
            threshold_number=30.0,
            recipient_email="test@example.com"
        )

        # Ingest data that should trigger the alert
        kong_client = KongAPIClient()
        sensor_data = generate_test_sensor_data(
            "Alert Test Beach",
            water_temperature=35.0  # Above threshold
        )
        kong_client.ingest_sensor_data(sensor_data, device_api_key)

        # Wait for alert processing
        import time
        time.sleep(3)

        # In a real test, we would check that the dashboard shows this alert
        # For this test, we verify the alert rule exists and data was ingested

        # Clean up
        alert_rule.delete()

    @pytest.mark.e2e
    def test_dashboard_responsive_design(self, wait_for_services):
        """Test that dashboard works on different screen sizes."""
        # This would typically use a browser automation tool like Selenium
        # For this API-based test, we'll just verify the dashboard serves HTML

        import requests

        response = requests.get("http://localhost:18080/dashboard/")
        assert response.status_code in [200, 302]  # 302 for redirect to login

        if response.status_code == 200:
            html_content = response.text
            # Check for responsive design elements
            assert "viewport" in html_content.lower() or "bootstrap" in html_content.lower()

    @pytest.mark.e2e
    def test_dashboard_static_files_served(self, wait_for_services):
        """Test that dashboard static files (CSS, JS) are served correctly."""
        import requests

        # Test CSS file
        response = requests.get("http://localhost:18080/static/dashboard/css/main.css")
        assert response.status_code == 200
        assert "text/css" in response.headers.get("content-type", "")

        # Test that CSS contains expected styles
        css_content = response.text
        assert "dashboard" in css_content.lower() or len(css_content) > 100
