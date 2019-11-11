[Configmaps](https://cloud.google.com/kubernetes-engine/docs/concepts/configmap) definem configurações no estilo chave/valor para os containers.

Características:
- Permitem desacoplar configurações dos containers, evitando definições *hard-coded* dentro dos mesmos;
- Permitem, quando associados a volumes, escrever arquivos dentro dos containers;
- São úteis para armazenar e compartilhar informações não-sensíveis (informações sensíveis devem utilizar **Secrets**);
- São únicos dentro de um namespace;
- Podem ser acessados por todas PODs dentro de um namespace;

## Criando o configmap via kubectl

A linha abaixo criará um configmap de nome *teste* contendo 02 configurações:
`kubectl create configmap teste --from-literal=name=teste --from-literal=url=www.google.com`{{execute}}

Verifique se o configmap foi criado corretamente:
`kubectl get configmap teste`{{execute}}

Obtenha o conteúdo criado para o configmap no formato YAML:
`kubectl get configmap teste -o yaml`{{execute}}

Descreva o conteúdo do configmap:
`kubectl describe configmap teste`{{execute}}

Exclua o configmap:
`kubectl delete configmap teste`{{execute}}

## 


