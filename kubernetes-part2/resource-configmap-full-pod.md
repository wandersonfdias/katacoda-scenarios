Nesse exemplo iremos associar *todas* as propriedades de um configmap como variáveis de ambiente dentro de um container, conforme abaixo:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-configmap-full
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh", "-c", "env" ]
      envFrom: # 1
      - configMapRef: # 2
          name: my-config # 3
  restartPolicy: Never
```

1. Define que todas propriedades do configmap serão associadas como variáveis de ambiente para o container.
2. Define que um configmap será referenciado.
3. Nome do configmap que será associado ao container.

Para criar a POD, execute: `kubectl create -f resources/pod-configmap-full.yaml`{{execute}}

Monitore a criação da POD:
`kubectl get events --watch`{{execute}} ou `kubectl describe pod pod-configmap-full`{{execute}}

Para visualizar os logs da POD, execute: `kubectl -n default logs -f pod-configmap-full`{{execute}}

Visualize a POD no [dashboard do kubernetes](https://[[HOST_SUBDOMAIN]]-30000-[[KATACODA_HOST]].environments.katacoda.com/).

Agora remova a POD criada: `kubectl -n default delete pod pod-configmap-full`{{execute}}
