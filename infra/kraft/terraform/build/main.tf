terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"  # linux
  # host = "unix:///Users/alex1real/.colima/default/docker.sock" # mac
  # host can be retrieved using `docker context ls`
}

