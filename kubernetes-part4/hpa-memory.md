O componente de HPA ([Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)) também permite escalar o número de pods de um replication controller, replicaset ou deployment por memória. 


## Forma declarativa de autoscaling de memória

```yaml
apiVersion: autoscaling/v2beta1     # 1
kind: HorizontalPodAutoscaler
metadata:
  name: hpa-example
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: hpa-example
  minReplicas: 2
  maxReplicas: 10
  metrics:                          # 2
  - type: Resource                  # 3
    resource:
      name: memory                  # 4
      targetAverageUtilization: 60  # 5
```

1. Versão específica da api do kubernetes para scale baseado em memória.
2. Define lista de métricas para autoscale.
3. Define o tipo de métrica para autoscale baseado em algum resouce customizado.
4. Define o tipo de métrica para autoscale baseado em memória.
5. % médio de consumo para disparar o mecanismo de autoscaling. Nesse exemplo, 60% de consumo de memória considerando todas as pods.

## Exercício: Testando o autoscaling por consumo de memória

Crie um novo namespace: `kubectl create ns hpa-test`{{execute}}.

Faça uma cópia do arquivo `resources/app-hpa-cpu.yaml` para `resources/app-hpa-memory.yaml`.

Altere o novo arquivo `resources/app-hpa-memory.yaml`{{open}}, substituindo os limites de cpu por limites de memória, conforme abaixo:
- limits.memory: 50Mi
- requests.memory: 13Mi

Crie a aplicação no namespace *hpa-test*: `kubectl -n hpa-test create -f resources/app-hpa-memory.yaml`{{execute}}.

Veja se a pod foi criada corretamente: `kubectl -n hpa-test get pod -w`{{execute}}.

O arquivo `resources/hpa-memory.yaml`{{open}} contém a definição de autoscaling para uma aplicação.
Crie a política de autoscaling para a aplicação no namespace *hpa-test*: `kubectl -n hpa-test create -f resources/hpa-memory.yaml`{{execute}}.

Verifique se o novo resource de HPA foi criado corretamente: `kubectl -n hpa-test get hpa`{{execute}}.
Teremos uma saída semelhante a:

```
NAME         REFERENCE                      TARGET           MINPODS   MAXPODS   REPLICAS   AGE
hpa-example  Deployment/hpa-example         <unknown> / 60%  2         10        1          20s
```

Caso não tenha observado, a quantidade mínima de pods definida no *hpa-memory.yaml* é igual a 2. Portanto, haverá um autoscaling automático.
Observe as linhas de *autoscale*. Devem ser semelhantes às linhas abaixo:

```
2m21s       Normal   ScalingReplicaSet   deployment/hpa-example                Scaled up replica set hpa-example-55f4b9fd4b to 1
2m4s        Normal   SuccessfulRescale   horizontalpodautoscaler/hpa-example   New size: 2; reason: Current number of replicas below Spec.MinReplicas
```

Agora verifique o status do resource de HPA. Qual é a quantidade de replicas?
Agora iremos realizar um teste de carga nessa aplicação para forçar o upscale da mesma.

Na aba terminal, clique no botão **+** e depois na opção *Open New Terminal*.

Dentro do terminal **2**, crie uma nova aplicação para teste: `kubectl -n hpa-test run --generator=run-pod/v1 -it --rm load-generator --image=busybox /bin/sh`{{execute}}.

Após isso, faremos um loop de chamadas HTTP à aplicação *hpa-example*: `while true; do wget -q -O- http://hpa-example.hpa-test.svc.cluster.local; done`{{execute}}.

Agora volte ao terminal **1** e verifique a quantidade de réplicas da aplicação: `kubectl -n hpa-test get deployment -w`{{execute}}.

Verifique o status do resource de HPA: `kubectl -n hpa-test get hpa`{{execute}}.

Verifique os eventos do namespace: `kubectl -n hpa-test get event`{{execute}}. Observe as linhas de *autoscale*. Devem ser semelhantes às linhas abaixo:

```
25m         Normal   ScalingReplicaSet   deployment/hpa-example                Scaled up replica set hpa-example-55f4b9fd4b to 4
24m         Normal   SuccessfulRescale   horizontalpodautoscaler/hpa-example   New size: 5; reason: memory resource utilization (percentage of request)above target
```

Volte ao terminal **2**, pressione *CTRL + C* e feche o mesmo. 

Como ação final, remova o namespace criado: `kubectl delete ns hpa-test`{{execute}}.
