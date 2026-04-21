variable "web_image_name" {
  type    = string
  default = "smart-env-monitor-web:tf"
}

variable "deploy_slot" {
  type    = string
  default = "blue"
}

variable "proxy_http_port" {
  type    = number
  default = 18080
}

variable "debug" {
  type    = string
  default = "1"
}

variable "secret_key" {
  type    = string
  default = "django-insecure-terraform-local"
}

variable "allowed_hosts" {
  type    = string
  default = "localhost,127.0.0.1"
}

variable "csrf_trusted_origins" {
  type    = string
  default = ""
}

variable "secure_ssl_redirect" {
  type    = string
  default = "0"
}

variable "db_conn_max_age" {
  type    = string
  default = "0"
}

variable "device_api_key" {
  type    = string
  default = "change-me"
}

variable "postgres_db" {
  type    = string
  default = "smart_env_monitor"
}

variable "postgres_user" {
  type    = string
  default = "smart_env_monitor"
}

variable "postgres_password" {
  type    = string
  default = "smart_env_monitor"
}

variable "throttle_sensor_ingest" {
  type    = string
  default = "120/min"
}

variable "throttle_sensor_read" {
  type    = string
  default = "600/min"
}
