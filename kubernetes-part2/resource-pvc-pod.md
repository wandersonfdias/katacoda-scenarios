Nesse exemplo iremos:
- criar um servidor nfs para permitir alocar armazenamento de disco no cluster;
- criar um PV no cluster;
- criar um PVC e associá-lo à uma POD.

## Criação do servidor de NFS

A criação do NFS é para fins didáticos. Para criá-lo, execute o comando: 
`docker run -d --net=host    --privileged --name nfs-server    katacoda/contained-nfs-server:centos7    /data/data-0001 /data/data-0002`{{execute}}

## Criação do PV

Criar o PV através de um arquivo yaml:
`kubectl create -f resources/pv.yaml`{{execute}}

Descreva o conteúdo do PV:
`kubectl describe pv nfs-0001`{{execute}}

## Criação do PVC

Criar o PV através de um arquivo yaml:
`kubectl create -f resources/pvc.yaml`{{execute}}

Descreva o conteúdo do PV:
`kubectl describe pvc my-pv-claim`{{execute}}

## Criação de uma POD para uso do PV

Criar POD com PVC através de um arquivo yaml: 
`kubectl create -f resources/pod-pvc.yaml`{{execute}}

Verificar os arquivos criados dentro do PV: 
`ls -lsa /data/data-0001`{{execute}}
