resource "docker_image" "kafka_node" {
  name         = "oak/kafka-node"
  force_remove = true
  build {
    context = "../../docker/kafka-node/"
    build_arg = {
      SCALA_VERSION : "2.13"
      KAFKA_VERSION : "3.6.0"
    }
    # tag = ["oak/kafka-node:3.6.0-0.2.0"]
  }
}


resource "docker_image" "kafka_controller" {
  name         = "oak/kafka-controller"
  depends_on   = [docker_image.kafka_node]
  force_remove = true
  build {
    context = "../../docker/kafka-controller/"
    build_arg = {
      SCALA_VERSION : "2.13"
      KAFKA_VERSION : "3.6.0"
    }
  }
}


resource "docker_image" "kafka_broker" {
  name         = "oak/kafka-broker"
  depends_on   = [docker_image.kafka_node]
  force_remove = true
  build {
    context = "../../docker/kafka-broker/"
    build_arg = {
      SCALA_VERSION : "2.13"
      KAFKA_VERSION : "3.6.0"
    }
  }
}