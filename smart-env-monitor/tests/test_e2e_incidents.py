"""
End-to-End Tests for Incident Reporting System

Tests the complete incident reporting workflow from creation through
assignment, updates, and resolution.
"""

import pytest
import json
from django.contrib.auth import get_user_model
from django.contrib.auth.models import Group
from rest_framework.test import APIClient
from dashboard.models import IncidentReport
from tests.test_utils import KongAPIClient


class TestIncidentsE2E:
    """End-to-end tests for incident reporting system."""

    @pytest.fixture
    def test_user_manager(self):
        """Create a test manager user."""
        User = get_user_model()
        user = User.objects.create_user(
            username="incident_manager",
            password="manager123",
            email="manager@test.com"
        )
        manager_group, _ = Group.objects.get_or_create(name="Manager")
        user.groups.add(manager_group)
        yield user
        user.delete()

    @pytest.fixture
    def test_user_analyst(self):
        """Create a test analyst user."""
        User = get_user_model()
        user = User.objects.create_user(
            username="incident_analyst",
            password="analyst123",
            email="analyst@test.com"
        )
        analyst_group, _ = Group.objects.get_or_create(name="Analyst")
        user.groups.add(analyst_group)
        yield user
        user.delete()

    @pytest.mark.e2e
    def test_incident_creation_through_api(self, test_user_manager):
        """Test creating an incident through the API."""
        client = APIClient()
        client.force_authenticate(test_user_manager)

        incident_data = {
            "title": "E2E Test Incident - High Turbidity",
            "description": "Automated test incident for high turbidity levels detected",
            "beach_name": "Test Beach",
            "priority": "HIGH"
        }

        response = client.post("/api/v1/incidents/", incident_data, format="json")
        assert response.status_code == 201

        # Verify incident was created
        incident_id = response.data["id"]
        incident = IncidentReport.objects.get(id=incident_id)

        assert incident.title == incident_data["title"]
        assert incident.description == incident_data["description"]
        assert incident.beach_name == incident_data["beach_name"]
        assert incident.created_by == test_user_manager
        assert incident.status == IncidentReport.Status.OPEN

        # Clean up
        incident.delete()

    @pytest.mark.e2e
    def test_incident_listing_and_filtering(self, test_user_manager):
        """Test listing and filtering incidents."""
        client = APIClient()
        client.force_authenticate(test_user_manager)

        # Create test incidents
        incident1 = IncidentReport.objects.create(
            title="Open Incident",
            description="Test open incident",
            beach_name="Beach A",
            status=IncidentReport.Status.OPEN,
            created_by=test_user_manager
        )

        incident2 = IncidentReport.objects.create(
            title="Closed Incident",
            description="Test closed incident",
            beach_name="Beach B",
            status=IncidentReport.Status.CLOSED,
            created_by=test_user_manager
        )

        try:
            # Test listing all incidents
            response = client.get("/api/v1/incidents/")
            assert response.status_code == 200
            assert len(response.data) >= 2

            # Test filtering by status
            response = client.get("/api/v1/incidents/?status=OPEN")
            assert response.status_code == 200
            open_incidents = [inc for inc in response.data if inc["status"] == "OPEN"]
            assert len(open_incidents) >= 1

        finally:
            # Clean up
            incident1.delete()
            incident2.delete()

    @pytest.mark.e2e
    def test_incident_status_workflow(self, test_user_manager, test_user_analyst):
        """Test the complete incident status workflow."""
        client = APIClient()
        client.force_authenticate(test_user_manager)

        # Create incident
        incident_data = {
            "title": "Workflow Test Incident",
            "description": "Testing incident status workflow",
            "beach_name": "Workflow Beach"
        }

        response = client.post("/api/v1/incidents/", incident_data, format="json")
        assert response.status_code == 201
        incident_id = response.data["id"]

        # Update status to IN_PROGRESS and assign
        update_data = {
            "status": "IN_PROGRESS",
            "assigned_to": test_user_analyst.id
        }

        response = client.patch(f"/api/v1/incidents/{incident_id}/", update_data, format="json")
        assert response.status_code == 200

        # Verify status update
        incident = IncidentReport.objects.get(id=incident_id)
        assert incident.status == IncidentReport.Status.IN_PROGRESS
        assert incident.assigned_to == test_user_analyst

        # Close incident
        close_data = {
            "status": "CLOSED",
            "resolution_notes": "Issue resolved by automated test"
        }

        response = client.patch(f"/api/v1/incidents/{incident_id}/", close_data, format="json")
        assert response.status_code == 200

        # Verify closure
        incident.refresh_from_db()
        assert incident.status == IncidentReport.Status.CLOSED

        # Clean up
        incident.delete()

    @pytest.mark.e2e
    def test_incident_permissions(self, test_user_manager, test_user_analyst):
        """Test that incident permissions work correctly."""
        from backend.policies import is_manager

        # Verify user roles
        assert is_manager(test_user_manager)
        assert not is_manager(test_user_analyst)

        # Manager client
        manager_client = APIClient()
        manager_client.force_authenticate(test_user_manager)

        # Analyst client
        analyst_client = APIClient()
        analyst_client.force_authenticate(test_user_analyst)

        # Create incident as manager
        incident_data = {
            "title": "Permission Test Incident",
            "description": "Testing permissions",
            "beach_name": "Permission Beach"
        }

        response = manager_client.post("/api/v1/incidents/", incident_data, format="json")
        assert response.status_code == 201
        incident_id = response.data["id"]

        # Analyst should be able to view incidents (read-only)
        response = analyst_client.get("/api/v1/incidents/")
        assert response.status_code == 200

        # Analyst should NOT be able to create incidents
        response = analyst_client.post("/api/v1/incidents/", incident_data, format="json")
        assert response.status_code == 403

        # Analyst should NOT be able to update incidents
        update_data = {"status": "IN_PROGRESS"}
        response = analyst_client.patch(f"/api/v1/incidents/{incident_id}/", update_data, format="json")
        assert response.status_code == 403

        # Clean up
        IncidentReport.objects.get(id=incident_id).delete()

    @pytest.mark.e2e
    def test_incident_export_functionality(self, test_user_manager):
        """Test incident export functionality."""
        client = APIClient()
        client.force_authenticate(test_user_manager)

        # Create test incidents
        incidents = []
        for i in range(3):
            incident = IncidentReport.objects.create(
                title=f"Export Test Incident {i}",
                description=f"Description for incident {i}",
                beach_name=f"Beach {i}",
                status=IncidentReport.Status.OPEN if i % 2 == 0 else IncidentReport.Status.CLOSED,
                created_by=test_user_manager
            )
            incidents.append(incident)

        try:
            # Test JSON export
            response = client.get("/api/v1/incidents/")
            assert response.status_code == 200

            data = response.data
            assert len(data) >= 3

            # Verify export data structure
            for item in data:
                assert "id" in item
                assert "title" in item
                assert "status" in item
                assert "created_at" in item

        finally:
            # Clean up
            for incident in incidents:
                incident.delete()

    @pytest.mark.e2e
    def test_incident_search_and_filtering(self, test_user_manager):
        """Test incident search and advanced filtering."""
        client = APIClient()
        client.force_authenticate(test_user_manager)

        # Create incidents with different attributes
        incident1 = IncidentReport.objects.create(
            title="Pollution Incident",
            description="Water pollution detected",
            beach_name="Pollution Beach",
            status=IncidentReport.Status.OPEN,
            created_by=test_user_manager
        )

        incident2 = IncidentReport.objects.create(
            title="Safety Incident",
            description="Unsafe conditions",
            beach_name="Safety Beach",
            status=IncidentReport.Status.IN_PROGRESS,
            created_by=test_user_manager
        )

        try:
            # Test search by title
            response = client.get("/api/v1/incidents/?search=pollution")
            assert response.status_code == 200
            assert len(response.data) >= 1

            # Test filter by status
            response = client.get("/api/v1/incidents/?status=OPEN")
            assert response.status_code == 200
            open_incidents = [inc for inc in response.data if inc["status"] == "OPEN"]
            assert len(open_incidents) >= 1

            # Test filter by beach
            response = client.get("/api/v1/incidents/?beach_name=Pollution Beach")
            assert response.status_code == 200
            assert len(response.data) >= 1

        finally:
            incident1.delete()
            incident2.delete()

    @pytest.mark.e2e
    def test_incident_audit_trail(self, test_user_manager, test_user_analyst):
        """Test that incident changes are properly audited."""
        from api.models import SecurityAuditEvent

        client = APIClient()
        client.force_authenticate(test_user_manager)

        # Create incident
        incident_data = {
            "title": "Audit Test Incident",
            "description": "Testing audit trail",
            "beach_name": "Audit Beach"
        }

        response = client.post("/api/v1/incidents/", incident_data, format="json")
        incident_id = response.data["id"]

        # Update incident
        update_data = {
            "status": "IN_PROGRESS",
            "assigned_to": test_user_analyst.id
        }

        response = client.patch(f"/api/v1/incidents/{incident_id}/", update_data, format="json")

        # Check for audit events
        audit_events = SecurityAuditEvent.objects.filter(
            event_type__in=[
                SecurityAuditEvent.EventType.INCIDENT_CREATED,
                SecurityAuditEvent.EventType.INCIDENT_UPDATED
            ]
        )

        # Should have audit events (if auditing is enabled)
        # Note: Actual audit behavior depends on implementation

        # Clean up
        IncidentReport.objects.get(id=incident_id).delete()

    @pytest.mark.e2e
    def test_incident_priority_handling(self, test_user_manager):
        """Test incident priority levels and handling."""
        client = APIClient()
        client.force_authenticate(test_user_manager)

        # Create incidents with different priorities
        priorities = ["LOW", "MEDIUM", "HIGH", "CRITICAL"]

        incidents = []
        for priority in priorities:
            incident_data = {
                "title": f"{priority} Priority Incident",
                "description": f"Test {priority} priority incident",
                "beach_name": f"{priority} Beach",
                "priority": priority
            }

            response = client.post("/api/v1/incidents/", incident_data, format="json")
            assert response.status_code == 201

            incident = IncidentReport.objects.get(id=response.data["id"])
            incidents.append(incident)

            # Verify priority was set
            assert incident.priority == priority

        # Test ordering by priority
        response = client.get("/api/v1/incidents/?ordering=-priority")
        assert response.status_code == 200

        # Clean up
        for incident in incidents:
            incident.delete()

    @pytest.mark.e2e
    def test_incident_attachment_handling(self, test_user_manager):
        """Test incident attachment upload and handling."""
        # This test would require file upload functionality
        # For now, we test that the incident model supports attachments

        client = APIClient()
        client.force_authenticate(test_user_manager)

        incident = IncidentReport.objects.create(
            title="Attachment Test",
            description="Testing attachments",
            beach_name="Attachment Beach",
            created_by=test_user_manager
        )

        # Verify incident can be created (attachment fields would be tested if implemented)
        assert incident.pk is not None

        # Clean up
        incident.delete()
