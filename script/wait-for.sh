#!/bin/bash
set -ex

build_namespace_arg() {
    namespace=$1
    if [ -z "$namespace" ]
    then 
	echo "--all-namespaces"
    else
        echo "-n $namespace"
    fi
}

make_sure_pods_exists() {
    ns_arg=$*
    while true
    do
        if [ $(kubectl get pods $ns_arg | wc -l) != 0 ]; then break; fi
        sleep 5
    done
}

make_sure_all_pods_ready() {
    ns_arg=$*
    while true
    do
        if [ $(kubectl get pods $ns_arg -o jsonpath='{range .items[*].status.containerStatuses[*]}{.ready}{"\n"}{end}' | grep -v true | wc -l) = 0 ]; then break; fi
        sleep 5
    done
}

arg=$(build_namespace_arg $1)
make_sure_pods_exists $arg
make_sure_all_pods_ready $arg
