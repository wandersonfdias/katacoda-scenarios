[Secrets](https://cloud.google.com/kubernetes-engine/docs/concepts/secret) são objetos seguros que permitem gravar dados sensíveis no cluster Kubernetes, tais como: senhas, tokens ou chaves.

Características:
- Reduzem o risco de exposição de dados sensíveis;
- Podem ser acessados por todas PODs dentro de um namespace;
- Podem ser referenciados como arquivos montados em volumes;
- Podem ser referenciados como variáveis de ambiente.

## Criando secret via kubectl

A linha abaixo criará uma secret de nome *db-password* com seu respectivo valor:
`kubectl -n default create secret generic db-data --from-literal=username=MeuUsuario --from-literal=password=MinhaSenha`{{execute}}

Verifique se a secret foi criada corretamente:
`kubectl -n default get secret db-data`{{execute}}

Obtenha o conteúdo criado para a secret no formato YAML:
`kubectl -n default get secret db-data -o yaml`{{execute}}

Para decodificar o valor de uma chave, execute: `echo "TWV1VXN1YXJpbw==" | base64 --decode`{{execute}}

Descreva o conteúdo da secret:
`kubectl -n default describe secret db-data`{{execute}}

Exclua a secret:
`kubectl -n default delete secret db-data`{{execute}}

## Entendo a estrutura da secret de forma declarativa

```yaml
apiVersion: v1
kind: Secret # 1
metadata:
  name: db-data # 2
type: Opaque # 3
data: # 4
  username: TWV1VXN1YXJpbw==
  password: TWluaGFTZW5oYQ==
```

1. Define o tipo do resource para o k8s, que nesse cenário é *Secret*.
2. Define o nome da secret que será instalado no namespace.
3. Define o tipo da secret. Por padrão é *Opaque*.
4. Define os pares chave/valor expostos pela secret. Observe que o valores estão codificados em *Base64*.

## Criando a secret de forma declarativa

Criar a secret através de um arquivo yaml:
`kubectl create -f resources/secret.yaml`{{execute}}

Descreva o conteúdo da secret:
`kubectl describe secret db-data`{{execute}}

Visualize a secret no [dashboard do kubernetes](https://[[HOST_SUBDOMAIN]]-30000-[[KATACODA_HOST]].environments.katacoda.com/).

**Dica**: Também é possível gerar o arquivo yaml da secret através do kubectl com a opção *--dry-run*. Isso facilita a codificação das chaves em base64. Vide comandos abaixo:

`kubectl -n default create secret generic db-data --from-literal=username=MeuUsuario --from-literal=password=MinhaSenha --dry-run -o yaml > my-secret.yaml`{{execute}}

`cat my-secret.yaml`{{execute}}
