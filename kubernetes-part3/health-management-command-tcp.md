## Command Probe

```yaml
...
    spec:
      containers:
      - name: liveness
        image: k8s.gcr.io/busybox
        args:
        - /bin/sh
        - -c
        - touch /tmp/healthy; sleep 30; rm -rf /tmp/healthy; sleep 600
        livenessProbe:
          exec: # 1
            command: # 2
            - cat
            - /tmp/healthy
          initialDelaySeconds: 5
          periodSeconds: 5
```

1. Define que será executado um probe de execução de comando no sistema operacional do container.
2. Contém a lista de comandos que serão executados na verificação do probe. No exemplo acima, será executado o commando *cat /tmp/healthy*.

## TCP Probe

```yaml
...
    spec:
      containers:
      - name: goproxy
        image: k8s.gcr.io/goproxy:0.1
        ports:
        - containerPort: 8080
        readinessProbe:
          tcpSocket: # 1
            port: 8080 # 2
          initialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          tcpSocket:
            port: 8080
          initialDelaySeconds: 15
          periodSeconds: 20
```

1. Define que será executado um probe de TCP.
2. Porta para a verificação de conectividade.
