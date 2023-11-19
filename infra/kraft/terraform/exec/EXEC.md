# <img src="../../../../img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> <img src="../../../../img/docker.png" alt="docker" height="30" style="vertical-align: middle;"> | execution

It's intended to be very fast, less than 1 min.   
Here are created and `docker containers` and `docker networks` and destroyed after use.  

## 1. Configuration

1. Go to terraform config dir for execution (from this README folder)
   
```bash
cd infra/kraft/terraform/exec/
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
docker_container.kafka_broker_101
docker_container.kafka_broker_102
docker_container.kafka_broker_103
docker_container.kafka_controller_11
docker_container.kafka_controller_12
docker_container.kafka_controller_13
docker_image.kafka_broker
docker_image.kafka_controller
docker_network.kafka_network
```

### <img src="../../../../img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.2. Check docker networks

```bash
docker network ls
```

*Expected output similar to:*

```bash
NETWORK ID     NAME            DRIVER    SCOPE
82d88eb126e6   kafka-network   bridge    local
```

### <img src="../../../../img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.3. Check docker containers

```bash
docker container ls
```

*Expected output similar to:*

TODO: CHANGE_ME
```bash
CCONTAINER ID   IMAGE          COMMAND                  CREATED              STATUS                        PORTS                                NAMES
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                    PORTS                      NAMES
b9bcd61df3dd   b122b9407c16   "./entrypoint.sh --c…"   41 seconds ago   Up 40 seconds (healthy)   0.0.0.0:29092->29092/tcp   kafka-broker-102
73847e545896   b122b9407c16   "./entrypoint.sh --c…"   41 seconds ago   Up 40 seconds (healthy)   0.0.0.0:39092->39092/tcp   kafka-broker-103
ad73b6e00990   b122b9407c16   "./entrypoint.sh --c…"   41 seconds ago   Up 40 seconds (healthy)   0.0.0.0:19092->19092/tcp   kafka-broker-101
da267be4df40   4db94015fa3c   "./entrypoint.sh --c…"   42 seconds ago   Up 41 seconds (healthy)   9093/tcp                   kafka-controller-13
b59af36cd079   4db94015fa3c   "./entrypoint.sh --c…"   42 seconds ago   Up 41 seconds (healthy)   9093/tcp                   kafka-controller-12
8b9a69c8726b   4db94015fa3c   "./entrypoint.sh --c…"   42 seconds ago   Up 41 seconds (healthy)   9093/tcp                   kafka-controller-11
```

## 4. Undeploy instructions

### 4.1. Stop and remove docker containers and volumes

at `infra/kraft/terraform/exec/`  

```bash
terraform destroy
```