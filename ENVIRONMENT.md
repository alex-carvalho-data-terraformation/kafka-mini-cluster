# environment #

## Quick summary  

<img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> Terraform infrastructure containing: 

### network

- 1 network called `kafka-network`

### containers <img src="img/docker.png" alt="docker" height="30" style="vertical-align: middle;">

- 1 <img src="img/zookeeper.png" alt="ZooKeeper" height="20" style="vertical-align: middle;"> [ZooKeeper](#zookeeper)
- 3 <img src="img/kafka-white-logo.png" alt="Apache Kafka" height="20" style="vertical-align: middle;"> [Kafka](#kafka)


# container descriptions #

## ZooKeeper

<img src="img/zookeeper.png" alt="ZooKeeper" height="60" style="vertical-align: middle;">

### software

- ZooKeeper 3.6.3
- ubuntu 22.04 (jammy jellyfish)

### exposed ports (host:container)

- None (it uses 2181 inside the internal network)

## Kafka

<img src="img/kafka-white-logo.png" alt="Apache Kafka" height="60" style="vertical-align: middle;">  

### containers purpose

- 3 kafka brokers

All 3 containers use the same docker image.  

### software

- kafka 2.13-3.2.1  
- ubuntu 22.04 (jammy jellyfish)

### exposed ports (host:container)

- 19092:9092  
- 29092:9092  
- 39092:9092  
_* all containers expose port 9092, each of them attach to different port at the host_


### container specific info

#### Broker Ids

- 101
- 102
- 103

#### --bootstrap-server parameter pattern

`--bootstrap-server localhost:19092`
