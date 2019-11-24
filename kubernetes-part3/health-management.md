O Kubernetes possui um mecanismo de health check ou [probe](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-probes), o qual é responsável por verificar a saúde dos containers.

O componente de *kubelet* executa um diagnóstico periódico em containers que possuam as configurações de *probe*.

Existem 03 configurações de probe:
- Startup Probe: indica quando a aplicação dentro de um container está iniciada. 
  - As opções de *readiness* e *liveness* somente são habilitadas após o startup ter ocorrido com sucesso.
  - Caso essa opção falhe, o componente *kubelet* mata o container e o mesmo entra na política de [restart](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy).
- Readiness Probe: indica quando a aplicação está apta a receber requisições.
  - É opcional.
  - Caso a execução falhe, o *service* não encaminha requisições para a POD que não esteja apta.
- Liveness Probe: verifica se a aplicação está rodando corretamente.
  - É opcional.
  - Caso essa opção falhe, o componente *kubelet* mata o container e o mesmo entra na política de [restart](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy).

Para executar uma configuração de probe, o kubelet possui 03 opções:
- [Command ou Exec Action](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-liveness-command): executa um commando dentro do container e considera sucesso se o comando for terminado com status igual a zero.
- [TCP Socket Action](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-tcp-liveness-probe): executa uma verificação na porta definida no container e considera sucesso se a porta estiver aberta para conexão.
- [HTTP Get Action](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-liveness-http-request): executa um request HTTP no container e considera sucesso responses com status http entre 200 e 399.
