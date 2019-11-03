#!/bin/sh

launch.sh

minikube start
minikube addons enable dashboard

source <(kubectl completion bash)

clear && echo 'Kubernetes is ready.' 2> /dev/null
