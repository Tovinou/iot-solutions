from __future__ import annotations

import os
import sys
from pathlib import Path

from django.core.management.base import BaseCommand
from django.utils import timezone


class Command(BaseCommand):
    def handle(self, *args, **options):
        from api.models import SensorReading

        cutoff = timezone.now() - timezone.timedelta(days=365)
        SensorReading.objects.filter(timestamp__lt=cutoff).delete()


def main() -> int:
    project_root = Path(__file__).resolve().parents[1]
    os.chdir(project_root)
    sys.path.insert(0, str(project_root))

    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "backend.settings")
    import django

    django.setup()
    Command().handle()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
