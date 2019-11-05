#!/bin/sh

launch.sh

minikube start

source <(kubectl completion bash)

# enable dashboard
minikube addons enable dashboard

{ clear && echo 'Kubernetes is ready.'; } 2> /dev/null
