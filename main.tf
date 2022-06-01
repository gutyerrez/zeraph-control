terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {
  host = "tcp://$DOCKER_SERVER_HOST:$DOCKER_SERVER_PORT"

  registry_auth {
    address  = "registry-1.docker.io"
    username = "$DOCKER_USERNAME"
    password = "$DOCKER_PASSWORD"
  }
}

resource "docker_image" "zeraph-api" {
  name = "srgutyerrez/zeraph:latest"
}

resource "docker_container" "zeraph-api" {
  image = docker_image.zeraph-api.latest
  name = "zeraph-api"

  env = [
    "HOST=${var.HOST}",
    "PORT=${var.PORT}",
    "APP_URL=${var.APP_URL}",
    "NODE_ENV=${var.NODE_ENV}",
    "APP_KEY=${var.APP_KEY}",
    "DRIVE_DISK=${var.DRIVE_DISK}",
    "POSTGRES_DATABASE_HOST=${var.POSTGRES_DATABASE_HOST}",
    "POSTGRES_DATABASE_PORT=${var.POSTGRES_DATABASE_PORT}",
    "POSTGRES_DATABASE_USER=${var.POSTGRES_DATABASE_USER}",
    "POSTGRES_DATABASE_PASSWORD=${var.POSTGRES_DATABASE_PASSWORD}",
    "POSTGRES_DATABASE_NAME=${var.POSTGRES_DATABASE_NAME}"
  ]

  ports {
    internal = 3333
    external = 3333
  }
}