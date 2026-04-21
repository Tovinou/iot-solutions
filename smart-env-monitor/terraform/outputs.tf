output "proxy_url" {
  value = "http://127.0.0.1:${var.proxy_http_port}"
}

output "containers" {
  value = {
    db    = docker_container.db.name
    redis = docker_container.redis.name
    web   = docker_container.web.name
    proxy = docker_container.proxy.name
  }
}
