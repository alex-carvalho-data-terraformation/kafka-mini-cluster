#!/bin/bash
echo "kafka-controller entry point script"


############################# Server Basics #############################

# The role of this server. Setting this puts us in KRaft mode
# process.roles=controller

# The node id associated with this instance's roles
# node.id=1

# The connect string for the controller quorum
# controller.quorum.voters=1@localhost:9093

# log.dirs=/tmp/kraft-controller-logs
# log.dirs=/tmp/kraft-broker-logs

# shell test command
# ./entrypoint.sh --cluster-id 123 --process-roles controller --node-id 11 --controller-quorum-voters 11@localhost:9093


print_parsed_args () {
    echo ""
    echo "cluster_id: $cluster_id"
    echo "process_roles: $process_roles"
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
    echo " -n, --node-id                    controller node id"
    echo " -q, --controller-quorum-voters   comma separated list of quorum voters."
    echo "                                  pattern:"
    echo "                                   [node id]@[host]:[port]"
    echo " -h, --help                       display this help"
    echo ""
    echo "Example:"
    echo " :/# ./entrypoint.sh --cluster-id 123 --node-id 11 --controller-quorum-voters 11@localhost:9093,12@controller12:9093,13@controller13:9093"

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

parse_args $@
print_parsed_args