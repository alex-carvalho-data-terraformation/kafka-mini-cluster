resource "docker_image" "kafka_node" {
  name       = "kafka-node"
  build {
    context = "../../docker/kafka-node/"
    build_arg = {
      SCALA_VERSION : "2.13"
      KAFKA_VERSION : "3.6.0"
    }
    tag  = ["kafka-node:latest", "kafka-node:3.6.0-1.0.0"]
  }
}