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

#####################################################
# network
#####################################################
resource "docker_network" "kafka_network" {
  name = "kafka-network"
}

#####################################################
# image
#####################################################
resource "docker_image" "kafka_controller" {
  name         = "oak/kafka-controller:latest"
  keep_locally = true
}


resource "docker_image" "kafka_broker" {
  name         = "oak/kafka-broker:latest"
  keep_locally = true
}

#####################################################
# variables
#####################################################
variable "kafka_cluster_uuid" {
  type = string
  description = "kafka cluster id generated by `kafka-storage.sh random-uuid`"
}