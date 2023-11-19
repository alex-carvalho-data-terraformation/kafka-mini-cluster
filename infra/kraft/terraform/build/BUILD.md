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
docker_image.kafka_broker
docker_image.kafka_controller
docker_image.kafka_node
docker_volume.kafka_broker_101_logs_vol
docker_volume.kafka_broker_102_logs_vol
docker_volume.kafka_broker_103_logs_vol
docker_volume.kafka_controller_11_logs_vol
docker_volume.kafka_controller_12_logs_vol
docker_volume.kafka_controller_13_logs_vol
```

### <img src="../../../../img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.2. Check docker images

```bash
docker image ls
```

*Expected output similar to:*

```bash
REPOSITORY             TAG       IMAGE ID       CREATED          SIZE
oak/kafka-broker       latest    b122b9407c16   59 minutes ago   686MB
oak/kafka-controller   latest    4db94015fa3c   19 hours ago     686MB
oak/kafka-node         latest    0361021ac718   26 hours ago     686MB
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
local     kafka-controller-11-logs-vol
local     kafka-controller-12-logs-vol
local     kafka-controller-13-logs-vol
```

## 4. Undeploy instructions

### 4.1. Stop and remove docker containers and volumes

at `infra/kraft/terraform/build/`  

```bash
terraform destroy
```
