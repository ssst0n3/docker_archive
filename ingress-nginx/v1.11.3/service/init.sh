#!/bin/bash

# wait pods ready
until kubectl wait --for=condition=Ready pod --all -A --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# install ingress-nginx
# https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.3/deploy/static/provider/cloud/deploy.yaml >>/dev/kmsg 2>&1

# wait pods ready
until kubectl wait --for=condition=Ready pod --all -A --field-selector=status.phase!=Succeeded --timeout=5s; do sleep 1; done >>/dev/kmsg 2>&1

# remove unused containers
crictl rm $(crictl ps -a -q) >>/dev/kmsg 2>&1

# prevent data lost
sync

# gracefully exit
systemctl exit 0
