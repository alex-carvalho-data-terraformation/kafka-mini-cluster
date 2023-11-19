#####################################################
# controller containers
#####################################################
resource "docker_container" "kafka_controller_11" {
  name  = "kafka-controller-11"
  image = docker_image.kafka_controller.image_id

  networks_advanced {
    name = docker_network.kafka_network.id
  }

  volumes {
    volume_name    = "kafka-controller-11-logs-vol"
    container_path = "/tmp/kraft-controller-logs"
  }

  command = [
    "--cluster-id", "OO7uy3mpQvieepZMySnprQ", 
    "--node-id", "11", 
    "--controller-quorum-voters", "11@kafka-controller-11:9093,12@kafka-controller-12:9093,13@kafka-controller-13:9093"
  ]

  healthcheck {
    test         = ["CMD", "nc", "-z", "kafka-controller-11", "9093"]
    interval     = "10s"
    retries      = 10
    start_period = "3s"
    timeout      = "10s"
  }
}


resource "docker_container" "kafka_controller_12" {
  name  = "kafka-controller-12"
  image = docker_image.kafka_controller.image_id

  networks_advanced {
    name = docker_network.kafka_network.id
  }

  volumes {
    volume_name    = "kafka-controller-12-logs-vol"
    container_path = "/tmp/kraft-controller-logs"
  }

  command = [
    "--cluster-id", "OO7uy3mpQvieepZMySnprQ", 
    "--node-id", "12", 
    "--controller-quorum-voters", "11@kafka-controller-11:9093,12@kafka-controller-12:9093,13@kafka-controller-13:9093"
  ]

  healthcheck {
    test         = ["CMD", "nc", "-z", "kafka-controller-12", "9093"]
    interval     = "10s"
    retries      = 10
    start_period = "3s"
    timeout      = "10s"
  }
}


resource "docker_container" "kafka_controller_13" {
  name  = "kafka-controller-13"
  image = docker_image.kafka_controller.image_id

  networks_advanced {
    name = docker_network.kafka_network.id
  }

  volumes {
    volume_name    = "kafka-controller-13-logs-vol"
    container_path = "/tmp/kraft-controller-logs"
  }

  command = [
    "--cluster-id", "OO7uy3mpQvieepZMySnprQ", 
    "--node-id", "13", 
    "--controller-quorum-voters", "11@kafka-controller-11:9093,12@kafka-controller-12:9093,13@kafka-controller-13:9093"
  ]

  healthcheck {
    test         = ["CMD", "nc", "-z", "kafka-controller-13", "9093"]
    interval     = "10s"
    retries      = 10
    start_period = "3s"
    timeout      = "10s"
  }
}

#####################################################
# broker containers
#####################################################
resource "docker_container" "kafka_broker_101" {
  name  = "kafka-broker-101"
  image = docker_image.kafka_broker.image_id
  depends_on = [
    docker_container.kafka_controller_11,
    docker_container.kafka_controller_12,
    docker_container.kafka_controller_13
  ]

  networks_advanced {
    name = docker_network.kafka_network.id
  }

  volumes {
    volume_name    = "kafka-broker-101-logs-vol"
    container_path = "/tmp/kraft-broker-logs"
  }

  command = [
    "--cluster-id", "OO7uy3mpQvieepZMySnprQ", 
    "--node-id", "101", 
    "--controller-quorum-voters", "11@kafka-controller-11:9093,12@kafka-controller-12:9093,13@kafka-controller-13:9093",
    "--docker-container-name", "kafka-broker-101"
  ]

  ports {
    internal = 9092
    external = 19092
  }

  healthcheck {
    test         = ["CMD", "nc", "-z", "kafka-broker-101", "9092"]
    interval     = "10s"
    retries      = 10
    start_period = "3s"
    timeout      = "10s"
  }
}

# resource "docker_container" "kafka_broker_101" {
#   name  = "kafka-broker-101"
#   image = docker_image.kafka_server.image_id

#   depends_on = [docker_container.kafka_zookeeper]

#   networks_advanced {
#     name = docker_network.kafka_network.id
#   }

#   volumes {
#     volume_name    = "kafka-broker-config-vol"
#     container_path = "/opt/kafka_2.13-3.2.1/config"
#   }

