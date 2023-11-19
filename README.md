# <img src="img/terraform.png" alt="HashiCorp Terraform" width="30" style="vertical-align: middle;"> | kafka minit cluster | infra #


## <img src="img/terraform.png" alt="Terraform" height="100" style="vertical-align: middle;"> <img src="img/docker.png" alt="Docker" height="100" style="vertical-align: middle;"> <img src="img/kafka-white-logo.png" alt="apache kafka" height="100" style="vertical-align: middle;"> <img src="img/zookeeper.png" alt="apache kafka" height="100" style="vertical-align: middle;">


## What is this folder for? ##

### Quick summary

This project is intended to demosntrate a `Terraform` infrastruture as code for `Apache Kafka`.


## Environments description

There are 2 flavors of environment for this project, one with ZooKeeper and the other with KRaft.

### <img src="img/zookeeper.png" alt="docker" height="20" style="vertical-align: middle;"> 1. Original ZooKeeper environment 

Originally, the environmnent was 1 `ZooKeeper` and 3 `Kafka Brokers` containers. 

[Environment with ZooKeeper description](infra/zookeeper/ENVIRONMENT.md)

### <img src="img/kafka-white-logo.png" alt="docker" height="20" style="vertical-align: middle;"> 2. KRaft environment 

With kafka introduction of KRaft to replace ZooKeeper, a new enviroment was created with 3 `Kafka Brokers` containers. 

[Environment with KRaft description](infra/kraft/ENVIRONMENT.md)



## How do I get set up? ##

### 1. Summary of set up

All environments are built using Terraform.  

Basically it's necessary to initialize the Terraform environment.  

- build
- execution

### 2. build

The build part trigger the construction of objects that consume a lot of time, like the `docker images`.  
It also creates objects that are desired to persist between executions, like `docker volumes`.

#### 2.1. <img src="img/zookeeper.png" alt="docker" height="20" style="vertical-align: middle;"> environment with ZooKeeper build

[build instructions](infra/zookeeper/terraform/build/BUILD.md)

### 3. execution

It's intended to be very fast, less than 1 min.   
Here are created and `docker containers` and `docker networks` and destroyed after use.  

#### <img src="img/zookeeper.png" alt="docker" height="20" style="vertical-align: middle;"> 3.1. environment with ZooKeeper execution

[execution instructions](infra/zookeeper/terraform/exec/EXEC.md)

### 4. Dependencies

- [install docker](https://docs.docker.com/get-docker/) <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;">
- [install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;">


## Who do I talk to? ##

### Repo owner 

alex.carvalho.data@gmail.com