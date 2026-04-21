import logging

from celery import shared_task

logger = logging.getLogger(__name__)


@shared_task(bind=True, max_retries=3, default_retry_delay=60, queue="notifications")
def send_email_task(self, subject: str, message: str, recipient_list: list[str]):
    from django.conf import settings
    from django.core.mail import send_mail

    recipients = [email.strip() for email in recipient_list if (email or "").strip()]
    if not recipients:
        return False

    try:
        sent_count = send_mail(
            subject=subject,
            message=message,
            from_email=getattr(settings, "DEFAULT_FROM_EMAIL", None),
            recipient_list=recipients,
            fail_silently=False,
        )
        return sent_count > 0
    except Exception as exc:
        logger.exception(
            "Email dispatch failed, retrying",
            extra={"subject": subject, "recipients": recipients},
        )
        raise self.retry(
            exc=exc,
            countdown=self.default_retry_delay * (self.request.retries + 1),
        )


def send_email_safe(*, subject: str, message: str, recipient_list: list[str], fail_silently: bool = True) -> bool:
    send_email_task.delay(subject=subject, message=message, recipient_list=recipient_list)
    return True
