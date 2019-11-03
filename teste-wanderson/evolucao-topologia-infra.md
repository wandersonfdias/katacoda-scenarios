A topologia de infraestrutura evoluiu ao longo dos anos.

![Topologia](/wandersondias/scenarios/teste-wanderson/assets/topologia-infra.png)

- Infra Tradicional
As aplicações eram instaladas num sistema operacional de um host físico.

- Infra Virtualizada
A infraestrutura era virtualizada através de VMs. Cada VM contém seu sistema operacional, disco, cpu, memória e etc.
As aplicações, com seus respectivos pacotes e biblioetecas, eram instaladas nos sistemas operacionais das VMs.

- Infra Containerizada
Containers também possuem seu sistema operacional, disco, cpu, memória e etc. No entanto, containers são mais leves do que as VMs.
Afinal, o container pode rodar em qualquer ambiente: host físico, VM, nuvem etc.
Além disso, containers possuem algumas características especiais:
1. Agilidade para criar, realizar build e deploy
2. Portabilidade para execução (nuvens, sistemas operacionais diversos)
3. Conceitos de Dev, Ops e integração com CI e CD
4. Consistência no processo de construção de software: Mantém o comportamento de execução em todos ambientes da esteira (desenvolvimento, testes e produção)
5. Conceitos de observabilidade: exposição de métricas, health management etc
