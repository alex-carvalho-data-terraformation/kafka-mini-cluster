# <img src="../../../../img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> <img src="../../../../img/docker.png" alt="docker" height="30" style="vertical-align: middle;"> | build

The build part trigger the construction of objects that consume a lot of time, like the `docker images`.  
It also creates objects that are desired to persist between executions, like `docker volumes`.

## 1. Configuration

1. Go to terraform config dir for build (from this README folder)
   
```bash
cd infra/kafka/terraform/build/
```

2. Initialize Terraform

```bash
terraform init
```

## 2. Deployment instructions

Execute the build.  

```bash
terraform apply
```

## 3. How to run tests

### <img src="../../../../img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> 3.1. Check terraform objects

```bash
terraform state list
```

*Expected output similar to:*

```bash
docker_image.kafka_node
docker_volume.kafka_broker_101_logs_vol
docker_volume.kafka_broker_102_logs_vol
docker_volume.kafka_broker_103_logs_vol
docker_volume.kafka_broker_config_vol
docker_volume.kafka_controller_11_logs_vol
docker_volume.kafka_controller_12_logs_vol
docker_volume.kafka_controller_13_logs_vol
docker_volume.kafka_controller_config_vol
```

### <img src="../../../../img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.2. Check docker images

```bash
docker image ls
```

*Expected output similar to:*

```bash
REPOSITORY        TAG           IMAGE ID       CREATED         SIZE
kafka-node        3.6.0-1.0.0   adcafedd0aab   2 minutes ago   982MB
kafka-node        latest        adcafedd0aab   2 minutes ago   982MB
```

### <img src="../../../../img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.3. Check docker volumes

```bash
docker volume ls
```

*Expected output similar to:*

```bash
DRIVER    VOLUME NAME
local     kafka-broker-101-logs-vol
local     kafka-broker-102-logs-vol
local     kafka-broker-103-logs-vol
local     kafka-broker-config-vol
local     kafka-controller-11-logs-vol
local     kafka-controller-12-logs-vol
local     kafka-controller-13-logs-vol
local     kafka-controller-config-vol
```

## 4. Undeploy instructions

### 4.1. Stop and remove docker containers and volumes

at `env/zookeeper/terraform/build/`  

```bash
terraform destroy
```

### 4.2. Remove docker images

```bash
docker image rm kafka-base:3.2.1-1.0.0 kafka-server:3.2.1-1.0.0 kafka-zookeeper:3.2.1-1.0.0
```