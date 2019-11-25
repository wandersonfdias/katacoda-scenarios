Recursos de memória são definidos para os containers das PODs. 

É possível definir limites mínimo e máximo para consumo de memória.
- Memory Request: Define o limite mínimo de memória para funcionamento de um container. Permite valores inteiros.
- Memory Limit: Define o limite máximo de memória que um container pode consumir. Permite valores inteiros.

**Dica**: Não defina apenas o Memory Limit. Se isso ocorrer, o kubernetes associará o valor de Memory Limit ao valor de Memory Request. Definir valor igual a zero é permitido também.

**ATENÇÃO:** Se os limites de memória não forem definidos, o container poderá consumir todo o recurso de memória de um node.

Recursos de memória são medidos em [unidades de memória](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/#memory-units).
As unidades mais utilizadas são:
- Kbyte: 100K ou 100Ki *(1Ki equivale a 1024 bytes)*
- Megabyte: 100M ou 100Mi *(1Mi equivale a 1024 KB)*
- Gigabyte: 100G ou 100Gi *(1Gi equivale a 1024 MB)*
- Terabyte: 1T ou 1Ti *(1Ti equivale a 1024 GB)*

## Definindo recursos de memória para um container

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: memory-demo
spec:
  containers:
  - name: memory-demo-ctr
    image: polinux/stress
    resources:          # 1
      limits:           # 2
        memory: "200Mi" # 3
      requests:         # 4
        memory: "100Mi" # 5
```

1. Define configuração de recursos para o container.
2. Define configuração de limite máximo de algum recurso (cpu ou memória) para um container.
3. Define o limite máximo de memória que será utilizado pelo container.
4. Define configuração de limite mínimo de algum recurso (cpu ou memória) para um container.
5. Define o limite mínimo de memória que será utilizado pelo container.

## Testando limite de memória

O arquivo `resources/memory-demo.yaml`{{open}} contém a definição de recursos de memória para um container.
A imagem utilizada permite definir a quantidade de memória que será consumida, via argumentos do container. Observa a tag *args* na definição do container.

Crie a pod no namespace default: `kubectl apply -f resources/memory-demo.yaml`{{execute}}.

Agora, verifique se a pod está rodando corretamente: `kubectl -n default get pod memory-demo -w`{{execute}}.

Verifique os recursos de memória consumidos por essa pod: `kubectl -n default top pod`{{execute}}.

Caso as métricas dessa pod ainda não estejam disponíveis, a seguinte mensagem de erro será retornada: 
> `Error from server (NotFound): podmetrics.metrics.k8s.io "default/memory-demo" not found`

Após os recursos de memória serem retornados para essa pod, verfique o consumo de memória do node: `kubectl -n default top node`{{execute}}.

Remova a pod criada: `kubectl -n default delete pod memory-demo`{{execute}}.

## Testando cenário de recursos de memória insuficientes para execução do container

Abra o arquivo `resources/memory-demo.yaml`{{open}} e faça o seguinte: 
  - defina os seguintes limites de memória:
    - request: 200Mi
    - limit: 300Mi
  - defina também o parâmetro *"--vm-bytes", "150M"* com valor igual a 500M. 
    - Isso forçará o container a consumir 500MB de memória.

Crie a pod no namespace default: `kubectl apply -f resources/memory-demo.yaml`{{execute}}.

Quando a pod tentar consumir mais memória do que o limite permitido, o container será finalizado por falta de memória disponível (OOMKilled). Nesse cenário, a quantidade de *RESTARTS* será incrementada.

Verifique o estado da pod: `kubectl -n default get pod memory-demo -w`{{execute}}.

Faça um describe na pod e observe os eventos da mesma: `kubectl -n default describe pod memory-demo`{{execute}}.

A seguinte mensagem deve aparecer na seção *Events*:
```
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  17s                default-scheduler  Successfully assigned default/memory-demo to node01
  Normal   Pulling    15s (x2 over 17s)  kubelet, node01    Pulling image "polinux/stress"
  Normal   Pulled     13s (x2 over 15s)  kubelet, node01    Successfully pulled image "polinux/stress"
  Normal   Created    13s (x2 over 15s)  kubelet, node01    Created container memory-demo-ctr
  Normal   Started    13s (x2 over 15s)  kubelet, node01    Started container memory-demo-ctr
  Warning  BackOff    12s (x2 over 13s)  kubelet, node01    Back-off restarting failed container
```

Remova a pod criada: `kubectl -n default delete pod memory-demo`{{execute}}.

## Testando cenário de recursos de memória insuficientes no node para execução do container

Abra o arquivo `resources/memory-demo.yaml`{{open}} e defina os seguintes limites de memória:
  - request: 10i
  - limit: 10Gi

Crie a pod no namespace default: `kubectl apply -f resources/memory-demo.yaml`{{execute}}.

Como o worker-node disponível não possui o limite de memória solicitado, o kubernetes não conseguirá executar essa POD, deixando a mesma num estado *Pending*.

Verifique o estado da pod: `kubectl -n default get pod memory-demo -w`{{execute}}.

Faça um describe na pod e observe os eventos da mesma: `kubectl -n default describe pod memory-demo`{{execute}}.

A seguinte mensagem deve aparecer na seção *Events*:
```
Events:
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  11s   default-scheduler  0/2 nodes are available: 2 Insufficient memory.
```

Remova a pod criada: `kubectl -n default delete pod memory-demo`{{execute}}.
