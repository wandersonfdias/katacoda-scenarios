É possível definir uma cota máxima para consumo de recursos de cpu, memória ou disco para os namespaces.
Esse recurso é definido como [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/).

Características: 
- É definido através de um kind *ResourceQuota*;
- Somente é permitido um único objeto do tipo *ResourceQuota* por namespace, considerando regra de seletores;
- Garante que os limites definidos por namespace não sejam excedidos, considerando a soma de todos objetos criados;
- Possuem 03 tipos:
  - [Compute Resource Quota](https://kubernetes.io/docs/concepts/policy/resource-quotas/#compute-resource-quota)
    - Define cotas para cpu e memória (limit e request);
    - Aplicável aos containers;
    - Caso a cota seja definida para cpu e memória, as especificações dos containers devem ter limites de cpu e memória definidos.
  - [Storage Resource Quota](https://kubernetes.io/docs/concepts/policy/resource-quotas/#storage-resource-quota)
    - Aplicável aos pvcs (persistentVolumeClaims)
  - [Object Count Quota](https://kubernetes.io/docs/concepts/policy/resource-quotas/#object-count-quota)  
    - Define cotas referentes à quantidade de tipos de objetos no cluster;
    - Tipos de objetos:
      - persistentvolumeclaims
      - secrets, configmaps
      - services, replicationcontrollers, deployments, replicasets, statefulsets
      - jobs, cronjobs
- Permite aplicação de limites via regras de seletores (*scopeSelector*).

## Criação de cota para limite de cpu/memória de namespace

```yaml
apiVersion: v1
kind: ResourceQuota         # 1
metadata:
  name: quota-mem-cpu       # 2
spec:
  hard:                     # 3
    requests.cpu: "1"       # 4
    requests.memory: 1Gi    # 5
    limits.cpu: "2"         # 6
    limits.memory: 2Gi      # 7
```

1. Define o tipo do resource para o k8s, que nesse cenário é *ResourceQuota*.
2. Define o nome do objeto que será aplicado ao namespace.
3. Define uma cota fixa para *compute resources*.
4. Limite máximo considerando a soma de *cpu requests* de todas as pods em execução.
5. Limite máximo considerando a soma de *memory requests* de todas as pods em execução.
6. Limite máximo considerando a soma de *cpu limits* de todas as pods em execução.
7. Limite máximo considerando a soma de *memory limits* de todas as pods em execução.


## Testando cotas para um namespace

Crie um novo namespace: `kubectl create ns quota-test`{{execute}}.

O arquivo `resources/quota-resource.yaml`{{open}} contém a definição de cota para um namespace. Abra o mesmo e verifique os limites definidos.

Aplique a política de cota ao namespace criado: `kubectl -n quota-test apply -f resources/quota-resource.yaml`{{execute}}.

Faça um describe na política de cota criada: `kubectl -n quota-test describe resourcequota quota-mem-cpu`{{execute}}.
Teremos uma saída semelhante a:

```
Name:            quota-mem-cpu
Namespace:       quota-test
Resource         Used  Hard
--------         ----  ----
limits.cpu       0     1500m
limits.memory    0     1500Mi
requests.cpu     0     1
requests.memory  0     500Mi
```

### Exercício 1: Criando container para consumir parte da cota de recursos

Abra o arquivo `resources/pod-limit-range.yaml`{{open}} e execute as tarefas abaixo:
1. Altere o container 01 e defina limites mínimo e máximo de cpu/memória. Os limites devem corresponder a 60% dos valores definidos na política de cota.
2. Crie a pod no namespace *quota-test*.
3. Verifique o consumo da cota do namespace *quota-test*. Deve ter uma saída semelhante a:

```
Name:            quota-mem-cpu
Namespace:       quota-test
Resource         Used  Hard
--------         ----  ----
limits.cpu       900m  1500m
limits.memory    900Mi 1500Mi
requests.cpu     600m  1
requests.memory  300Mi 500Mi
```


### Exercício 2: Adicionando container para exceder a cota criada para o namespace

Abra o arquivo `resources/pod-limit-range.yaml`{{open}} e execute as tarefas abaixo:
1. Altere o nome da pod para *pod-limit-range-02*.
2. Crie a pod no namespace *limit-test*. A saída do erro deve ser semelhante a:
```
Error from server (Forbidden): error when creating "resources/pod-limit-range.yaml": pods "pod-limit-range-02" is forbidden: exceeded quot
a: quota-mem-cpu, requested: limits.cpu=900m,limits.memory=900Mi,requests.cpu=600m,requests.memory=300Mi, used: limits.cpu=900m,limits.mem
ory=900Mi,requests.cpu=600m,requests.memory=300Mi, limited: limits.cpu=1500m,limits.memory=1500Mi,requests.cpu=1,requests.memory=500Mi
```
3. Remova o namespace criado: `kubectl delete ns quota-test`{{execute}}.