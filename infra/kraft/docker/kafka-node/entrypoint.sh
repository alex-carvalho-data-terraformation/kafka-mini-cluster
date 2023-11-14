#!/bin/bash
echo "kafka-node entry point script"


############################# Server Basics #############################

# The role of this server. Setting this puts us in KRaft mode
# process.roles=controller

# The node id associated with this instance's roles
# node.id=1

# The connect string for the controller quorum
# controller.quorum.voters=1@localhost:9093

# log.dirs=/tmp/kraft-controller-logs
# log.dirs=/tmp/kraft-broker-logs


parse_args()
{
    echo "parsing args"
    valid_args=($(getopt -u -o c:r:n:q:h -l cluster-id:,process-roles:,node-id:,controller-quorum-voters:,help -- $@))

    echo "valid_args: ${valid_args[@]}"
    echo "valid_args length: ${#valid_args[@]}"

    for (( i = 0; i < ${#valid_args[@]}; i++)) ; do

        case ${valid_args[$i]} in
            -c|--cluster-id) cluster_id=${valid_args[$i+1]} ;;
            -r|--process-roles) process_roles=${valid_args[$i+1]} ;;
            -n|--node-id) node_id=${valid_args[$i+1]} ;;
            -q|--controller-quorum-voters) controller_quorum_voters=${valid_args[$i+1]} ;;
            -h|--help) 
                echo "pe parameter received"
                pa=${valid_args[$i+1]}
                ;;
            --) break ;;
        esac

    done

    echo ""
    echo "cluster_id: $cluster_id"
    echo "process_roles: $process_roles"
    echo "node_id: $node_id"
    echo "controller_quorum_voters: $controller_quorum_voters"
    echo ""
}

parse_args $@