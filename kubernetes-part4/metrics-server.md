[Metrics-Server](https://kubernetes.io/docs/tasks/debug-application-cluster/resource-metrics-pipeline/#metrics-server) é um componente do cluster que permite coletar métricas de consumo de cpu ou memória de containers ou nodes. Essas métricas são expostas via API através do *kubelet* em cada node do cluster.
Por padrão, o metrics-server realiza a coleta de métricas nos nodes a cada 60s. Esse período pode ser customizado.

## Instalação do metrics-server

Para instalar esse componente, utilizaremos um [template do helm](https://github.com/helm/charts/tree/master/stable/metrics-server). Vide linha abaixo:
`helm install stable/metrics-server --name metrics-server --namespace kube-system --set args[0]="--kubelet-preferred-address-types=InternalIP" --set args[1]="--kubelet-insecure-tls" --set args[2]="--metric-resolution=30s"`{{execute}}

A linha acima define os seguintes parâmetros de instalação:
- *stable/metrics-server*: Versão do template a ser utilizada. Vide [detalhes](https://github.com/helm/charts/tree/master/stable/metrics-server).
- *--name metrics-server*: Nome da instalação para controle do *helm*.
- *--namespace kube-system*: Namespace onde será instalada a aplicação.
- *--set args[0]="--kubelet-preferred-address-types=InternalIP"*: Define que a comunicação com o componente de kubelet de cada node será via ip. Opções: InternalIP,Hostname,InternalDNS,ExternalDNS,ExternalIP.
- *--set args[1]="--kubelet-insecure-tls*: Habilita o modo inseguro, ou seja, nenhum certificado será verificado. Esse parâmetro não pode ser utilizado em ambientes produtivos.
- *--set args[2]="--metric-resolution=30s"*: Define que o metrics server coletará métricas nos nodes a cada 30s.

Para verificar se a instalação ocorreu com sucesso, execute: ``{{execute}}
*Dica*: Geralmente demora uns 60s para instalação.
