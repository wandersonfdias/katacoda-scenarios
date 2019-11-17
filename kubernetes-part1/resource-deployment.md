[Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) é uma forma declarativa para realizar atualização de pods e [replicasets](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/).

Cada novo rollout de um deploy gera uma nova numeração de revisão no k8s.

No deployment é possível definir regras para realizar:
- rollouts de [replicasets](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/);
- estratégias de rollout;
  - Ex: Uma determinada app possui 03 pods.
    Ao realizar um novo rollout, que na nova versão define a quantidade mínima de 04 pods, pode-se definir que uma versão anterior da app somente será descartada, quando uma nova pod na nova versão for considerada como *válida* para o cluster. Esse comportamento pode ser demonstrado abaixo: 
    ![Topologia](/wandersondias/scenarios/kubernetes-part1/assets/deployment-rollout-strategy.png)
- rollbacks de uma revisão anterior;
- defnir estados de uma nova pod;
- definir a quantidade de réplicas ou instâncias das pods que serão criadas;
- remover os deployemnts ou replicasets antigos, caso não sejam mais necessários.

## Estrutura básica de um deployment

```yaml
apiVersion: apps/v1
kind: Deployment  # 1
metadata:
  name: webapp  # 2
spec:
  selector:
    matchLabels:
      app: webapp # 3
  replicas: 1 # 4
  template: # 5
    metadata:
      labels:
        app: webapp # 6
    spec:
      containers: # 7
      - name: webapp # 8
        image: richardchesterwood/k8s-fleetman-webapp-angular:release1 # 9
        env: # 10
        - name: SPRING_PROFILES_ACTIVE
          value: production-microservice
```

1. Define o tipo do resource para o k8s, que nesse cenário é *Deployment*.
2. Define o nome do deployment que será instalado no namespace.
3. Define o seletor para identificar quais pods serão gerenciadas por esse deployment. Vide item **6**.
4. Define a quantidade de réplicas ou instâncias das pods que subirão para o deployment.
5. Define o template para criação das pods.
6. Define labels para as pods que serão criadas. Observe que esse label faz um link com o item **3**.
7. Define os containers que subirão em cada pod criada para esse deployment.
8. Define o nome do container a ser criado dentro da pod.
9. Define a imagem utilizada para criação do container dentro da pod.
10. Define variáveis de ambiente que serão definidas dentro do contexto ou sistema operacional do container.
