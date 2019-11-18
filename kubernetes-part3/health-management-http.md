
## HTTP Readines Probe

```yaml
...
    spec:
      containers:
      - name: frontend
        image: katacoda/docker-http-server:health
        readinessProbe: # 1
          httpGet: # 2
            path: / # 3
            port: 80 # 4
            scheme: HTTP # 5
            httpHeaders: # 6
            - name: Content-Type # 7
              value: "application/json" # 8
          initialDelaySeconds: 10 # 9
          periodSeconds: 10 # 10
          timeoutSeconds: 5 # 11
          successThreshold: 1 # 12
          failureThreshold: 1 # 13
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 60
          periodSeconds: 60
          timeoutSeconds: 5
```

1. Define a configuração para readiness probe.
2. Define o tipo do probe a ser executado. Opções válidas: httpGet, exec ou tcpSocket.
3. Path para execução da chamada HTTP.
4. Porta para execução da chamada HTTP.
5. Schema para execução da chamada HTTP. Opções válidas: HTTP (padrão) ou HTTPS.
6. Define lista de headers para envio na requisição HTTP. Esse bloco é opcional.
7. Nome do header que será enviado na requisição HTTP.
8. Valor do header que será enviado na requisição HTTP.
9. Tempo inicial para execução da verificação de readiness probe.
  - Dica: Esse valor deve considerar todo o tempo necessário para subir a aplicação dentro do container.
10. Frequência para re-execução da verificação de readiness probe. Valor padrão: 30s.
11. Timeout em segundos para resposta do endpoint de health check configurado no item **3**.
12. Quantidade mínima de tentativas para a verificação ser considerada como *sucesso*.
  - Valor padrão: 1;
  - Valor mínimo: 1;
  - Para *liveness* o valor deve ser igual a 1.
13. Quantidade mínima de tentativas para a verificação ser considerada como *falha*. 
  - Valor padrão: 3;
  - Valor mínimo: 1.

## HTTP Liveness Probe

```yaml
...
    spec:
      containers:
      - name: frontend
        image: katacoda/docker-http-server:health
        livenessProbe: # 1
          httpGet: # 2
            path: / # 3
            port: 80 # 4
            scheme: HTTP # 5
          initialDelaySeconds: 30 # 6
          periodSeconds: 30 # 7
          timeoutSeconds: 1 # 8
          successThreshold: 1 # 9
          failureThreshold: 1 # 10
```

1. Define a configuração para liveness probe.
2. Define o tipo do probe a ser executado. Opções válidas: httpGet, exec ou tcpSocket.
3. Path para execução da chamada HTTP.
4. Porta para execução da chamada HTTP.
5. Schema para execução da chamada HTTP. Opções válidas: HTTP (padrão) ou HTTPS.
6. Tempo inicial para execução da verificação de readiness probe.
  - Dica: 
    - Esse valor deve considerar todo o tempo necessário para subir a aplicação dentro do container.
    - Considere também o tempo necessário para execução do *readiness probe*.
7. Frequência para re-execução da verificação de readiness probe. Valor padrão: 30s.
8. Timeout em segundos para resposta do endpoint de health check configurado no item **3**.
9. Quantidade mínima de tentativas para a verificação ser considerada como *sucesso*.
  - Para *liveness* o valor deve ser igual a 1.
10. Quantidade mínima de tentativas para a verificação ser considerada como *falha*. 
  - Valor padrão: 3;
  - Valor mínimo: 1.
  - Caso a quantidade de mínima de falhas seja atingida, o container será reiniciado e terá a quantidade de *restarts* incrementada em 1.
