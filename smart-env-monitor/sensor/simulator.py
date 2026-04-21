import os
import time
from datetime import datetime, timezone

import pandas as pd
import requests
from dotenv import load_dotenv

DATASET_URL = "https://data.cityofchicago.org/api/views/qmqz-2xku/rows.csv?accessType=DOWNLOAD"


def load_config():
    load_dotenv()
    backend_url = os.getenv("BACKEND_URL", "http://localhost:8000/api/v1/data/")
    if backend_url.endswith("/api/data/"):
        backend_url = backend_url[:-len("/api/data/")] + "/api/v1/data/"
    elif backend_url.endswith("/api/data"):
        backend_url = backend_url[:-len("/api/data")] + "/api/v1/data/"
    sensor_id = os.getenv("SENSOR_ID", "env-sensor-01")
    interval = int(os.getenv("SENSOR_INTERVAL", "10"))
    dataset_path = os.getenv("DATASET_PATH", "sensor/dataset/environment_data.csv")
    device_api_key = (os.getenv("DEVICE_API_KEY") or "").strip()
    return backend_url, sensor_id, interval, dataset_path, device_api_key


def download_dataset_if_missing(path):
    """
    Downloads the dataset from the official source if it doesn't exist locally.
    """
    if not os.path.exists(path):
        print(f"Dataset not found at {path}. Downloading from {DATASET_URL}...")
        try:
            response = requests.get(DATASET_URL)
            response.raise_for_status()
            os.makedirs(os.path.dirname(path), exist_ok=True)
            with open(path, "wb") as f:
                f.write(response.content)
            print("Download complete.")
        except Exception as e:
            print(f"Failed to download dataset: {e}")



def read_dataset(path):
    """
    Reads the dataset using pandas and yields records one by one.
    """
    try:
        df = pd.read_csv(path)
        
        # Sort by timestamp to ensure data is sent in chronological order
        if 'Measurement Timestamp' in df.columns:
            df['Measurement Timestamp'] = pd.to_datetime(df['Measurement Timestamp'], format='%m/%d/%Y %I:%M:%S %p', errors='coerce')
            df = df.sort_values(by='Measurement Timestamp')

        # Iterate over the dataframe rows as dictionaries
        for record in df.to_dict("records"):

            yield record
    except FileNotFoundError:
        print(f"Error: Dataset file not found at {path}")
        return
    except pd.errors.EmptyDataError:
        print(f"Error: Dataset file at {path} is empty")
        return


def build_payload(row, sensor_id_env):
    timestamp = datetime.now(timezone.utc).isoformat()
    
    # Use Beach Name from CSV as sensor_id if present, otherwise use env var
    sensor_id = row.get("Beach Name", sensor_id_env)

    def get_float(key):
        val = row.get(key)
        if pd.isna(val):
            return None
        try:
            f = float(val)
            if pd.isna(f) or f < -100:  # Filter out error codes like -100000
                return None
            return f
        except (TypeError, ValueError):
            return None

    water_temp = get_float("Water Temperature")
    turbidity = get_float("Turbidity")
    wave_height = get_float("Wave Height")
    wave_period = get_float("Wave Period")
    battery_life = get_float("Battery Life")

    # Simple logic for quality: if Turbidity > 10, mark as Avvikelse (example logic)
    # The user previously had THRESHOLD_VALUE = 100 for "value". 
    # Let's assume Turbidity is the primary quality indicator for now.
    quality = "Avvikelse" if (turbidity is not None and turbidity > 10) else "OK"

    return {
        "sensor_id": sensor_id,
        "timestamp": timestamp,
        "water_temperature": water_temp,
        "turbidity": turbidity,
        "wave_height": wave_height,
        "wave_period": wave_period,
        "battery_life": battery_life,
        "quality": quality,
    }


def post_with_retry(url, payload, device_api_key="", retries=3, delay=2):
    attempt = 0
    headers = {}
    if device_api_key:
        headers["X-Device-Key"] = device_api_key
    while attempt < retries:
        try:
            response = requests.post(url, json=payload, headers=headers, timeout=5)
            if response.status_code == 201:
                return True
            else:
                print(f"Server rejected data. Status {response.status_code}: {response.text}")
                return False
        except requests.RequestException as e:
            print(f"Connection Error: {e}")
        attempt += 1
        if attempt < retries:
            time.sleep(delay)
    return False


def main():
    backend_url, sensor_id_env, interval, dataset_path, device_api_key = load_config()

    download_dataset_if_missing(dataset_path)

    print(f"Starting simulator. Target: {backend_url}")
    
    # Räkna ut dashboard-URL baserat på backend-URL för att vara användarvänlig
    dashboard_url = backend_url.replace("/api/v1/data/", "/dashboard/").replace("/api/data/", "/dashboard/")
    if dashboard_url.endswith("localhost:8000/dashboard/"):
        dashboard_url = "http://localhost:8000/dashboard/" # Lokalt standard
    elif dashboard_url.endswith("localhost:18080/dashboard/"):
        dashboard_url = "http://localhost:18080/dashboard/" # Docker standard
        
    print(f"\n  Se dina grafer live här: {dashboard_url} \n")
    
    print(f"Reading from: {dataset_path}")
    
    for row in read_dataset(dataset_path):
        payload = build_payload(row, sensor_id_env)
        ok = post_with_retry(backend_url, payload, device_api_key=device_api_key)
        if ok:
            print(f"Sent data for {payload['sensor_id']}: Temp={payload['water_temperature']}, Turbidity={payload['turbidity']}")
        else:
            print(f"Failed to send data for {payload['sensor_id']}")
        time.sleep(interval)


if __name__ == "__main__":
    main()
