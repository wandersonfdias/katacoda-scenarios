Nesse exemplo iremos associar propriedades de um configmap como variáveis de ambiente dentro de um container, conforme abaixo:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-configmap-single
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh", "-c", "env" ] # 6
      env: # 1
        - name: SYSTEM # 2
          valueFrom:
            configMapKeyRef: # 3
              name: my-config # 4
              key: system # 5
  restartPolicy: Never
```

1. Definição de variáveis de ambiente para o container.
2. Define uma variável de ambiente de nome *SYSTEM*.
3. Define que o valor da variável de ambiente virá de um configmap.
4. Nome do configmap que será associado ao container.
5. Chave do configmap que será associada à variável de ambiente do container.
6. Define o comando de execução do container.

Para criar a POD, execute: `kubectl create -f resources/pod-configmap-single.yaml`{{execute}}

Monitore a criação da POD:
`kubectl get events --watch`{{execute}} ou `kubectl describe pod pod-configmap-single`{{execute}}

Para visualizar os logs da POD, execute: `kubectl -n default logs -f pod-configmap-single`{{execute}}
**Importante:** Os logs exibidos referem-se à visualização das variáveis de ambiente do container, conforme definido na *linha 6* do YAML.

Visualize a POD no [dashboard do kubernetes](https://[[HOST_SUBDOMAIN]]-30000-[[KATACODA_HOST]].environments.katacoda.com/).

Agora remova a POD criada: `kubectl -n default delete pod pod-configmap-single`{{execute}}
