[POD](https://kubernetes.io/docs/concepts/workloads/pods/pod/) é a menor unidade computacional que pode ser criada e gerenciada pelo k8s.
A pod é um grupo de um ou mais containers que compartilham a rede entre si.

## Estrutura básica de uma pod dentro de um resource de deployment

```yaml
apiVersion: apps/v1
kind: Deployment 
metadata:
  name: webapp 
spec:
  selector:
    matchLabels:
      app: webapp
  replicas: 1
  template: # 1
    metadata:
      labels:
        app: webapp # 2
    spec:
      containers: # 3
      - name: webapp # 4
        image: richardchesterwood/k8s-fleetman-webapp-angular:release1 # 5
        env: # 6
        - name: SPRING_PROFILES_ACTIVE # 6.a
          value: production-microservice # 6.b
```

1. Define o template para criação das pods.
2. Define labels para as pods que serão criadas.
3. Define os containers que subirão em cada pod criada para esse deployment.
4. Define o nome do container a ser criado dentro da pod.
5. Define a imagem utilizada para criação do container dentro da pod.
6. Define variáveis de ambiente que serão definidas dentro do contexto ou sistema operacional do container.
  - a. Nome da variável de ambiente
  - b. Valor da variável de ambiente
