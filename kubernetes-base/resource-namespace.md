Namespace serve para agrupar aplicações. Nele é possível isolar todos recursos de uma aplicação ou conjunto de aplicações. O namespace é um agrupamento ou separação lógica no cluster.
- Ex: gc-dev, gc-uat, gc-prd

É possível também adicionar regras para limitar uso de recursos por namespace e até definir afinidade de worker-nodes para aplicações instaladas no mesmo. Esses temas serão detalhados futuramente.

Comandos básicos:
- `kubectl get namespaces`
- `kubectl get ns`
- `kubectl get ns <namespace>`
- `kubectl create ns <namespace>`
- `kubectl describe ns <namespace>`
