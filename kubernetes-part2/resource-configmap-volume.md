Nesse exemplo iremos criar arquivos no container a partir de propriedades de um configmap, conforme abaixo:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-volume-configmap
spec:
  containers:
    - name: volume-container
      image: k8s.gcr.io/busybox
      command: [ "/bin/sh","-c","cat /etc/config/container.properties" ]
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

1. xxxxxx
2. xxxxxx
3. xxxxxx
4. xxxxxx
5. xxxxxx
6. xxxxxx
7. xxxxxx
8. xxxxxx
9. xxxxxx
10. xxxxxx

Para criar a POD, execute: `kubectl create -f resources/pod-volume-configmap.yaml`{{execute}}

Monitore a criação da POD:
`kubectl get events --watch`{{execute}} ou `kubectl describe pod pod-volume-configmap`{{execute}}

Para visualizar os logs da POD, execute: `kubectl -n default logs -f pod-volume-configmap`{{execute}}

Visualize a POD no [dashboard do kubernetes](https://[[HOST_SUBDOMAIN]]-30000-[[KATACODA_HOST]].environments.katacoda.com/).

Agora remova a POD criada: `kubectl -n default delete pod pod-volume-configmap`{{execute}}
