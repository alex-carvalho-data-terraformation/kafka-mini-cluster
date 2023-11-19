#!/bin/bash

print_parsed_args () {
    echo ""
    echo "cluster_id: $cluster_id"
    echo "node_id: $node_id"
    echo "controller_quorum_voters: $controller_quorum_voters"
    echo "docker_container_name: $docker_container_name"
    echo "port: $port"
    echo ""
}


print_help () {
    echo ""
    echo "Usage:"
    echo " entrypoint.sh [options]"
    echo ""
    echo "Options:"
    echo " -c, --cluster-id                 kafka cluster uuid"
    echo "                                  example:"
    echo "                                    --cluster-id OO7uy3mpQvieepZMySnprQ"
    echo " -n, --node-id                    controller node id"
    echo "                                  example:"
    echo "                                    --node-id 11"
    echo " -q, --controller-quorum-voters   comma separated list of quorum voters."
    echo "                                  pattern:"
    echo "                                    single node:"
    echo "                                      [node id]@[host]:[port]"
    echo "                                    multiple nodes:"
    echo "                                      [node id]@[host]:[port],[node id]@[host]:[port]"
    echo "                                  example:"
    echo "                                    --controller-quorum-voters 11@kafka-controller-11:9093,12@kafka-controller-12:9093"
    echo " -d, --docker-container-name      docker container name"
    echo "                                  example:"
    echo "                                    --docker-container-name kafka-broker-101"
    echo " -l, --listener-port              exposed listener port"
    echo "                                  example:"
    echo "                                    --listener-port 19092"
    echo " -h, --help                       display this help"
    echo ""
    echo "Example:"
    echo " ./entrypoint.sh --cluster-id OO7uy3mpQvieepZMySnprQ --node-id 11 --controller-quorum-voters 11@kafka-controller-11:9093,12@kafka-controller-12:9093,13@kafka-controller-13:9093 --docker-container-name kafka-broker-101"

    exit 0
}


parse_args()
{
    valid_args=($(getopt -u -o c:n:q:d:p:h -l cluster-id:,node-id:,controller-quorum-voters:,docker-container-name:,port:,help -- $@))

    for (( i = 0; i < ${#valid_args[@]}; i++)) ; do

        case ${valid_args[$i]} in
            -c|--cluster-id)                cluster_id=${valid_args[$i+1]} ;;
            -n|--node-id)                   node_id=${valid_args[$i+1]} ;;
            -q|--controller-quorum-voters)  controller_quorum_voters=${valid_args[$i+1]} ;;
            -d|--docker-container-name)     docker_container_name=${valid_args[$i+1]} ;;
            -p|--port)                      port=${valid_args[$i+1]} ;;
            -h|--help)                      print_help ;;
            --) break ;;
        esac

    done
}


generate_broker_properties()
{
    properties_file_name=broker_${node_id}.properties

    sed \
      -e s/node.id=2/node.id=$node_id/ \
      -e s/controller.quorum.voters=1@localhost:9093/controller.quorum.voters=$controller_quorum_voters/ \
      -e s#listeners=PLAINTEXT.*9092#listeners=PLAINTEXT://$docker_container_name:9092,PLAINTEXT_HOST://0.0.0.0:$port# \
      -e s#advertised.listeners=PLAINTEXT.*9092#advertised.listeners=PLAINTEXT://$docker_container_name:9092,PLAINTEXT_HOST://localhost:$port# \
      -e s#listener.security.protocol.map=.*SASL_SSL#listener.security.protocol.map=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT# \
      ${KAFKA_HOME}/config/kraft/broker.properties > ${KAFKA_HOME}/config/kraft/$properties_file_name
}


format_log_dir()
{
    echo "formatting log dir"

    kafka-storage.sh format -t $cluster_id -c $KAFKA_HOME/config/kraft/$properties_file_name
}


start_kafka_broker()
{
    echo "starting kafka broker $node_id"

    kafka-server-start.sh ${KAFKA_HOME}/config/kraft/$properties_file_name
}

print_header()
{
    echo ""
    echo "kafka-broker entry point script"
}

print_header

parse_args $@
print_parsed_args

generate_broker_properties

format_log_dir

start_kafka_broker
