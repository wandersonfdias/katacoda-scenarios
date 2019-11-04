## Aplicação para testes

Nesse bloco, realizeremos o deploy de uma aplicação para teste.

Essa aplicação é dividida em 04 módulos:
- webapp: frontend para visualizar a posição atual dos veículos no mapa.
- gateway: fachada para acesso pelo frontend.
- queue: mensageria para notificação de eventos entre backend e frontend.
- position-tracker: microserviço responsável por ler mensagens da fila e atualizar a posição de veículos.

Essa aplicação deverá ser *deployada* no namespace *default*.

Veja os arquivos dentro do diretório *resources*.
- services.yaml: expõe as aplicações via NodePort.
- workload.yaml: contém as referências de deployment para instalação das aplicações.

## Instalação da aplicação
- `cd resources`
- `kubectl apply -f services.yaml`
- `kubectl apply -f workloads.yaml`

## Conferir se as aplicações subiram com sucesso
- services: `kubectl -n default get services`
- deployments: `kubectl -n default get deployments`
- pods: `kubectl -n default get pods`

## Acessar a aplicação no browser
Uma vez que a aplicação tiver subido corretamente, a mesma estará acessível através do link: [app](https://[[HOST_SUBDOMAIN]]-30080-[[KATACODA_HOST]].environments.katacoda.com/).
