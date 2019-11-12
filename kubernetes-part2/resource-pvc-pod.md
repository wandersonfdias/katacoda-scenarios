Nesse exemplo iremos:
- criar um servidor nfs para permitir alocar armazenamento de disco no cluster;
- criar um PV no cluster;
- criar um PVC e associá-lo à uma POD.

## Criação do servidor de NFS

A criação do NFS é para fins didáticos. Para criá-lo, execute o comando: 
`docker run -d --net=host    --privileged --name nfs-server    katacoda/contained-nfs-server:centos7    /exports/data-0001 /exports/data-0002`{{execute}}

## Criação do PV

Obtenha o ip do servidor: `ifconfig ens3 | grep "inet addr"`{{execute}}

A partir do ip obtido acima (tag: **inet addr:**), edite o arquivo do PV editando o ip do servidor (tag: **IP_SERVER**): `vi resources/pv.yaml`{{execute}}

Criar o PV através de um arquivo yaml:
`kubectl create -f resources/pv.yaml`{{execute}}

Obtenha o conteúdo do PV:
`kubectl get pv nfs-0001`{{execute}}

## Criação do PVC

Criar o PV através de um arquivo yaml:
`kubectl create -f resources/pvc.yaml`{{execute}}

Obtendo o conteúdo do PVC:
`kubectl get pvc my-pv-claim`{{execute}}

Obtenha o conteúdo do PV e observe que o status do mesmo mudou para *BOUND*:
`kubectl get pv nfs-0001`{{execute}}

## Criação de uma POD para uso do PV

Criar POD com PVC através de um arquivo yaml: 
`kubectl create -f resources/pod-pvc.yaml`{{execute}}

Monitore a criação da POD:
`kubectl get events --watch`{{execute}} ou `kubectl describe pod www`{{execute}}

Agora vamos criar um arquivo dentro do PV do nfs-server: 
`docker exec -it nfs-server bash -c "echo 'Teste do PV com NFS' > /exports/data-0001/index.html"`{{execute}}

Após criado o arquivo no PV, vamos executar a POD na porta 80 para obter o conteúdo do arquivo gerado:
`POD_IP=$(kubectl -n default describe pod www | grep IP | awk '{print $2}'); curl $POD_IP`{{execute}}

Para confirmar que o arquivo foi realmente escrito no PV e associado via PVC à POD, basta entrar na POD:
`kubectl  -n default exec -it www /bin/sh`{{execute}}

Após isso, visualize o conteúdo do arquivo definido no *volumeMount* da POD:
`cat /usr/share/nginx/html/index.html`{{execute}}

Para sair da POD, digite `exit` e pressione *enter*.