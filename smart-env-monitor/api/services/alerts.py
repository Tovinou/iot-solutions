from __future__ import annotations

import logging

from django.conf import settings
from django.utils import timezone

from api.models import AlertEvent, AlertRule, SensorReading
from backend.services.notifications import send_email_task

logger = logging.getLogger(__name__)


def evaluate_alert_rules(reading: SensorReading) -> None:
    now = timezone.now()
    rules = AlertRule.objects.filter(enabled=True).select_related("recipient_user")
    for rule in rules:
        if rule.sensor_id and rule.sensor_id != reading.sensor_id:
            continue
        if rule.is_in_cooldown(now=now):
            continue

        current_value = getattr(reading, rule.metric, None)
        if current_value is None or not rule_matches(rule, current_value):
            continue

        threshold_display = (
            rule.threshold_text if rule.metric == AlertRule.Metric.QUALITY else rule.threshold_number
        )
        to_email = rule.recipient_email or (rule.recipient_user.email if rule.recipient_user else "")
        if not to_email:
            continue

        subject = rule.subject_template.format(name=rule.name)
        body = rule.body_template.format(
            name=rule.name,
            sensor_id=reading.sensor_id,
            timestamp=reading.timestamp.isoformat(),
            metric=rule.metric,
            operator=rule.operator,
            threshold=threshold_display,
            value=current_value,
        )

        send_email_task.delay(subject=subject, message=body, recipient_list=[to_email])
        AlertEvent.objects.create(rule=rule, reading=reading, to_email=to_email, subject=subject, body=body)
        rule.last_triggered_at = now
        rule.save(update_fields=["last_triggered_at"])

        logger.info(
            "Alert event created",
            extra={
                "rule_id": rule.id,
                "rule_name": rule.name,
                "sensor_id": reading.sensor_id,
                "metric": rule.metric,
            },
        )


def rule_matches(rule: AlertRule, value) -> bool:
    if rule.metric == AlertRule.Metric.QUALITY:
        left = str(value)
        right = (rule.threshold_text or "").strip()
        return rule.operator == AlertRule.Operator.EQ and left == right

    if rule.threshold_number is None:
        return False

    try:
        left = float(value)
        right = float(rule.threshold_number)
    except Exception:
        return False

    if rule.operator == AlertRule.Operator.GT:
        return left > right
    if rule.operator == AlertRule.Operator.GTE:
        return left >= right
    if rule.operator == AlertRule.Operator.LT:
        return left < right
    if rule.operator == AlertRule.Operator.LTE:
        return left <= right
    if rule.operator == AlertRule.Operator.EQ:
        return left == right
    return False
