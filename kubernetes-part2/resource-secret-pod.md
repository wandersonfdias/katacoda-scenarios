Nesse exemplo iremos associar secrets aos containers, conforme abaixo:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-secret-configmap
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh", "-c", "env" ]
      env: # 1
        - name: DB_USERNAME # 2
          valueFrom:
            secretKeyRef: # 3
              name: db-data # 4
              key: username # 5
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-data
              key: password
  restartPolicy: Never
```

1. Definição de variáveis de ambiente para o container.
2. Define o nome da variável de ambiente.
3. Define que a variável de ambiente estará associada a uma secret.
4. Nome da secret que será associada ao container.
5. Chave da secret que será associada à variável de ambiente do container.

Para criar a POD, execute: `kubectl create -f resources/pod-secret-configmap.yaml`{{execute}}

Monitore a criação da POD:
`kubectl get events --watch`{{execute}} ou `kubectl describe pod pod-secret-configmap`{{execute}}

Para visualizar os logs da POD, execute: `kubectl -n default logs -f pod-secret-configmap`{{execute}}

Visualize a POD no [dashboard do kubernetes](https://[[HOST_SUBDOMAIN]]-30000-[[KATACODA_HOST]].environments.katacoda.com/).

Agora remova a POD criada: `kubectl -n default delete pod pod-secret-configmap`{{execute}}
