"""
E2E Test Configuration and Fixtures

This module provides pytest fixtures and configuration for end-to-end testing
of the Smart Environmental Monitoring Platform.
"""

import os
import pytest
import requests
import time
from typing import Dict, Any

# Test configuration
KONG_BASE_URL = "http://localhost:8000"
DASHBOARD_BASE_URL = "http://localhost:18080"
KONG_ADMIN_URL = "http://localhost:8001"
KIBANA_URL = "http://localhost:5601"

# Test data
TEST_SENSOR_DATA = {
    "sensor_id": "Test Beach",
    "timestamp": "2024-01-15T10:30:00Z",
    "water_temperature": 22.5,
    "turbidity": 3.2,
    "wave_height": 0.8,
    "wave_period": 8.5,
    "battery_life": 85.0,
    "quality": "GOOD"
}

TEST_USERS = {
    "admin": {"username": "admin_test", "password": "admin123", "groups": ["Admin"]},
    "manager": {"username": "manager_test", "password": "manager123", "groups": ["Manager"]},
    "analyst": {"username": "analyst_test", "password": "analyst123", "groups": ["Analyst"]},
    "viewer": {"username": "viewer_test", "password": "viewer123", "groups": ["Viewer"]},
}


@pytest.fixture(scope="session")
def wait_for_services():
    """Wait for all services to be ready before running tests."""
    services = [
        (KONG_BASE_URL, "Kong API Gateway"),
        (DASHBOARD_BASE_URL, "Dashboard"),
        (KONG_ADMIN_URL, "Kong Admin"),
        (KIBANA_URL, "Kibana"),
    ]

    max_attempts = 30
    attempt = 0

    while attempt < max_attempts:
        all_ready = True
        for url, name in services:
            try:
                response = requests.get(url, timeout=5)
                if response.status_code not in [200, 404]:  # 404 is ok for some endpoints
                    all_ready = False
                    print(f"Waiting for {name} at {url}...")
                    break
            except requests.RequestException:
                all_ready = False
                print(f"Waiting for {name} at {url}...")
                break

        if all_ready:
            print("All services are ready!")
            return True

        attempt += 1
        time.sleep(2)

    pytest.fail("Services did not become ready within timeout")


@pytest.fixture
def kong_client():
    """HTTP client configured for Kong API Gateway."""
    session = requests.Session()
    session.timeout = 10
    return session


@pytest.fixture
def dashboard_client():
    """HTTP client configured for Dashboard."""
    session = requests.Session()
    session.timeout = 10
    return session


@pytest.fixture
def sample_sensor_data():
    """Sample sensor data for testing."""
    return TEST_SENSOR_DATA.copy()


@pytest.fixture
def device_api_key():
    """Get device API key from environment."""
    key = os.getenv("DEVICE_API_KEY")
    if not key:
        pytest.fail("DEVICE_API_KEY environment variable not set")
    return key


# Test configuration
def pytest_configure(config):
    """Configure pytest with custom markers."""
    config.addinivalue_line("markers", "e2e: End-to-end tests")
    config.addinivalue_line("markers", "integration: Integration tests")
    config.addinivalue_line("markers", "slow: Slow-running tests")


def pytest_collection_modifyitems(config, items):
    """Modify test collection to add markers."""
    for item in items:
        # Mark all tests in tests/ directory as e2e
        if "tests/" in str(item.fspath):
            item.add_marker(pytest.mark.e2e)
