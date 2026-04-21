"""
End-to-End Tests for Sensor Data Ingestion

Tests the complete flow of sensor data from ingestion through Kong API Gateway
to storage and retrieval.
"""

import pytest
import time
from tests.test_utils import KongAPIClient, generate_test_sensor_data, assert_sensor_data_valid


class TestSensorIngestionE2E:
    """End-to-end tests for sensor data ingestion flow."""

    @pytest.mark.e2e
    def test_sensor_data_ingestion_through_kong(self, wait_for_services, device_api_key):
        """Test complete sensor data ingestion through Kong API Gateway."""
        client = KongAPIClient()

        # Generate test sensor data
        sensor_data = generate_test_sensor_data("E2E Test Beach")

        # Ingest data through Kong
        response_data = client.ingest_sensor_data(sensor_data, device_api_key)

        # Verify response
        assert "message" in response_data
        assert "Sensor data ingested successfully" in response_data["message"]

    @pytest.mark.e2e
    def test_sensor_data_retrieval_latest(self, wait_for_services, device_api_key):
        """Test retrieving latest sensor data through Kong."""
        client = KongAPIClient()
        sensor_id = "E2E Latest Test Beach"

        # First, ingest some data
        sensor_data = generate_test_sensor_data(sensor_id)
        client.ingest_sensor_data(sensor_data, device_api_key)

        # Small delay to ensure data is processed
        time.sleep(1)

        # Retrieve latest data
        latest_data = client.get_latest_sensor_data(sensor_id)

        # Verify data structure
        assert_sensor_data_valid(latest_data)
        assert latest_data["sensor_id"] == sensor_id

    @pytest.mark.e2e
    def test_sensor_data_retrieval_history(self, wait_for_services, device_api_key):
        """Test retrieving sensor data history through Kong."""
        client = KongAPIClient()
        sensor_id = "E2E History Test Beach"

        # Ingest multiple data points
        for i in range(3):
            sensor_data = generate_test_sensor_data(sensor_id, water_temperature=20.0 + i)
            client.ingest_sensor_data(sensor_data, device_api_key)
            time.sleep(0.5)  # Small delay between ingests

        # Retrieve history
        history_data = client.get_sensor_history(sensor_id)

        # Verify we get a list of readings
        assert isinstance(history_data, list)
        assert len(history_data) >= 3

        # Verify each reading is valid
        for reading in history_data:
            assert_sensor_data_valid(reading)
            assert reading["sensor_id"] == sensor_id

    @pytest.mark.e2e
    def test_kong_rate_limiting(self, wait_for_services, device_api_key):
        """Test that Kong rate limiting works for sensor ingestion."""
        client = KongAPIClient()
        sensor_id = "E2E Rate Limit Test Beach"

        # Try to send many requests quickly (more than rate limit allows)
        success_count = 0
        rate_limited_count = 0

        for i in range(150):  # More than the 120/minute limit
            try:
                sensor_data = generate_test_sensor_data(sensor_id, water_temperature=20.0 + i)
                client.ingest_sensor_data(sensor_data, device_api_key)
                success_count += 1
            except Exception as e:
                if "429" in str(e) or "rate limit" in str(e).lower():
                    rate_limited_count += 1
                else:
                    raise

            if i > 0 and i % 10 == 0:
                time.sleep(1)  # Brief pause

        # We should have some successful requests and some rate limited
        assert success_count > 0, "No requests succeeded"
        assert rate_limited_count > 0, "Rate limiting did not trigger"

    @pytest.mark.e2e
    def test_kong_cors_headers(self, wait_for_services):
        """Test that Kong adds proper CORS headers."""
        import requests

        # Make a preflight OPTIONS request
        response = requests.options(
            "http://localhost:8000/api/v1/data/",
            headers={
                "Origin": "http://localhost:3000",
                "Access-Control-Request-Method": "POST",
                "Access-Control-Request-Headers": "X-Device-Key,Content-Type"
            }
        )

        # Verify CORS headers are present
        assert "Access-Control-Allow-Origin" in response.headers
        assert "Access-Control-Allow-Methods" in response.headers
        assert "Access-Control-Allow-Headers" in response.headers

    @pytest.mark.e2e
    def test_unauthorized_access_blocked(self, wait_for_services):
        """Test that requests without proper API key are blocked."""
        import requests

        sensor_data = generate_test_sensor_data("Unauthorized Test Beach")

        # Try to send data without API key
        response = requests.post(
            "http://localhost:8000/api/v1/data/",
            json=sensor_data,
            headers={"Content-Type": "application/json"}
        )

        # Should be unauthorized
        assert response.status_code == 401

    @pytest.mark.e2e
    def test_invalid_api_key_blocked(self, wait_for_services):
        """Test that requests with invalid API key are blocked."""
        import requests

        sensor_data = generate_test_sensor_data("Invalid Key Test Beach")

        # Try to send data with invalid API key
        response = requests.post(
            "http://localhost:8000/api/v1/data/",
            json=sensor_data,
            headers={
                "Content-Type": "application/json",
                "X-Device-Key": "invalid-key-12345"
            }
        )

        # Should be unauthorized
        assert response.status_code == 401

    @pytest.mark.e2e
    def test_kong_health_endpoint(self, wait_for_services):
        """Test Kong health endpoint."""
        client = KongAPIClient()

        health_data = client.get_health()

        # Verify health response structure
        assert "status" in health_data
        assert health_data["status"] in ["ok", "healthy"]

    @pytest.mark.e2e
    def test_kong_services_configuration(self, wait_for_services):
        """Test that Kong services are properly configured."""
        client = KongAPIClient()

        services = client.get_kong_services()

        # Verify we have services configured
        assert "data" in services
        assert len(services["data"]) > 0

        # Check for our API service
        service_names = [s["name"] for s in services["data"]]
        assert "smart-env-api" in service_names

    @pytest.mark.e2e
    @pytest.mark.slow
    def test_sensor_data_persistence(self, wait_for_services, device_api_key):
        """Test that sensor data persists across requests."""
        client = KongAPIClient()
        sensor_id = "E2E Persistence Test Beach"

        # Ingest data
        sensor_data = generate_test_sensor_data(sensor_id, water_temperature=25.0)
        client.ingest_sensor_data(sensor_data, device_api_key)

        # Wait a bit
        time.sleep(2)

        # Retrieve data in a new client instance
        client2 = KongAPIClient()
        latest_data = client2.get_latest_sensor_data(sensor_id)

        # Verify data persisted
        assert_sensor_data_valid(latest_data)
        assert latest_data["sensor_id"] == sensor_id
        assert abs(latest_data["water_temperature"] - 25.0) < 0.01
