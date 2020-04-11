[Service](https://kubernetes.io/docs/concepts/services-networking/service/) é uma abstração para expor uma aplicação que está em execução através de um conjunto de pods como um serviço de rede.

O k8s designa um ip para cada pod e um nome de dns para um conjunto de pods.
<br/>Através do nome de dns, temos nativamente um mecanismo de service discovery.
<br/>E, por fim, temos nativamente um mecanismo de load balancing entre pods.

Services podem ser acessíveis entre namespaces, ou seja, através de configuração é possível realizar chamadas internas ao cluster, evitando sair diretamente na internet.
Por exemplo, consideremos o namespace *development* e o service *order*. O mesmo seria acessível através das opções abaixo:
  - order.development
  - order.development.svc
  - order.development.svc.cluster.local
  - order.development.svc.\<cluster FQDN\> 

## Estrutura básica de um service

```yaml
apiVersion: v1
kind: Service # 1
metadata:
  name: fleetman-webapp # 2
spec:
  selector:
    app: webapp # 3
  ports: # 4
    - name: http # 5
      protocol: TCP # 6
      port: 80 # 7
      nodePort: 30080 # 8
  type: NodePort # 9
```

1. Define o tipo do resource para o k8s, que nesse cenário é *Service*.
2. Define o nome do service que será instalado no namespace.
3. Define o seletor para identificar quais pods serão *invocadas* por esse service.
   Nesse exemplo, quando esse service receber uma requisição, o mesmo direcionará a mesma para pods que tiverem o label *app* com valor igual a *webapp*, nas portas definidas no item **4**.
4. Define as portas expostas para o service.
5. Define o nome da porta exporta para o service (ex: http, https).
6. Define o [protocolo](https://kubernetes.io/docs/concepts/services-networking/service/#protocol-support) de exposição da porta. Caso não seja informado, *TCP* será o valor padrão.
  - Protocolos disponíveis: TCP, UDP, HTTP, PROXY, SCTP.
7. Define os containers que subirão em cada pod criada para esse deployment.
8. Define a [porta](https://kubernetes.io/docs/concepts/services-networking/service/#nodeport) do node que será exposta através de um ip estático em cada node do cluster. 
9. Define o [tipo](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) do service que será exposto.
- Tipos possíveis:
  - ClusterIP: expõe o service num ip interno do cluster. Nesse tipo, o service somente é acessível internamente pelo cluster. Essa é a opção padrão.
  - [NodePort](https://kubernetes.io/docs/concepts/services-networking/service/#nodeport): expõe o service através de um ip estático em cada node do cluster. Nesse tipo, o service é acessível interna e externamente (através do ip atrinuído e porta definida em *nodePort*).
  - [LoadBalancer](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer): expõe o service externamente utilizando um load balancer de um cloud provider.
  - [ExternalName](https://kubernetes.io/docs/concepts/services-networking/service/#externalname): define um alias de dns para exposição do service.

Dicas:
  - Considerando que num ambiente produtivo haverá um load balancer para receber as requisições, a opção mais utilizada será o *ClusterIP*.
  - *LoadBalancer* geralmente é utilizado por *ingress*. Esse tipo de resource será descrito nos próximos treinamentos.
  - Caso exista um load balancer, raramente haverá a necessidade de utilizar o *NodePort* para aplicações em ambientes produtivos. Por exemplo, o componente de ingress utiliza essa abordagem para funcionamento interno. Porém, para as aplicações expostas, isso é abstraído.
  