# Base image
# ubuntu jammy jellyfish 22.04
FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="allex.carvalho@gmail.com" \
      description="kafka node on ubuntu with java - base for kafka-controller and kafka-broker images"


# Arguments for docker build
ARG JAVA_MAJOR_VERSION=21
ARG SCALA_VERSION=2.13
ARG KAFKA_VERSION=3.6.0
ARG KAFKA_HOME=/opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}


ENV JAVA_MAJOR_VERSION=${JAVA_MAJOR_VERSION} \
    SCALA_VERSION=${SCALA_VERSION} \
    KAFKA_VERSION=${KAFKA_VERSION} \
    KAFKA_HOME=${KAFKA_HOME} \
    PATH="$PATH:${KAFKA_HOME}/bin"


LABEL java.jdk.distribution="adoptium.eclipse temurin" \
      java.jdk.major-version=${JAVA_MAJOR_VERSION} \
      scala.version=${SCALA_VERSION} \
      kafka.version=${KAFKA_VERSION}


# Install auxiliary linux packages
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        wget \
        apt-transport-https \
        netcat \
        vim && \
    apt autoremove && \
    apt clean

# Install JDK
RUN mkdir -p /etc/apt/keyrings && \
    wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc && \
    echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" \
        | tee /etc/apt/sources.list.d/adoptium.list && \
    apt update && \
    apt install -y temurin-${JAVA_MAJOR_VERSION}-jdk/jammy && \
    apt autoremove && \
    apt clean

# Install Kafka
RUN wget -O /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    tar -xzf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && \
    rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz


VOLUME ["$KAFKA_HOME/config"]

WORKDIR ${KAFKA_HOME}

LABEL version="0.1.1"
