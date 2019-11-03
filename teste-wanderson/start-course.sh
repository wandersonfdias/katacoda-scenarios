#!/bin/sh

launch.sh


source <(kubectl completion bash)

#minikube start
# enable dashboard
minikube addons enable dashboard

{ clear && echo 'Kubernetes is ready.'; } 2> /dev/null
