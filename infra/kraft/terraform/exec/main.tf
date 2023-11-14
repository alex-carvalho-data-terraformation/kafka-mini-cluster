terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

#####################################################
# network
#####################################################
resource "docker_network" "kafka_network" {
  name = "kafka-network"
}

#####################################################
# image
#####################################################
resource "docker_image" "kafka_node" {
  name         = "oak/kafka-node:latest"
  keep_locally = true
}

#####################################################
# variables
#####################################################
variable "kafka_cluster_uuid" {
  type = string
  description = "CHANGE_ME"
}