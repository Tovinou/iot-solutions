from kafka import KafkaProducer
import json
import logging

logger = logging.getLogger(__name__)

class AnalyticsService:
    def __init__(self):
        try:
            self.producer = KafkaProducer(
                bootstrap_servers=['kafka:29092'],
                value_serializer=lambda v: json.dumps(v).encode('utf-8'),
                key_serializer=lambda k: k.encode('utf-8') if k else None
            )
        except Exception as e:
            logger.error(f"Failed to initialize Kafka producer: {e}")
            self.producer = None

    def send_sensor_reading(self, sensor_id, data):
        if not self.producer:
            return
        try:
            self.producer.send(
                'sensor_readings',
                key=str(sensor_id),
                value={
                    'sensor_id': sensor_id,
                    'timestamp': data.get('timestamp'),
                    'temperature': data.get('temperature'),
                    'humidity': data.get('humidity'),
                    'co2': data.get('co2'),
                    'pm25': data.get('pm25'),
                    'voc': data.get('voc')
                }
            )
            self.producer.flush()
            logger.info(f"Sent sensor reading to Kafka: {sensor_id}")
        except Exception as e:
            logger.error(f"Failed to send sensor reading to Kafka: {e}")

    def send_alert_event(self, alert_id, data):
        if not self.producer:
            return
        try:
            self.producer.send(
                'alert_events',
                key=str(alert_id),
                value={
                    'alert_id': alert_id,
                    'sensor_id': data.get('sensor_id'),
                    'alert_type': data.get('alert_type'),
                    'message': data.get('message'),
                    'timestamp': data.get('timestamp')
                }
            )
            self.producer.flush()
            logger.info(f"Sent alert event to Kafka: {alert_id}")
        except Exception as e:
            logger.error(f"Failed to send alert event to Kafka: {e}")

analytics_service = AnalyticsService()