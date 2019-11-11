Nesse exemplo iremos criar arquivos no container a partir de propriedades de um configmap, conforme abaixo:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-volume-configmap
spec:
  containers:
    - name: volume-container
      image: chentex/random-logger
      volumeMounts: # 1
      - name: config-volume # 2
        mountPath: /etc/config # 3
  volumes: # 4
    - name: config-volume # 5
      configMap: # 6
        name: my-config # 7
        items: # 8
        - key: app.properties # 9
          path: container.properties # 10
  restartPolicy: Never
```

1. Define volumes que serão montados dentro do container.
2. Identifica o volume que será montado.
3. Path do volume que será montado dentro do container.
4. Contém as configurações dos volumes que poderão ser montados nos containers.
5. Identificação do volume que será configurado. Esse nome deve ser o mesmo definido no item **2**.
6. Define que o volume estará associado a um determinado configmap.
7. Nome do configmap referenciado.
8. Lista de itens ou chaves do configmap que serão referenciados.
9. Chave do configmap que será referenciada.
10. Nome do arquivo físico que será criado no volume montado dentro do container. Nesse exemplo será criado um arquivo */etc/config/container.properties*, conforme definido nos itens **3** e **10**.

Para criar a POD, execute: `kubectl create -f resources/pod-volume-configmap.yaml`{{execute}}

Monitore a criação da POD:
`kubectl get events --watch`{{execute}} ou `kubectl describe pod pod-volume-configmap`{{execute}}

Para entrar na POD, execute: `kubectl -n default exec -it pod-volume-configmap /bin/sh`{{execute}}

Dentro da POD, visualize o conteúdo do arquivo montado na mesma: `cat /etc/config/container.properties`{{execute}}

Agora visualize informações do arquivo criado: `ls -lsa /etc/config/container.properties`{{execute}}

Para sair da POD, digite `exit` e pressione *enter*.

Visualize a POD no [dashboard do kubernetes](https://[[HOST_SUBDOMAIN]]-30000-[[KATACODA_HOST]].environments.katacoda.com/).

Agora remova a POD criada: `kubectl -n default delete pod pod-volume-configmap`{{execute}}
