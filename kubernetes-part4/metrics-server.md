[Metrics-Server](https://kubernetes.io/docs/tasks/debug-application-cluster/resource-metrics-pipeline/#metrics-server) é um componente do cluster que permite coletar métricas de consumo de cpu ou memória de containers ou nodes. Essas métricas são expostas via API através do *kubelet* em cada node do cluster.
Por padrão, o metrics-server realiza a coleta de métricas nos nodes a cada 60s. Esse período pode ser customizado.

## Instalação do metrics-server

Para instalar esse componente, utilizaremos um [template do helm](https://github.com/helm/charts/tree/master/stable/metrics-server). Vide linha abaixo:

`helm install stable/metrics-server \
--name metrics-server \
--namespace kube-system \
--set args[0]="--kubelet-preferred-address-types=InternalIP" \
--set args[1]="--kubelet-insecure-tls" \
--set args[2]="--metric-resolution=30s"`{{execute}}

A linha acima define os seguintes parâmetros de instalação:
- *stable/metrics-server*: Versão do template a ser utilizada. Vide [detalhes](https://github.com/helm/charts/tree/master/stable/metrics-server).
- *--name metrics-server*: Nome da instalação para controle do *helm*.
- *--namespace kube-system*: Namespace onde será instalada a aplicação.
- *--set args[0]="--kubelet-preferred-address-types=InternalIP"*: Define que a comunicação com o componente de kubelet de cada node será via ip. Opções: InternalIP,Hostname,InternalDNS,ExternalDNS,ExternalIP.
- *--set args[1]="--kubelet-insecure-tls*: Habilita o modo inseguro, ou seja, nenhum certificado será verificado. Esse parâmetro não pode ser utilizado em ambientes produtivos.
- *--set args[2]="--metric-resolution=30s"*: Define que o metrics server coletará métricas nos nodes a cada 30s.

Para verificar se a POD está running: `kubectl -n kube-system get pod -w | grep metric`{{execute}}

Para verificar se a instalação ocorreu com sucesso, execute: `kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"`{{execute}}

Geralmente demora uns 60s para instalação. Caso o metrics-server ainda não esteja disponível, aparecerá uma mensagem:
> `Error from server (ServiceUnavailable): the server is currently unable to handle the request`

Uma vez que o mesmo estiver disponível, um conteúdo em JSON será retornado.
> `{"kind":"NodeMetricsList","apiVersion":"metrics.k8s.io/v1beta1","metadata":{"selfLink":"/apis/metrics.k8s.io/v1beta1/nodes"},"items":[{"me
tadata":{"name":"master","selfLink":"/apis/metrics.k8s.io/v1beta1/nodes/master","creationTimestamp":"2019-11-25T13:45:25Z"},"timestamp":"2
019-11-25T13:45:05Z","window":"30s","usage":{"cpu":"150850717n","memory":"1045572Ki"}},{"metadata":{"name":"node01","selfLink":"/apis/metr
ics.k8s.io/v1beta1/nodes/node01","creationTimestamp":"2019-11-25T13:45:25Z"},"timestamp":"2019-11-25T13:45:05Z","window":"30s","usage":{"c
pu":"69096956n","memory":"885732Ki"}}]}`

Para verificar os recursos consumidos para cada node, execute: `kubectl top node`{{execute}}

Para verificar os recursos consumidos por pods, execute: `kubectl top pod --all-namespaces`{{execute}}

As informações de métricas também são disponibilizadas no [dashboard do kubernetes](https://[[HOST_SUBDOMAIN]]-30000-[[KATACODA_HOST]].environments.katacoda.com/), dentro do detalhe de cada recurso (pods etc).
