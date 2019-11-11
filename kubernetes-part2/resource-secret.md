[Secrets](https://cloud.google.com/kubernetes-engine/docs/concepts/secret) são objetos seguros que permitem gravar dados sensíveis no cluster Kubernetes, tais como: senhas, tokens ou chaves.

Características:
- Reduzem o risco de exposição de dados sensíveis para usuários não autorizados;
- Permitem, quando associados a volumes, escrever arquivos dentro dos containers;
- São úteis para armazenar e compartilhar informações não-sensíveis (informações sensíveis devem utilizar **Secrets**);
- São únicos dentro de um namespace;
- Podem ser acessados por todas PODs dentro de um namespace;

## Criando o configmap via kubectl

