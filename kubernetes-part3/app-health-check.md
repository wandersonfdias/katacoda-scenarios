## Aplicação para testes

Nesse bloco, realizeremos o deploy de uma aplicação para testes de health check.

O arquivo `resources/health-check.yaml`{{open}} contém 02 aplicações para teste:
- aplicação que terá *sucesso* na execução do health check;
- aplicação que terá *falha* na execução do health check.

## Instalação da aplicação
- `kubectl apply -f resources/health-check.yaml`{{execute}}

