[Label](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) são um conjuto de chave/valor que server para identificar objetos no cluster kubernetes.

Características principais:
- podem denotar algum significado para objetos no cluster;
- podem ser utilizados para organizar objetos;
- podem ser utilizados para filtrar objetos nos cluster, tanto para busca quanto para atualização;
- podem ser associados a objetos no ato de criação dos mesmos no cluster ou modificados posteriormente;
- permitem mapear informações de negócio nas aplicações ou serviços instalados no cluster;
- cada objeto pode ter um conjunto de labels;
- a chave de um label deve ser única dentro de um objeto.
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
    app: myApp
    app/name: myApp
    app/group: sales
    app/version: 1.1.0
...
```

## Label Selectors

Permitem filtrar objetos no cluster. O filtro pode ser realizado via *kubectl* ou *apis* do kubernetes.

Opções para filtro:
- *obter recursos que possuam o label*
  - `kubectl -n kube-system get pod -l k8s-app`{{execute}}
  - `kubectl -n kube-system get pod -l tier,component`{{execute}}
- *obter recursos que não possuam o label*
  - `kubectl -n kube-system get pod -l "! k8s-app"`{{execute}}  
- **=** ou **==**
  - `kubectl -n kube-system get pod -l k8s-app=kube-proxy`{{execute}}  
- **!=**
  - `kubectl -n kube-system get pod -l k8s-app!=kube-proxy`{{execute}}
- **in**
  - `kubectl -n kube-system get pod -l "k8s-app in (kube-proxy)"`{{execute}}
- **notin**
  - `kubectl -n kube-system get pod -l "k8s-app notin (kube-proxy)"`{{execute}}
  - `kubectl -n kube-system get pod -l "k8s-app, k8s-app notin (kube-proxy)"`{{execute}}