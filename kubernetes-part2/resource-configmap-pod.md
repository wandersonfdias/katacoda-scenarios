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
      command: [ "/bin/sh", "-c", "env" ]
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

Para criar a POD, execute: `kubectl create -f resources/pod-configmap-single.yaml`{{execute}}

Para visualizar os logs da POD, execute: `kubectl -n default logs -f pod-configmap-single`{{execute}}

Para entrar na POD, execute: `kubectl -n default exec -it pod-configmap-single /bin/sh`{{execute}}
Após entrar na POD, liste as variáveis de ambiente a partir do comando: `env`{{execute}}
Para sair da POD, execute: `exit`{{execute}}

