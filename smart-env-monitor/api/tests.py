from django.contrib.auth import get_user_model
from django.contrib.auth.models import Group
from django.test import TestCase
from rest_framework.test import APIClient

from api.models import AlertRule, SecurityAuditEvent
from api.services.alerts import rule_matches
from dashboard.models import IncidentReport


class AlertRuleMatchingTests(TestCase):
    def test_numeric_rule_comparison(self):
        rule = AlertRule(
            metric=AlertRule.Metric.WATER_TEMPERATURE,
            operator=AlertRule.Operator.GT,
            threshold_number=20,
        )
        self.assertTrue(rule_matches(rule, 22))
        self.assertFalse(rule_matches(rule, 20))

    def test_quality_rule_requires_exact_match(self):
        rule = AlertRule(
            metric=AlertRule.Metric.QUALITY,
            operator=AlertRule.Operator.EQ,
            threshold_text="BAD",
        )
        self.assertTrue(rule_matches(rule, "BAD"))
        self.assertFalse(rule_matches(rule, "OK"))


class IncidentExportPermissionTests(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.manager_group = Group.objects.create(name="Manager")
        self.manager = get_user_model().objects.create_user(username="manager", password="pw123456")
        self.viewer = get_user_model().objects.create_user(username="viewer", password="pw123456")
        self.manager.groups.add(self.manager_group)
        IncidentReport.objects.create(
            title="Incident",
            beach_name="Alpha",
            description="Important incident description",
            created_by=self.manager,
        )

    def test_manager_can_export(self):
        self.client.force_authenticate(self.manager)
        response = self.client.get("/api/v1/incidents/")
        self.assertEqual(response.status_code, 200)

    def test_non_manager_cannot_export(self):
        self.client.force_authenticate(self.viewer)
        response = self.client.get("/api/v1/incidents/")
        self.assertEqual(response.status_code, 403)
        self.assertTrue(
            SecurityAuditEvent.objects.filter(
                event_type=SecurityAuditEvent.EventType.ACCESS_DENIED,
                actor=self.viewer,
            ).exists()
        )

    def test_manager_export_is_audited(self):
        self.client.force_authenticate(self.manager)
        response = self.client.get("/api/v1/incidents/")
        self.assertEqual(response.status_code, 200)
        self.assertTrue(
            SecurityAuditEvent.objects.filter(
                event_type=SecurityAuditEvent.EventType.EXPORT_INCIDENTS,
                actor=self.manager,
                outcome="success",
            ).exists()
        )
