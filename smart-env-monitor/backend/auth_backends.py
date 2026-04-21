from __future__ import annotations

from django.conf import settings
from django.contrib.auth import get_user_model


class TrustedHeaderBackend:
    """
    SSO-ready backend for trusted reverse-proxy headers.

    Enable only behind a trusted proxy that strips untrusted inbound headers.
    """

    def authenticate(self, request, **kwargs):
        if request is None or not getattr(settings, "ENABLE_SSO_HEADER_AUTH", False):
            return None

        username_header = getattr(settings, "SSO_HEADER_USERNAME", "X-Forwarded-User")
        email_header = getattr(settings, "SSO_HEADER_EMAIL", "X-Forwarded-Email")
        first_name_header = getattr(settings, "SSO_HEADER_FIRST_NAME", "X-Forwarded-Given-Name")
        last_name_header = getattr(settings, "SSO_HEADER_LAST_NAME", "X-Forwarded-Family-Name")
        groups_header = getattr(settings, "SSO_HEADER_GROUPS", "X-Forwarded-Groups")

        trusted_ips = getattr(settings, "SSO_TRUSTED_PROXY_IPS", None)
        if trusted_ips:
            remote_addr = (request.META.get("REMOTE_ADDR") or "").strip()
            if remote_addr not in set(trusted_ips):
                return None

        username = (request.headers.get(username_header) or "").strip()
        if not username:
            return None

        email = (request.headers.get(email_header) or "").strip()
        first_name = (request.headers.get(first_name_header) or "").strip()
        last_name = (request.headers.get(last_name_header) or "").strip()

        raw_groups = (request.headers.get(groups_header) or "").strip()
        group_names = [g.strip() for g in raw_groups.replace(";", ",").split(",") if g.strip()]
        user_model = get_user_model()
        user, _ = user_model.objects.get_or_create(
            username=username,
            defaults={
                "email": email,
                "is_active": True,
            },
        )
        update_fields: list[str] = []
        if email and user.email != email:
            user.email = email
            update_fields.append("email")
        if first_name and getattr(user, "first_name", "") != first_name:
            user.first_name = first_name
            update_fields.append("first_name")
        if last_name and getattr(user, "last_name", "") != last_name:
            user.last_name = last_name
            update_fields.append("last_name")
        if update_fields:
            user.save(update_fields=update_fields)

        if group_names:
            from django.contrib.auth.models import Group

            allowed_groups = getattr(settings, "SSO_ALLOWED_GROUPS", None)
            if allowed_groups:
                allowed = set(allowed_groups)
                group_names = [g for g in group_names if g in allowed]

            mapped = []
            group_map = getattr(settings, "SSO_GROUP_MAP", None) or {}
            for g in group_names:
                mapped.append(group_map.get(g, g))

            desired = {name for name in mapped if name}
            if desired:
                existing = set(user.groups.values_list("name", flat=True))
                if existing != desired:
                    groups = list(Group.objects.filter(name__in=desired))
                    missing = desired - {g.name for g in groups}
                    for name in sorted(missing):
                        groups.append(Group.objects.create(name=name))
                    user.groups.set(groups)
        if hasattr(request, "session") and "mfa" in getattr(settings, "INSTALLED_APPS", []):
            enforce_mfa = bool(getattr(settings, "MFA_ENFORCE", True))
            if enforce_mfa and hasattr(user, "mfakey_set") and not user.mfakey_set.exists():
                request.session["mfa_enroll_required"] = True
        return user


    def get_user(self, user_id):
        user_model = get_user_model()
        try:
            return user_model.objects.get(pk=user_id)
        except user_model.DoesNotExist:
            return None


try:
    from mozilla_django_oidc.auth import OIDCAuthenticationBackend as _OIDCBase
except Exception:
    _OIDCBase = object


class OIDCBackend(_OIDCBase):
    def get_username(self, claims):
        return (
            (claims.get("preferred_username") or "").strip()
            or (claims.get("email") or "").strip()
            or (claims.get("sub") or "").strip()
        )

    def create_user(self, claims):
        user = super().create_user(claims)
        return self.update_user(user, claims)

    def update_user(self, user, claims):
        update_fields: list[str] = []
        email = (claims.get("email") or "").strip()
        if email and getattr(user, "email", "") != email:
            user.email = email
            update_fields.append("email")

        first_name = (claims.get("given_name") or "").strip()
        if first_name and getattr(user, "first_name", "") != first_name:
            user.first_name = first_name
            update_fields.append("first_name")

        last_name = (claims.get("family_name") or "").strip()
        if last_name and getattr(user, "last_name", "") != last_name:
            user.last_name = last_name
            update_fields.append("last_name")

        if update_fields:
            user.save(update_fields=update_fields)

        claim_name = (getattr(settings, "OIDC_GROUP_CLAIM", "") or "").strip() or "groups"
        groups = claims.get(claim_name)
        if groups:
            from django.contrib.auth.models import Group

            group_names = [str(g).strip() for g in groups if str(g).strip()]
            allowed_groups = getattr(settings, "SSO_ALLOWED_GROUPS", None)
            if allowed_groups:
                allowed = set(allowed_groups)
                group_names = [g for g in group_names if g in allowed]

            mapped = []
            group_map = getattr(settings, "SSO_GROUP_MAP", None) or {}
            for g in group_names:
                mapped.append(group_map.get(g, g))

            desired = {name for name in mapped if name}
            if desired:
                existing = set(user.groups.values_list("name", flat=True))
                if existing != desired:
                    found = list(Group.objects.filter(name__in=desired))
                    missing = desired - {g.name for g in found}
                    for name in sorted(missing):
                        found.append(Group.objects.create(name=name))
                    user.groups.set(found)

        return user
