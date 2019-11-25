É possível configurar limites de CPU e memória para containers executados num namespace.
Essa configuração é denominada [Limit Range](https://kubernetes.io/docs/concepts/policy/limit-range/).

Características: 
- É definido através de um kind *LimitRange*;
- Somente é permitido um único objeto do tipo *LimitRange* por namespace;
- Garante que os limites definidos por namespace (mínimo e/ou máximo) não sejam excedidos pelos containers;
- Podem ser aplicados à pods, containers e pvcs (persistentVolumeClaims).
- As regras de limite são avaliadas antes que as pods sejam admitidas no node;

**Dica**: 
- Não defina apenas o valor de *CPU/Memory Limit*. Se isso ocorrer, o kubernetes associará o valor de *CPU/Memory* Limit ao valor de *CPU/Memory Request*.
- Definir valor igual a zero é permitido também.

## Definição de limites de cpu ou memória

```yaml
apiVersion: v1
kind: LimitRange                        # 1
metadata:
  name: limit-mem-cpu-per-container     # 2
spec:
  limits:                               # 3
  - type: Container                     # 4
    max:                                # 5
      cpu: "800m"                       # 6
      memory: "1Gi"                     # 7
    min:                                # 8
      cpu: "100m"                       # 9
      memory: "100Mi"                   # 10
    default:                            # 11
      cpu: "700m"                       # 12
      memory: "900Mi"                   # 13
    defaultRequest:                     # 14
      cpu: "110m"                       # 15
      memory: "120Mi"                   # 16
```

1. Define o tipo do resource para o k8s, que nesse cenário é *LimitRange*.
2. Define o nome do objeto que será aplicado ao namespace.
3. Define a lista de limites aplicadas ao namespace.
4. Tipo do objeto que terá limites aplicados. Valores possíveis: Container, Pod ou PersistentVolumeClaim.
5. Define limite máximo de recursos para cpu, memória ou storage.
6. Define limite máximo de cpu para containers do namespace.
7. Define limite máximo de memória para containers do namespace.
8. Define limite mínimo de recursos para cpu, memória ou storage.
9. Define limite mínimo de cpu para containers do namespace.
10. Define limite mínimo de memória para containers do namespace.
11. Define limite máximo padrão de recursos para cpu, memória ou storage.
12. Define limite máximo padrão de cpu para containers do namespace.
13. Define limite máximo padrão de memória para containers do namespace.
14. Define limite mínimo padrão de recursos para cpu, memória ou storage.
15. Define limite mínimo padrão de cpu para containers do namespace.
16. Define limite mínimo padrão de memória para containers do namespace.

## Testando limites para um namespace

Crie um novo namespace: `kubectl create ns limit-test`{{execute}}.

O arquivo `resources/limit-range.yaml`{{open}} contém a definição de recursos de memória para um container. Abra o mesmo e verifique os limites definidos.

Aplique a política de limite ao namespace criado: `kubectl -n limit-test apply -f resources/limit-range.yaml`{{execute}}.

Faça um describe na política de limite criada: `kubectl -n limit-test describe limit-range-container`{{execute}}.

### Exercício 1: Criando container que respeite os limites do namespace

Abra o arquivo `resources/pod-limit-range.yaml`{{open}} e execute as tarefas abaixo:
1. Edite o container 01 e defina limites mínimo e máximo de cpu/memória que respeitem os limites criados na política.
2. Adicione um novo container à pod (*container 02*), com base no container existente, e defina apenas os limites de cpu (sempre respeitando os limites da política).
3. Adicione um novo container à pod (*container 03*), com base no container existente, e defina apenas os limites de memória (sempre respeitando os limites da política).
4. Crie a pod no namespace *limit-test*.

Faça um describe na pod criada e observe os limites de cpu e memória aplicados aos containers da pod.

Caso tenha dificuldades, veja o exemplo funcional no arquivo `resources/pod-limit-range-finished.yaml`{{open}}.

A saída deve ser algo semelhante a:
```
xxx
```

### Exercício 2: Criando container que exceda os limites do namespace



Remova o namespace criado: `kubectl delete ns limit-test`{{execute}}.
