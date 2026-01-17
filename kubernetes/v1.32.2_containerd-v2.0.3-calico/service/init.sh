#!/bin/bash

log() {
  echo "[docker-archive/kubernetes/v1.32.2_containerd-v2.0.3-calico] $1" >> /dev/kmsg
}

wait_kube_system_pods_ready() {
  log "Waiting for kube-system pods to be ready"
  until kubectl wait --for=condition=Ready pod --all -A --field-selector=metadata.namespace=kube-system -l "k8s-app!=kube-dns" --timeout=5s; do 
    sleep 1
  done >>/dev/kmsg 2>&1
  log "kube-system pods are ready"
}

check_all_pods_ready() {
  kubectl wait --for=condition=Ready pod --all -A --timeout=5s >/dev/null 2>&1
}

wait_pods_stable() {
  local stable_checks=${1:-3}  # Number of consecutive successful checks (default: 3)
  local check_interval=${2:-10} # Interval between checks in seconds (default: 10)
  local max_wait=${3:-600}      # Maximum wait time in seconds (default: 10 minutes)
  local start_time=$(date +%s)
  local consecutive_ready=0
  
  log "Waiting for all pods to be ready and stable (stable_checks=${stable_checks}, interval=${check_interval}s)"
  
  while [ $(($(date +%s) - start_time)) -lt $max_wait ]; do
    if check_all_pods_ready; then
      consecutive_ready=$((consecutive_ready + 1))
      log "All pods ready (consecutive check: ${consecutive_ready}/${stable_checks})"
      
      if [ $consecutive_ready -ge $stable_checks ]; then
        log "All pods are stable and ready"
        return 0
      fi
    else
      consecutive_ready=0
      log "Some pods are not ready yet, resetting stability counter"
    fi
    
    sleep $check_interval
  done
  
  log "Timeout waiting for pods to be stable (max_wait=${max_wait}s)"
  return 1
}

wait_all_pods_stable() {
  log "Waiting for all pods to be ready and stable"
  wait_pods_stable 3 10 600 >>/dev/kmsg 2>&1
}

install_calico_network() {
  log "Installing Calico network addon"
  # https://docs.tigera.io/calico/3.29/getting-started/kubernetes/requirements
  # https://docs.tigera.io/calico/3.29/getting-started/kubernetes/quickstart#install-calico
  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.7/manifests/tigera-operator.yaml >>/dev/kmsg 2>&1
  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.7/manifests/custom-resources.yaml >>/dev/kmsg 2>&1
  log "Calico network addon installed"
}

cleanup_unused_containers() {
  log "Removing unused containers"
  crictl rm $(crictl ps -a -q) >>/dev/kmsg 2>&1
  log "Unused containers removed"
}

sync_data() {
  log "Syncing data to prevent data loss"
  sync
  log "Data synced"
}

graceful_exit() {
  log "Gracefully exiting systemd"
  systemctl exit 0
}

wait_kube_system_pods_ready
install_calico_network
wait_all_pods_stable
cleanup_unused_containers
sync_data
graceful_exit

