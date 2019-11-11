Para habilitar o dashboard do kubernetes com o minikube, pode-se executar os comandos abaixo:
- `minikube dashboard`
- `minikube addons enable dashboard`

Nesse treinamento, o dashboard do kubernetes está disponível através do link: [dashboard](https://[[HOST_SUBDOMAIN]]-30000-[[KATACODA_HOST]].environments.katacoda.com/).

O dashboard padrão do Kubernetes provê algumas informações, de acordo com a permissão do usuário no cluster, tais como:
- Namespaces: permite visualizar informações dos namespaces disponíveis no cluster.
- Overview: exibe um resumo dos principais recursos instalados no namespace selecionado.
- Workloads: permite visualizar recursos gerenciados pelas controllers (jobs, pods, services, deployments, replicaset, statefulset) do namespace selecionado que estão rodando nos worker-nodes.
- Discovery e Load Balancing: exibe informações sobre exposição de recursos de rede associados ao namespace selecionado do cluster. Nessa opção temos informações sobre services e ingress.
- Config e Storage: agrupa informações de configmaps e secrets associados ao namespace selecionado.
