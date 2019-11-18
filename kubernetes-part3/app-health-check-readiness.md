Nesse bloco, realizeremos o deploy de uma aplicação para testes de health check.

O arquivo `resources/health-check.yaml`{{open}} contém 02 aplicações para teste:
- aplicação que terá *sucesso* na execução do health check;
- aplicação que terá *falha* na execução do health check.

## Instalação da aplicação
- `kubectl apply -f resources/health-check.yaml`{{execute}}

## Verificação de Probe

### POD frontend
A POD *frontend* é uma aplicação HTTP que sempre retorna *sucesso* nas verificações de readiness e liveness.

Para verificar o status, execute: `kubectl get pods --selector="app=frontend" -w`{{execute}}

Para verificar os eventos dessa aplicação, execute: `kubectl get events | grep "/frontend"`{{execute}}

Agora dê um *describe* nessa pod: `POD=$(kubectl get pods --selector="app=frontend" --output=jsonpath={.items..metadata.name}); kubectl describe pod $POD`{{execute}}

### POD bad-frontend
A POD *bad-frontend* é uma aplicação HTTP que sempre retorna *falha* nas verificações de readiness e liveness.

Para verificar o status, execute: `kubectl get pods --selector="app=bad-frontend" -w`{{execute}}

Para verificar os eventos dessa aplicação, execute: `kubectl get events -w | grep "/bad-frontend"`{{execute}}

Agora dê um *describe* nessa pod: `POD=$(kubectl get pods --selector="app=bad-frontend" --output=jsonpath={.items..metadata.name}); kubectl describe pod $POD`{{execute}}
