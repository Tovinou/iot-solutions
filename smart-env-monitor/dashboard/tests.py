from django.contrib.auth.models import Group
from django.contrib.auth import get_user_model
from django.test import TestCase

from backend.policies import is_analyst, is_manager
from dashboard.models import IncidentReport
from dashboard.services.incidents import IncidentFilters, apply_incident_filters


class IncidentFilterServiceTests(TestCase):
    def setUp(self):
        self.user = get_user_model().objects.create_user(username="manager", password="pw123456")
        self.other = get_user_model().objects.create_user(username="viewer", password="pw123456")
        IncidentReport.objects.create(
            title="Open issue",
            beach_name="Alpha Beach",
            description="Incident one description",
            status=IncidentReport.Status.OPEN,
            created_by=self.user,
            assigned_to=self.other,
        )
        IncidentReport.objects.create(
            title="Closed issue",
            beach_name="Bravo Beach",
            description="Incident two description",
            status=IncidentReport.Status.CLOSED,
            created_by=self.other,
            assigned_to=self.user,
        )

    def test_status_filter(self):
        filters = IncidentFilters(status=IncidentReport.Status.OPEN)
        qs = apply_incident_filters(IncidentReport.objects.all(), filters, user=self.user)
        self.assertEqual(qs.count(), 1)
        self.assertEqual(qs.first().status, IncidentReport.Status.OPEN)

    def test_user_assigned_filter(self):
        filters = IncidentFilters(assigned="1")
        qs = apply_incident_filters(IncidentReport.objects.all(), filters, user=self.user)
        self.assertEqual(qs.count(), 1)
        self.assertEqual(qs.first().assigned_to_id, self.user.id)


class PolicyTests(TestCase):
    def test_is_manager_and_is_analyst(self):
        manager_group = Group.objects.create(name="Manager")
        analyst_group = Group.objects.create(name="Analyst")
        user = get_user_model().objects.create_user(username="worker", password="pw123456")
        self.assertFalse(is_manager(user))
        self.assertFalse(is_analyst(user))

        user.groups.add(manager_group)
        self.assertTrue(is_manager(user))
        self.assertFalse(is_analyst(user))

        user.groups.add(analyst_group)
        self.assertTrue(is_analyst(user))
