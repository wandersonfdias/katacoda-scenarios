Nesse bloco, forçaremos uma falha num container, forçando uma falha na verificação de *liveness probe*.

### POD frontend
A POD *frontend* criada no passo anterior está funcionando corretamente, sem nenhum restart.

Para verificar o status, execute: `kubectl get pods --selector="app=frontend"`{{execute}}

Agora iremos forçar um *crash* na mesma, através de uma chamada interna no container: `POD=$(kubectl get pods --selector="app=frontend" --output=jsonpath={.items..metadata.name}) \ kubectl exec $POD -- /usr/bin/curl -s localhost/unhealthy`{{execute}}

Para verificar os eventos dessa aplicação, execute: `kubectl get events -w | grep "/frontend"`{{execute}}

Agora, vamos verificar o status observando os restarts da mesma: `kubectl get pods --selector="app=frontend" -w`{{execute}}

Dica: xxxx