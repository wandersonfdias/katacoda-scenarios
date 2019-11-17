
# Containers

Containers revolucionaram a forma de executar aplicações, permitindo várias abstrações.
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

- "Service discovery" e "Load Balancing": O k8s permite expor um container através de um DNS ou ip. Existe um mecanismo que permite distribuir a carga entre os containers.

- "Storage orchestration": Kubernetes abstrai o uso de disco, permitindo uso de: disco local, discos atachados à uma nuvem ou camada distribuída de armazenamento (NFS, Ceph, Gluster etc).

- "Automated rollouts and rollbacks": Pode-se automatizar a forma de instalação/atualização das aplicações, bem como rollbacks em caso de falha. Tudo isso é feito de forma declarativa e também via camada de apis.

- "Automatic bin packing": É possível definir uso de recursos de memória e cpu para os containers. Com base nisso, o k8s consegue decidir o melhor node do cluster para rodar os containers, garantindo o melhor uso de recursos.

- "Self-healing": Através do conceito de observabilidade, é possível:
  - Reiniciar containers que estejam em falha;
  - "Matar" e substituir containers que não tenham resultado positivo no processo de verificação da saúda de aplicação (*health check*);
  - Garantir que um container somente estará disponível para uso após a verificação de *health check*.

- "Secret and configuration management": O k8s permite o gerenciamento de informações sensíveis (*secrets*) ou de configurações (*config maps*) para os containers. É possível atualizar essas informações sem necessidade de rebuild das imagens dos containers.
