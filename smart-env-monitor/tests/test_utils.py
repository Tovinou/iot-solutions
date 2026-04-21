"""
Test Utilities for E2E Testing

Shared utilities and helper functions for end-to-end tests.
"""

import json
import time
from typing import Dict, Any, Optional
import requests
from requests import Session


class KongAPIClient:
    """Client for interacting with Kong API Gateway."""

    def __init__(self, base_url: str = "http://localhost:8000", admin_url: str = "http://localhost:8001"):
        self.base_url = base_url.rstrip('/')
        self.admin_url = admin_url.rstrip('/')
        self.session = Session()
        self.session.timeout = 10

    def get_health(self) -> Dict[str, Any]:
        """Get health status from Kong."""
        response = self.session.get(f"{self.base_url}/health/")
        response.raise_for_status()
        return response.json()

    def ingest_sensor_data(self, data: Dict[str, Any], api_key: str) -> Dict[str, Any]:
        """Send sensor data through Kong."""
        headers = {"X-Device-Key": api_key, "Content-Type": "application/json"}
        response = self.session.post(
            f"{self.base_url}/api/v1/data/",
            json=data,
            headers=headers
        )
        response.raise_for_status()
        return response.json()

    def get_latest_sensor_data(self, sensor_id: str) -> Dict[str, Any]:
        """Get latest sensor data through Kong."""
        response = self.session.get(f"{self.base_url}/api/v1/data/latest/?sensor_id={sensor_id}")
        response.raise_for_status()
        return response.json()

    def get_sensor_history(self, sensor_id: str, from_date: str = None, to_date: str = None) -> Dict[str, Any]:
        """Get sensor history through Kong."""
        params = {"sensor_id": sensor_id}
        if from_date:
            params["from"] = from_date
        if to_date:
            params["to"] = to_date

        response = self.session.get(f"{self.base_url}/api/v1/data/history/", params=params)
        response.raise_for_status()
        return response.json()

    def get_kong_services(self) -> Dict[str, Any]:
        """Get Kong services configuration."""
        response = self.session.get(f"{self.admin_url}/services")
        response.raise_for_status()
        return response.json()


class DashboardClient:
    """Client for interacting with the Dashboard."""

    def __init__(self, base_url: str = "http://localhost:18080"):
        self.base_url = base_url.rstrip('/')
        self.session = Session()
        self.session.timeout = 10

    def get_dashboard(self) -> str:
        """Get dashboard HTML."""
        response = self.session.get(f"{self.base_url}/dashboard/")
        response.raise_for_status()
        return response.text

    def get_health(self) -> Dict[str, Any]:
        """Get health status."""
        response = self.session.get(f"{self.base_url}/health/")
        response.raise_for_status()
        return response.json()

    def login(self, username: str, password: str) -> bool:
        """Login to dashboard."""
        data = {"username": username, "password": password}
        response = self.session.post(f"{self.base_url}/login/", data=data)
        return response.status_code == 200

    def get_incidents(self) -> str:
        """Get incidents page (requires authentication)."""
        response = self.session.get(f"{self.base_url}/dashboard/reports/")
        response.raise_for_status()
        return response.text


class ELKClient:
    """Client for interacting with ELK stack."""

    def __init__(self, elasticsearch_url: str = "http://localhost:9200", kibana_url: str = "http://localhost:5601"):
        self.es_url = elasticsearch_url.rstrip('/')
        self.kibana_url = kibana_url.rstrip('/')
        self.session = Session()
        self.session.timeout = 10

    def get_elasticsearch_health(self) -> Dict[str, Any]:
        """Get Elasticsearch cluster health."""
        response = self.session.get(f"{self.es_url}/_cluster/health")
        response.raise_for_status()
        return response.json()

    def search_logs(self, index: str = "*", query: Dict[str, Any] = None) -> Dict[str, Any]:
        """Search logs in Elasticsearch."""
        if query is None:
            query = {"query": {"match_all": {}}}

        response = self.session.post(f"{self.es_url}/{index}/_search", json=query)
        response.raise_for_status()
        return response.json()

    def get_kibana_status(self) -> Dict[str, Any]:
        """Get Kibana status."""
        response = self.session.get(f"{self.kibana_url}/api/status")
        response.raise_for_status()
        return response.json()


def wait_for_service(url: str, timeout: int = 30, expected_status: int = 200) -> bool:
    """Wait for a service to become available."""
    start_time = time.time()
    while time.time() - start_time < timeout:
        try:
            response = requests.get(url, timeout=5)
            if response.status_code == expected_status:
                return True
        except requests.RequestException:
            pass
        time.sleep(1)
    return False


def generate_test_sensor_data(sensor_id: str = "Test Beach", **overrides) -> Dict[str, Any]:
    """Generate test sensor data with optional overrides."""
    import datetime

    data = {
        "sensor_id": sensor_id,
        "timestamp": datetime.datetime.utcnow().isoformat() + "Z",
        "water_temperature": 22.5,
        "turbidity": 3.2,
        "wave_height": 0.8,
        "wave_period": 8.5,
        "battery_life": 85.0,
        "quality": "GOOD"
    }
    data.update(overrides)
    return data


def assert_sensor_data_valid(data: Dict[str, Any]) -> None:
    """Assert that sensor data has all required fields."""
    required_fields = [
        "sensor_id", "timestamp", "water_temperature", "turbidity",
        "wave_height", "wave_period", "battery_life", "quality"
    ]

    for field in required_fields:
        assert field in data, f"Missing required field: {field}"
        assert data[field] is not None, f"Field {field} cannot be None"


def assert_api_response_success(response: requests.Response, expected_status: int = 200) -> None:
    """Assert that API response is successful."""
    assert response.status_code == expected_status, f"Expected status {expected_status}, got {response.status_code}"
    if response.headers.get('content-type', '').startswith('application/json'):
        data = response.json()
        assert "error" not in data, f"Response contains error: {data}"


def cleanup_test_data():
    """Clean up test data from database."""
    from django.core.management import call_command
    from django.db import connection

    # Reset database sequences
    with connection.cursor() as cursor:
        cursor.execute("DELETE FROM api_sensorreading WHERE sensor_id LIKE 'Test%'")
        cursor.execute("DELETE FROM api_alertevent WHERE sensor_id LIKE 'Test%'")
        cursor.execute("DELETE FROM dashboard_incidentreport WHERE title LIKE 'Test%'")
