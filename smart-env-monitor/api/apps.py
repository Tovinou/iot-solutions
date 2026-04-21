from django.apps import AppConfig


class ApiConfig(AppConfig):
    name = 'api'

    def ready(self):
        # Ensure auth/audit signal handlers are registered.
        import api.audit  # noqa: F401
