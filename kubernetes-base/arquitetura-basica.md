O cluster de Kubernetes possui a seguinte arquitetura básica:

![Arquitetura](/wandersondias/scenarios/teste-wanderson/assets/kubernetes-architecture.png)

Um cluster possui ao menos 01 master-node e 01 worker-node. Para termos alta disponibilidade, recomenda-se o uso de múltiplos master-nodes.

# Master Node

Tem a responsabilidade de gerenciar os worker-nodes e respectivos containers no cluster.
Possui os seguintes componentes:

- [kuber-api-server](https://kubernetes.io/docs/concepts/overview/components/#kube-apiserver): Expõe a camada de apis do cluster. Realiza a comunicação entre master e worker nodes.
A camada de apis pode ser consumida por CLI (ex: *kubectl*) ou UI (ex: *kubernetes dashboard*).

- [controller manager](https://kubernetes.io/docs/concepts/overview/components/#kube-controller-manager):
  - kube-controller-mannager: executa componentes, conforme descrito abaixo:
    - Node Controller: responsável por gerenciar os nodes do cluster.
    - Replication Controller: responsável por garantir a quantidade correta de pods no cluster, conforme definição das configurações de cada resource (ex: deployments, replica sets etc).
    - Endpoints Controller: responsável por realizar a ligação entre services e pods.
    - Service Account / Token Controllers: responsável por prover autenticação e autorização para acesso aos namespaces.

  - [cloud-controller-manager](https://kubernetes.io/docs/concepts/architecture/cloud-controller/): executa componentes que interagem com os *cloud providers* (ex: AWS, Azure, GCP etc).
    - Node Controller: responsável por gerenciar os nodes do cluster no *cloud provider*.
    - Route Controller: controla comunicação entre containers que estejam entre diferentes nodes. Recurso aplicável apenas ao *GCE (Google Cloud Engine)*.
    - Service Controller: responsável por gerenciar os *load balancers* do *cloud provider*.
    - Volume Controller: responsável por gerenciar os volumes de armazenamento no *cloud provider*.

- [scheduler](https://kubernetes.io/docs/concepts/overview/components/#kube-scheduler): monitora a criação de novas pods e garante que as mesmas rodem no worker node correto, conforme configurações definidas.

- [etcd](https://kubernetes.io/docs/concepts/overview/components/#etcd): banco de dados distribuído, com alta disponibilidade e do tipo *chave -> valor*.
  Toda informação do cluster é gravada no mesmo (configurações, estado dos objetos etc).

# Worker Node

Tem a responsabilidade de rodar os containers das aplicações. Ou seja, roda as aplicações de negócio.
Possui os seguintes componentes:

- [kubelet](https://kubernetes.io/docs/concepts/overview/components/#kubelet): agente que roda em cada node do cluster. Garante que os containers estejam rodando dentro das pods, conforme suas configurações.

- [kube-proxy](https://kubernetes.io/docs/concepts/overview/components/#kube-proxy): proxy de rede que roda em cada node do cluster. Garante a comunicação de rede das pods dentro e fora do cluster.

- [container runtime](https://kubernetes.io/docs/concepts/overview/components/#container-runtime): camada responsável por executar os containers (ex: docker, cri-o etc).
