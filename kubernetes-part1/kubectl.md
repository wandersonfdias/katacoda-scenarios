[Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) é uma ferramenta que consegue rodar um cluster de Kubernetes no modo all-in-one ou single-node.

[Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) é um CLI (command line interface) que permite comunicar com o cluster Kubernetes através da sua camada de apis.

Vamos listar alguns comandos úteis:

Obter a versão do kubernetes: `kubectl version`{{execute}}

Verificar detalhes sobre o cluster:

- `kubectl get nodes`{{execute}}
- `kubectl cluster-info`{{execute}}
- `kubectl config view`{{execute}}
- `kubectl config get-contexts`{{execute}}
- `kubectl get componentstatus`{{execute}}
- `kubectl describe node minikube`{{execute}}

Listar eventos do cluster: `kubectl get events`{{execute}}

Comandos básicos para recursos do cluster:
- Criação: `kubectl create <resource type> <resource name>`  (ex: *kubectl create namespace teste*)
- Listar recursos: `kubectl get <resource type>` (ex: *kubectl get namespaces*)
- Listar recurso específico: `kubectl get <resource type> <resource name>` (ex: *kubectl get namespace teste*)
- Listar referenciando informações de infra: `kubectl get <resource type> -o wide` (ex: *kubectl -n kube-system get pods -o wide*)
- Listar recursos de todos namespaces: `kubectl get <resource type> --all-namespaces -o wide` (ex: *kubectl get pods --all-namespaces -o wide*)
- Descrever com detalhes: `kubectl describe <resource type> <resource name>` (ex: *kubectl describe namespace teste*)
- Edição: `kubectl edit <resource type> <resource name>` (ex: *kubectl edit namespace teste*)
- Exclusão: `kubectl delete <resource type> <resource name>` (ex: *kubectl delete namespace teste*)

Como boa prática, sempre que formos executar qualquer comando básico, é indicado informar o namespace onde se encontra o recurso. Vide exemplos:
- `kubectl -n teste get pods`
- `kubectl -n teste get pods -o wide`
- `kubectl -n teste get services`

Mais comandos do kubectl podem ser encontrados no [link](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).