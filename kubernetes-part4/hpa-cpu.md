O componente de HPA ([Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)) permite escalar o número de pods de um replication controller, replicaset ou deployment. 

O mesmo possui as seguintes características:
- permite autoscaling através de métricas de cpu ou memória;
- permite definir a quantidade mínima e máxima de pods;
- permite definição de métricas custom para autoscale (ex: quantidade de requests);
- é definido através de um kind do tipo *HorizontalPodAutoscaler*; 
- verifica periodicamente métricas de uso de objetos do cluster que possuam definição de autoscaling;
  - periodicidade padrão: 15s
- permite upscale e downscale de pods;
  - o tempo padrão para realizar o downscale é de 5 minutos;
    - vide atributo: *--horizontal-pod-autoscaler-downscale-stabilization* 
- vide mais detalhes do [algoritmo](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#algorithm-details) de autoscaler.

## Forma imperativa de autoscaling de cpu

Comando: `kubectl autoscale <kind> <resource-name> --cpu-percent=50 --min=1 --max=10`
- kind: tipo do objeto que terá autoscaling (ex: deployment);
- resouce-name: nome do objeto que terá autoscalingl;
- cpu-percent: % médio de consumo para disparar o mecanismo de autoscaling;
- min: quantidade mínima de réplicas da pod após o downscale;
- max: quantidade máxima de réplicas da pod após o upscale;

ex: `kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10`

## Forma declarativa de autoscaling de cpu

```yaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler           # 1
metadata:
  name: cpu-hpa                         # 2
spec:
  scaleTargetRef:                       # 3
    apiVersion: apps/v1
    kind: Deployment                    # 4
    name: hpa-example                   # 5
  minReplicas: 1                        # 6
  maxReplicas: 6                        # 7
  targetCPUUtilizationPercentage: 50    # 8
```

1. Define o tipo do resource para o k8s, que nesse cenário é *HorizontalPodAutoscaler*.
2. Define o nome do objeto que será aplicado ao namespace.
3. Define configurações para aplicação do autoscaler;
4. Define o tipo do objeto do cluster que terá a política de autoscaling configurada;
5. Define o objeto do cluster que terá a política de autoscaling configurada;
6. Quantidade mínima de réplicas da pod após o downscale;
7. Quantidade máxima de réplicas da pod após o upscale;
8. % médio de consumo para disparar o mecanismo de autoscaling. Nesse exemplo, 50% de consumo de cpu considerando todas as pods.

## Testando o autoscaling por consumo de cpu

Crie um novo namespace: `kubectl create ns hpa-test`{{execute}}.

O arquivo `resources/app-hpa-cpu.yaml`{{open}} contém a definição da aplicação que será criada.
Crie a aplicação no namespace *hpa-test*: `kubectl -n hpa-test create -f resources/app-hpa-cpu.yaml`{{execute}}.

Veja se a pod foi criada corretamente: `kubectl -n hpa-test get pod -w`{{execute}}.

O arquivo `resources/hpa-cpu.yaml`{{open}} contém a definição de autoscaling para uma aplicação.
Crie a política de autoscaling para a aplicação no namespace *hpa-test*: `kubectl -n hpa-test create -f resources/hpa-cpu.yaml`{{execute}}.

Verifique se o novo resource de HPA foi criado corretamente: `kubectl -n hpa-test get hpa`{{execute}}.
Teremos uma saída semelhante a:

```
NAME         REFERENCE                      TARGET           MINPODS   MAXPODS   REPLICAS   AGE
hpa-example  Deployment/hpa-example/scale   <unknown> / 50%  1         6         1          20s
```

Até o momento, temos apenas uma réplica criada e a política de autoscaling de cpu aplicada à aplicação.
Agora iremos realizar um teste de carga nessa aplicação para forçar o upscale da mesma.

Na aba terminal, clique no botão **+** e depois na opção *Open New Terminal*.

Dentro do terminal **2**, crie uma nova aplicação para teste: `kubectl -n hpa-test run --generator=run-pod/v1 -it --rm load-generator --image=busybox /bin/sh`{{execute}}.

Após isso, faremos um loop de chamadas HTTP à aplicação *hpa-example*: `while true; do wget -q -O- http://hpa-example.hpa-test.svc.cluster.local; done`{{execute}}.

Agora volte ao terminal **1** e verifique a quantidade de réplicas da aplicação: `kubectl -n hpa-test get deployment -w`{{execute}}.
Quando o total de réplicas atingir o valor igual a *6*, significa que o *upscale* atingiu seu limite máximo.
Caso o total de réplicas atinja ao menos *4*, prossiga para o próximo passo.

Verifique o status do resource de HPA: `kubectl -n hpa-test get hpa`{{execute}}.

Verifique os eventos do namespace: `kubectl -n hpa-test get event`{{execute}}. Observe as linhas de autoscale. Devem ser semelhantes às linhas abaixo:
```
6m47s       Normal    SuccessfulRescale              horizontalpodautoscaler/hpa-example   New size: 4; reason: cpu resource utilization (percentage of request) above target
6m47s       Normal    ScalingReplicaSet              deployment/hpa-example                Scaled up replica set hpa-example-54bb7cdbf to 4
```

Volte ao terminal **2**, pressione *CTRL + C* e feche o mesmo. 
Agora volte ao terminal **1** e verifique a quantidade de réplicas da aplicação: `kubectl -n hpa-test get deployment -w`{{execute}}.

Quando o total de réplicas atingir o valor igual a *1*, significa que o *downscale* atingiu seu limite mínimo.
Esse processo deve demorar até 5 minutos.

Como ação final, remova o namespace criado: `kubectl delete ns hpa-test`{{execute}}.
