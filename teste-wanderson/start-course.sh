#!/bin/bash

minikube start

source <(kubectl completion bash)

{ clear && echo 'Kubernetes is ready.'; } 2> /dev/null
