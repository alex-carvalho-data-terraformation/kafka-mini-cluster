resource "docker_volume" "kafka_broker_101_logs_vol" {
  name = "kafka-broker-101-logs-vol"
}

resource "docker_volume" "kafka_broker_102_logs_vol" {
  name = "kafka-broker-102-logs-vol"
}

resource "docker_volume" "kafka_broker_103_logs_vol" {
  name = "kafka-broker-103-logs-vol"
}

resource "docker_volume" "kafka_controller_11_logs_vol" {
  name = "kafka-controller-11-logs-vol"
}

resource "docker_volume" "kafka_controller_12_logs_vol" {
  name = "kafka-controller-12-logs-vol"
}

resource "docker_volume" "kafka_controller_13_logs_vol" {
  name = "kafka-controller-13-logs-vol"
}