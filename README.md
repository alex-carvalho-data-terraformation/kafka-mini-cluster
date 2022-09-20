# <img src="img/terraform-logo.png" alt="HashiCorp Terraform" width="30" style="vertical-align: middle;"> | airflow with celery executor - redis queue - postgres backend | infra #


## <img src="img/terraform-logo.png" alt="Terraform" height="100" style="vertical-align: middle;"> <img src="img/docker.png" alt="Docker" height="100" style="vertical-align: middle;"> <img src="img/kafka-white-logo.png" alt="apache kafka" height="100" style="vertical-align: middle;"> <img src="img/zookeeper.png" alt="apache kafka" height="100" style="vertical-align: middle;">


## What is this folder for? ##

### Quick summary

This project is intended to demosntrate a `Terraform` infrastruture as code for `Apache Kafka` with 1 `ZooKeeper` and 3 `Kafka Brokers`containers. 

[Environment description](ENVIRONMENT.md)


## How do I get set up? ##

### 1. Summary of set up

All environment is built using Terraform.  

Basically it's necessary to initialize the Terraform environment.  

- [build](BUILD.md)
- [execution](EXEC.md)

### 2. build

The build part trigger the construction of objects that consume a lot of time, like the `docker images`.  
It also creates objects that are desired to persist between executions, like `docker volumes`.

[build instructions](BUILD.md)

### 3. execution

It's intended to be very fast, less than 1 min.   
Here are created and `docker containers` and `docker networks` and destroyed after use.  

[execution instructions](EXEC.md)

### 4. Dependencies

- [install docker](https://docs.docker.com/get-docker/) <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;">
- [install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) <img src="img/terraform-logo.png" alt="Terraform" height="30" style="vertical-align: middle;">


## Who do I talk to? ##

### Repo owner 

alex.carvalho.data@gmail.com