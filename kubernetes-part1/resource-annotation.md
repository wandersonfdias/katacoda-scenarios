[Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) são um conjuto de chave/valor e são utilizados como metadados para configurações.
São similares aos labels, porém não identificam objetos dentro do cluster e não possuem o recurso de filtro (*label selector*).

Características principais:
- podem ser utilizados para gravar configurações para ferramentas ou bibliotecas;
  - ex: timeout http de um serviço;
- podem expor informações úteis para troubleshooting;
  - ex: release, version, lastCommit;
- têm 02 segmentos ou partes: prefixo (opcional) e nome, separados por barra (*/*);
  - nome: 
    - pode ter no máximo 63 caracteres alfanuméricos (*[a-z0-9A-Z]*), traços (*-*), underscores (*_*) e pontos (*.*);
  - prefixo: 
    - é opcional;
    - precisa ser um subdomínio de DNS e é separado por ponto (*.*) - ex: *app/*, *company.app/*;
    - não deve ultrapassar 253 caracteres e deve ser seguido por */*;
    - os prefixos *kubernetes.io/* and *k8s.io/* são reservados aos componentes do kubernetes.

Vide exemplo:
```yaml
...  
  metadata:
    annotations:
      app/name: myApp
      app/group: sales
      app/version: 1.1.0
...
```
