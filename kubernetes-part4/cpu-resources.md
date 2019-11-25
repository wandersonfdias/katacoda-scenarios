Recursos de CPU são definidos para os containers das PODs. 

É possível definir limites mínimo e máximo para consumo de CPU.
- CPU Request: Define o limite mínimo de CPU para funcionamento de um container. Permite valores decimais.
- CPU Limit: Define o limite máximo de CPU que um container pode consumir. Permite valores decimais.

Recursos de CPU são medidos em [unidades de CPU](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/#cpu-units). Uma (01) CPU no kubernetes é equivalente a:
- 01 AWS vCPU
- 01 GCP Core
- 01 Azure vCore
- 01 Hyperthread em processador Intel (bare-metal)

## Definindo CPU para um container

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: cpu-demo
spec:
  containers:
  - name: cpu-demo-ctr
    image: vish/stress
    resources: # 1
      limits: # 2
        cpu: "1" # 3
      requests: # 4
        cpu: "0.5" # 5
```

1. Define configuração de recursos para o container.
2. Define configuração de limite máximo de algum recurso (cpu ou memória) para um container.
3. Define o limite máximo de cpu que será utilizado pelo container.
4. Define configuração de limite mínimo de algum recurso (cpu ou memória) para um container.
5. Define o limite mínimo de cpu que será utilizado pelo container.

## Testando limite de CPU

O arquivo `resources/cpu-demo.yaml`{{open}} contém a definição de recursos de cpu para um container.
A imagem utilizada permite definir a quantidade de CPU que será consumida, via argumentos do container. Observa a tag *args* na definição do container.

Crie a pod no namespace default: `kubectl apply -f resources/cpu-demo.yaml`{{execute}}.

Agora, verifique se a pod está rodando corretamente: `kubectl -n default get pod cpu-demo -w`{{execute}}.

Verifique os recursos de CPU consumidos por essa pod: `kubectl -n default top pod cpu-demo`{{execute}}.

Remova a pod criada: `kubectl -n default delete pod cpu-demo`{{execute}}.

## Testando cenário de recursos de CPU insuficientes para execução do container

Abra o arquivo `resources/cpu-demo.yaml`{{open}} e defina os seguintes limites de CPU:
    - request: 10
    - limit: 10

Como o worker-node disponível no cluster possui apenas 02 cores de recurso, o kubernetes não conseguirá executar essa POD, deixando a mesma num estado *Pending*.

Crie a pod no namespace default: `kubectl apply -f resources/cpu-demo.yaml`{{execute}}.

Verifique o estado da pod: `kubectl -n default get pod cpu-demo -w`{{execute}}.

Faça um describe na pod e observe os eventos da mesma: `kubectl -n default describe pod cpu-demo`{{execute}}.

Remova a pod criada: `kubectl -n default delete pod cpu-demo`{{execute}}.
