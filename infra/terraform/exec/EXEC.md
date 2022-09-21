# <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> <img src="img/docker.png" alt="docker" height="30" style="vertical-align: middle;"> | execution

It's intended to be very fast, less than 1 min.   
Here are created and `docker containers` and `docker networks` and destroyed after use.  

## 1. Configuration

1. Go to terraform config dir for execution (from this README folder)
   
```bash
cd infra/terraform/exec/
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

### <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> 3.1. Check terraform objects

```bash
terraform state list
```

*Expected output similar to:*

```bash
docker_container.kafka_broker_101
docker_container.kafka_broker_102
docker_container.kafka_broker_103
docker_container.kafka_zookeeper
docker_image.kafka_server
docker_image.kafka_zookeeper
docker_network.kafka_network
```

### <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.2. Check docker networks

```bash
docker network ls
```

*Expected output similar to:*

```bash
NETWORK ID     NAME            DRIVER    SCOPE
82d88eb126e6   kafka-network   bridge    local
```

### <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.3. Check docker containers

```bash
docker container ls
```

*Expected output similar to:*

```bash
CCONTAINER ID   IMAGE          COMMAND                  CREATED              STATUS                        PORTS                                NAMES
594c666fd56e   6de46593ce0a   "kafka-server-start.…"   About a minute ago   Up About a minute (healthy)   9092/tcp, 0.0.0.0:19092->19092/tcp   kafka-broker-101
6b77ff25fa56   6de46593ce0a   "kafka-server-start.…"   About a minute ago   Up About a minute (healthy)   9092/tcp, 0.0.0.0:29092->29092/tcp   kafka-broker-102
bc92c5ef7ea4   6de46593ce0a   "kafka-server-start.…"   About a minute ago   Up About a minute (healthy)   9092/tcp, 0.0.0.0:39092->39092/tcp   kafka-broker-103
be3370751dc6   ab12883c77b3   "zookeeper-server-st…"   About a minute ago   Up About a minute (healthy)   2181/tcp                             kafka-zookeeper
```

## 4. Undeploy instructions

### 4.1. Stop and remove docker containers and volumes

at `infra/terraform/exec/`  

```bash
terraform destroy
```