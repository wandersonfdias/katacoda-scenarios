Nessa seção, veremos os recursos da aplicação instalada, suas specs ou configurações e logs de execução.
Além disso, entraremos dentro dos containers em execução:

## Acessar specs/configurações da aplicação
- services: 
  - Listar: `kubectl -n default get services`
  - Obter os detalhes de um service: `kubectl -n default get service fleetman-api-gateway -o yaml`
  - Abrir o service para edição: `kubectl -n default edit service fleetman-api-gateway -o yaml`
    - Para sair sem salvar, digite dentro do editor *vim*: `:q!`
- deployments:
  - Listar: `kubectl -n default get deployments`
  - Obter detalhes de um deployment: `kubectl -n default get deployment webapp -o yaml`
  - Abrir o deployment para edição: `kubectl -n default edit deployment webapp -o yaml`
    - Para sair sem salvar, digite dentro do editor *vim*: `:q!`
- pods: `kubectl -n default get pods`
  - Listar: `kubectl -n default get pods -o wide`
  - Obter detalhes de uma pod: `kubectl -n default get pod <pod> -o yaml`
  - Excluir uma pod e verificar a criação de uma nova, via mecanismo de self-healing: `kubectl -n default delete pod <pod>`
    - Após a pod ter sido removida, execute o comando para listar as pods novamente para verificar a criação da nova pod.

## Visualizar logs de execução
- Liste alguma pod: `kubectl -n default get pods`
- Visualize o log da pod desejada: `kubectl -n default logs -f <pod>`

## Acessar os containers em execução
- Liste alguma pod: `kubectl -n default get pods`
- Entre no terminal da pod: `kubectl -n default exec -it <pod> /bin/bash`
