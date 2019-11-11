[Configmaps](https://cloud.google.com/kubernetes-engine/docs/concepts/configmap) definem configurações no estilo chave/valor para os containers.

Características:
- Permitem desacoplar configurações dos containers, evitando definições *hard-coded* dentro dos mesmos;
- Permitem, quando associados a volumes, escrever arquivos dentro dos containers;
- São úteis para armazenar e compartilhar informações não-sensíveis (informações sensíveis devem utilizar **Secrets**);
- São únicos dentro de um namespace;
- Podem ser acessados por todas PODs dentro de um namespace.

## Criando o configmap via kubectl

A linha abaixo criará um configmap de nome *teste* contendo 02 configurações:
`kubectl create configmap teste --from-literal=system=crm --from-literal=url=www.google.com`{{execute}}

Verifique se o configmap foi criado corretamente:
`kubectl get configmap teste`{{execute}}

Obtenha o conteúdo criado para o configmap no formato YAML:
`kubectl get configmap teste -o yaml`{{execute}}

Descreva o conteúdo do configmap:
`kubectl describe configmap teste`{{execute}}

Exclua o configmap:
`kubectl delete configmap teste`{{execute}}

## Entendo a estrutura do configmap de forma declarativa

```yaml
apiVersion: v1
kind: ConfigMap # 1
metadata:
  name: my-config # 2
  namespace: default # 3
data: # 4
  system: crm
  url: www.google.com
  app.properties: |-
    description="My description"
    year=2019
```

1. Define o tipo do resource para o k8s, que nesse cenário é *ConfigMap*.
2. Define o nome do configmap que será instalado no namespace.
3. Define o nome do namespace que para criação do configmap (*opcional*).
4. Define as configurações expostas pelo configmap no formato chave/valor.

## Criando o configmap de forma declarativa

Criar o configmap através de um arquivo yaml:
`kubectl create -f resources/configmap.yaml`{{execute}}

Descreva o conteúdo do configmap:
`kubectl describe configmap my-config`{{execute}}

Visualize o configmap no [dashboard do kubernetes](https://[[HOST_SUBDOMAIN]]-30000-[[KATACODA_HOST]].environments.katacoda.com/).
