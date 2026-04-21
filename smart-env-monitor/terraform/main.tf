terraform {
  required_version = ">= 1.5.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "smart_env_monitor" {
  name = "smart-env-monitor-tf"
}

resource "docker_volume" "postgres_data" {
  name = "smart-env-monitor-postgres-data-tf"
}

resource "docker_volume" "redis_data" {
  name = "smart-env-monitor-redis-data-tf"
}

resource "docker_volume" "caddy_data" {
  name = "smart-env-monitor-caddy-data-tf"
}

resource "docker_volume" "caddy_config" {
  name = "smart-env-monitor-caddy-config-tf"
}

resource "docker_image" "web" {
  name = var.web_image_name
  build {
    context    = "${path.module}/.."
    dockerfile = "${path.module}/../Dockerfile"
  }
}

resource "docker_container" "db" {
  name  = "smart-env-monitor-db-tf"
  image = "postgres:16-alpine"

  networks_advanced {
    name = docker_network.smart_env_monitor.name
  }

  env = [
    "POSTGRES_DB=${var.postgres_db}",
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
  ]

  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }
}

resource "docker_container" "redis" {
  name  = "smart-env-monitor-redis-tf"
  image = "redis:7-alpine"
  command = ["redis-server", "--appendonly", "yes"]

  networks_advanced {
    name = docker_network.smart_env_monitor.name
  }

  volumes {
    volume_name    = docker_volume.redis_data.name
    container_path = "/data"
  }
}

resource "docker_container" "web" {
  name  = "smart-env-monitor-web-tf"
  image = docker_image.web.name

  networks_advanced {
    name = docker_network.smart_env_monitor.name
  }

  env = [
    "DEBUG=${var.debug}",
    "SECRET_KEY=${var.secret_key}",
    "ALLOWED_HOSTS=${var.allowed_hosts}",
    "CSRF_TRUSTED_ORIGINS=${var.csrf_trusted_origins}",
    "SECURE_SSL_REDIRECT=${var.secure_ssl_redirect}",
    "DATABASE_URL=postgresql://${var.postgres_user}:${var.postgres_password}@smart-env-monitor-db-tf:5432/${var.postgres_db}",
    "DB_CONN_MAX_AGE=${var.db_conn_max_age}",
    "DEVICE_API_KEY=${var.device_api_key}",
    "THROTTLE_SENSOR_INGEST=${var.throttle_sensor_ingest}",
    "THROTTLE_SENSOR_READ=${var.throttle_sensor_read}",
    "CELERY_BROKER_URL=redis://smart-env-monitor-redis-tf:6379/0",
    "CELERY_RESULT_BACKEND=redis://smart-env-monitor-redis-tf:6379/0",
  ]

  depends_on = [docker_container.db, docker_container.redis]

  command = [
    "sh",
    "-c",
    "python manage.py migrate && python manage.py collectstatic --noinput && gunicorn backend.wsgi:application --bind 0.0.0.0:8000",
  ]

  labels {
    label = "com.smart-env-monitor.component"
    value = "web"
  }
  labels {
    label = "com.smart-env-monitor.deploy.slot"
    value = var.deploy_slot
  }
}

resource "docker_container" "proxy" {
  name  = "smart-env-monitor-proxy-tf"
  image = "caddy:2-alpine"

  networks_advanced {
    name = docker_network.smart_env_monitor.name
  }

  ports {
    internal = 80
    external = var.proxy_http_port
    ip       = "127.0.0.1"
  }

  env = ["SITE_ADDRESS=:80"]

  mounts {
    target = "/etc/caddy/Caddyfile"
    source = "${path.module}/../Caddyfile"
    type   = "bind"
    read_only = true
  }

  volumes {
    volume_name    = docker_volume.caddy_data.name
    container_path = "/data"
  }

  volumes {
    volume_name    = docker_volume.caddy_config.name
    container_path = "/config"
  }

  depends_on = [docker_container.web]

  labels {
    label = "com.smart-env-monitor.component"
    value = "proxy"
  }
  labels {
    label = "com.smart-env-monitor.deploy.slot"
    value = var.deploy_slot
  }
}
