#!/bin/bash

print_parsed_args () {
    echo ""
    echo "cluster_id: $cluster_id"
    echo "node_id: $node_id"
    echo "controller_quorum_voters: $controller_quorum_voters"
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
    echo "                                    --controller-quorum-voters 11@localhost:9093,12@controller12:9093"
    echo " -h, --help                       display this help"
    echo ""
    echo "Example:"
    echo " ./entrypoint.sh --cluster-id OO7uy3mpQvieepZMySnprQ --node-id 11 --controller-quorum-voters 11@localhost:9093,12@controller12:9093,13@controller13:9093"

    exit 0
}


parse_args()
{
    valid_args=($(getopt -u -o c:n:q:h -l cluster-id:,node-id:,controller-quorum-voters:,help -- $@))

    for (( i = 0; i < ${#valid_args[@]}; i++)) ; do

        case ${valid_args[$i]} in
            -c|--cluster-id)                cluster_id=${valid_args[$i+1]} ;;
            -n|--node-id)                   node_id=${valid_args[$i+1]} ;;
            -q|--controller-quorum-voters)  controller_quorum_voters=${valid_args[$i+1]} ;;
            -h|--help)                      print_help ;;
            --) break ;;
        esac

    done
}


generate_controller_properties()
{
    properties_file_name=controller_${node_id}.properties

    sed \
      -e s/node.id=1/node.id=$node_id/ \
      -e s/controller.quorum.voters=1@localhost:9093/controller.quorum.voters=$controller_quorum_voters/ \
      ${KAFKA_HOME}/config/kraft/controller.properties > ${KAFKA_HOME}/config/kraft/$properties_file_name
}


format_controller_log_dir()
{
    echo "formatting controller log dir"

    kafka-storage.sh format -t $cluster_id -c $KAFKA_HOME/config/kraft/$properties_file_name
}


start_kafka_controller()
{
    echo "starting kafka controler $node_id"

    kafka-server-start.sh ${KAFKA_HOME}/config/kraft/$properties_file_name
}

print_header()
{
    echo ""
    echo "kafka-controller entry point script"
}

print_header

parse_args $@
print_parsed_args

generate_controller_properties

format_controller_log_dir

start_kafka_controller