#   volumes {
#     volume_name    = "kafka-broker-101-logs-vol"
#     container_path = "/tmp/kafka-logs"
#   }

#   ports {
#     external = "19092"
#     internal = "19092"
#   }

#   command = [
#     "--override", "zookeeper.connect=${docker_container.kafka_zookeeper.name}:2181",
#     "--override", "broker.id=101",
#     "--override", "listeners=PLAINTEXT://:9092,CONNECTIONS_FROM_HOST://:19092",
#     "--override", "advertised.listeners=PLAINTEXT://kafka-broker-101:9092,CONNECTIONS_FROM_HOST://localhost:19092",
#     "--override", "listener.security.protocol.map=PLAINTEXT:PLAINTEXT,CONNECTIONS_FROM_HOST:PLAINTEXT"
#   ]

#   restart = "on-failure"

#   healthcheck {
#     test         = ["CMD", "nc", "-z", "kafka-broker-101", "9092"]
#     interval     = "3s"
#     retries      = 10
#     start_period = "3s"
#     timeout      = "10s"
#   }
# }


# resource "docker_container" "kafka_broker_102" {
#   name  = "kafka-broker-102"
#   image = docker_image.kafka_server.image_id

#   depends_on = [docker_container.kafka_zookeeper]

#   networks_advanced {
#     name = docker_network.kafka_network.id
#   }

#   volumes {
#     volume_name    = "kafka-broker-config-vol"
#     container_path = "/opt/kafka_2.13-3.2.1/config"
#   }

#   volumes {
#     volume_name    = "kafka-broker-102-logs-vol"
#     container_path = "/tmp/kafka-logs"
#   }

#   ports {
#     external = "29092"
#     internal = "29092"
#   }

#   command = [
#     "--override", "zookeeper.connect=${docker_container.kafka_zookeeper.name}:2181",
#     "--override", "broker.id=102",
#     "--override", "listeners=PLAINTEXT://:9092,CONNECTIONS_FROM_HOST://:29092",
#     "--override", "advertised.listeners=PLAINTEXT://kafka-broker-102:9092,CONNECTIONS_FROM_HOST://localhost:29092",
#     "--override", "listener.security.protocol.map=PLAINTEXT:PLAINTEXT,CONNECTIONS_FROM_HOST:PLAINTEXT"
#   ]

#   restart = "on-failure"

#   healthcheck {
#     test         = ["CMD", "nc", "-z", "kafka-broker-102", "9092"]
#     interval     = "3s"
#     retries      = 10
#     start_period = "3s"
#     timeout      = "10s"
#   }
# }

# resource "docker_container" "kafka_broker_103" {
#   name  = "kafka-broker-103"
#   image = docker_image.kafka_server.image_id

#   depends_on = [docker_container.kafka_zookeeper]

#   networks_advanced {
#     name = docker_network.kafka_network.id
#   }

#   volumes {
#     volume_name    = "kafka-broker-config-vol"
#     container_path = "/opt/kafka_2.13-3.2.1/config"
#   }

#   volumes {
#     volume_name    = "kafka-broker-103-logs-vol"
#     container_path = "/tmp/kafka-logs"
#   }

#   ports {
#     external = "39092"
#     internal = "39092"
#   }

#   command = [
#     "--override", "zookeeper.connect=${docker_container.kafka_zookeeper.name}:2181",
#     "--override", "broker.id=103",
#     "--override", "listeners=PLAINTEXT://:9092,CONNECTIONS_FROM_HOST://:39092",
#     "--override", "advertised.listeners=PLAINTEXT://kafka-broker-103:9092,CONNECTIONS_FROM_HOST://localhost:39092",
#     "--override", "listener.security.protocol.map=PLAINTEXT:PLAINTEXT,CONNECTIONS_FROM_HOST:PLAINTEXT"
#   ]

#   restart = "on-failure"

#   healthcheck {
#     test         = ["CMD", "nc", "-z", "kafka-broker-103", "9092"]
#     interval     = "3s"
#     retries      = 10
#     start_period = "3s"
#     timeout      = "10s"
#   }
# }