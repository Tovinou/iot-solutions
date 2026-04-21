from locust import HttpUser, task, between
import json
import random
from datetime import datetime, timedelta

class SensorDataUser(HttpUser):
    wait_time = between(1, 3)

    def on_start(self):
        self.api_key = "your-device-api-key"  # Replace with actual key

    @task(3)
    def post_sensor_reading(self):
        # Generate random sensor data
        sensor_data = {
            "sensor_id": f"sensor_{random.randint(1, 10)}",
            "timestamp": (datetime.now() + timedelta(seconds=random.randint(-300, 0))).isoformat(),
            "temperature": round(random.uniform(15, 35), 2),
            "humidity": round(random.uniform(30, 80), 2),
            "co2": random.randint(400, 2000),
            "pm25": round(random.uniform(0, 50), 2),
            "voc": round(random.uniform(0, 5), 2)
        }

        headers = {
            "Content-Type": "application/json",
            "X-Device-Key": self.api_key
        }

        with self.client.post("/api/sensor-data/", json=sensor_data, headers=headers, catch_response=True) as response:
            if response.status_code == 201 or response.status_code == 200:
                response.success()
            else:
                response.failure(f"Unexpected status code: {response.status_code}")

    @task(1)
    def get_latest_reading(self):
        sensor_id = f"sensor_{random.randint(1, 10)}"
        with self.client.get(f"/api/sensor-data/latest/?sensor_id={sensor_id}", catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            elif response.status_code == 404:
                response.success()  # No data is acceptable
            else:
                response.failure(f"Unexpected status code: {response.status_code}")

    @task(1)
    def get_sensor_history(self):
        sensor_id = f"sensor_{random.randint(1, 10)}"
        with self.client.get(f"/api/sensor-data/history/?sensor_id={sensor_id}&page=1", catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Unexpected status code: {response.status_code}")

class DashboardUser(HttpUser):
    wait_time = between(2, 5)

    @task
    def access_dashboard(self):
        with self.client.get("/dashboard/", catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Unexpected status code: {response.status_code}")

    @task
    def access_swagger(self):
        with self.client.get("/swagger/", catch_response=True) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Unexpected status code: {response.status_code}")