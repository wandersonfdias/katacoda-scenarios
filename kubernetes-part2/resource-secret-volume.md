Nesse exemplo iremos criar arquivos no container a partir de propriedades de secret, conforme abaixo:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-volume-secret
spec:
  containers:
    - name: volume-container
      image: chentex/random-logger
      volumeMounts: # 1
      - name: secret-volume # 2
        mountPath: /etc/config/key.json # 3
        subPath: key.json # 4
  volumes: # 5
    - name: secret-volume # 6
      secret: # 7
        secretName: db-data # 8
        items: # 9
        - key: username # 10
          path: key.json # 11
  restartPolicy: Never
```

1. Define volumes que serão montados dentro do container.
2. Identifica o volume que será montado.
3. Path do volume que será montado dentro do container.
4. Sub-path dentro do volume que será montado no container. Útil para montar múltiplos paths para um único volume dentro do container.
5. Contém as configurações dos volumes que poderão ser montados nos containers.
6. Identificação do volume que será configurado. Esse nome deve ser o mesmo definido no item **2**.
7. Define que o volume estará associado a uma determinada secret.
8. Nome da secret referenciada.
9. Lista de itens ou chaves da secret que serão referenciados.
10. Chave da secret que será referenciada.
11. Nome do arquivo físico que será criado no volume montado dentro do container. Nesse exemplo será criado um arquivo */etc/config/container.properties*, conforme definido nos itens **3, 4 e 11**.

Para criar a POD, execute: `kubectl create -f resources/pod-volume-secret.yaml`{{execute}}

Monitore a criação da POD:
`kubectl get events --watch`{{execute}} ou `kubectl describe pod pod-volume-secret`{{execute}}

Para entrar na POD, execute: `kubectl -n default exec -it pod-volume-secret /bin/sh`{{execute}}

Dentro da POD, visualize o conteúdo do arquivo montado na mesma: `cat /etc/config/key.json`{{execute}}

Agora visualize informações do arquivo criado: `ls -lsa /etc/config/key.json`{{execute}}

Para sair da POD, digite `exit` e pressione *enter*.

Visualize a POD no [dashboard do kubernetes](https://[[HOST_SUBDOMAIN]]-30000-[[KATACODA_HOST]].environments.katacoda.com/).

Agora remova a POD criada: `kubectl -n default delete pod pod-volume-secret`{{execute}}
