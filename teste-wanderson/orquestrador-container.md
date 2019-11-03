# Containers

Containeres revolucionaram a forma de executar aplicações, permitindo várias abstrações.
No entanto, observando uma topologia produtiva, apenas isso não é suficiente.
É necessário prever cenários mais complexos:
- Minha aplicação caiu? Como ela pode se recuperar sem intervenção manual? 
- Como permitir um monitoramento constante, observando a saúde da minha aplicação?
- Como ter um mecanismo que permita fácil realização de deploy e/ou rollback de uma versão instalada da minha aplicação?
- Como ter elasticidade da minha aplicação, sem que a minha aplicação se preocupe com isso?
- Como ter elasticidade da minha infraestrutura? Escalabilidade horizontal?
- Como controlar e/ou limitar recursos para minha aplicação ou conjunto de aplicações?

# Kubernetes

[Kubernetes](https://kubernetes.io/) ou k8s *(k + 8 caracteres + s)* é uma plataforma open-source de orquestração de containers.

Observando o gerenciamento de containers de forma produtiva, é necessário garantir alguns recursos, tais como:

- "Service discovery" e "Load Balancing"

O k8s permite expor um container através de um DNS ou ip. Existe um mecanismo de load balance que permite distribuir a carga entre os containers.

Kubernetes can expose a container using the DNS name or using their own IP address. If traffic to a container is high, Kubernetes is able to load balance and distribute the network traffic so that the deployment is stable.

- "Storage orchestration"

Kubernetes abstrai o uso de disco, permitindo uso de: disco local, discos atachados à uma nuvem e etc.

Kubernetes allows you to automatically mount a storage system of your choice, such as local storages, public cloud providers, and more.

- "Automated rollouts and rollbacks"

Pode-se automatizar a forma de instalação/atualização das aplicações, bem como rollbacks em caso de falha. Tudo isso é feito de forma declarativa.

You can describe the desired state for your deployed containers using Kubernetes, and it can change the actual state to the desired state at a controlled rate. For example, you can automate Kubernetes to create new containers for your deployment, remove existing containers and adopt all their resources to the new container.

- "Automatic bin packing"

É possível definir uso de recursos de memória e cpu para os containers. Com base nisso, o k8s consegue decidir o melhor node do cluster para rodar os containers, garantindo o melhor uso de recursos.

You provide Kubernetes with a cluster of nodes that it can use to run containerized tasks. You tell Kubernetes how much CPU and memory (RAM) each container needs. Kubernetes can fit containers onto your nodes to make the best use of your resources.

- "Self-healing": Através do conceito de observabilidade, é possível:
-- Reiniciar containers que estejam em falha;
-- "Matar" e substituir containers que não tenham resultado positivo na verificação de "health check";
-- Garantir que um container somente estará disponível para uso após a verificação de "health check".

- "Secret and configuration management"

Kubernetes lets you store and manage sensitive information, such as passwords, OAuth tokens, and ssh keys. You can deploy and update secrets and application configuration without rebuilding your container images, and without exposing secrets in your stack configuration.
    