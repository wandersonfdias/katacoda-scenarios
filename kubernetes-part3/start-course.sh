#!/bin/sh

launch.sh

#minikube start

source <(kubectl completion bash)

source <(helm completion bash)

# Helm Setup
helm init --wait
helm repo update

# Setup dashboard on port 30000
helm install stable/kubernetes-dashboard --name dash --set=service.type=NodePort --set=enableInsecureLogin=true --set=enableSkipLogin=true --set=service.nodePort=30000 --set=service.externalPort=80 --namespace kube-system

helm install stable/metrics-server --name metrics-server --namespace kube-system --set args[0]="--kubelet-preferred-address-types=InternalIP" --set args[1]="--kubelet-insecure-tls"

{ clear && echo 'Kubernetes with Helm is ready.'; } 2> /dev/null