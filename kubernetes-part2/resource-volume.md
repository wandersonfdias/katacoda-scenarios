[Volumes](https://kubernetes.io/docs/concepts/storage/volumes/) são uma abstração para a camada de armazenamento de dados. 

Características:
- Volumes podem ser persistentes ou não persistentes:
  - Persistentes: As informações gravadas serão mantidas em disco, mesmo se a POD ou cluster forem reiniciados.
  - Não persistentes: Caso a POD seja removida ou reiniciada, as informações serão perdidas.
- O Kubernetes provê uma série de tipos volumes para uso com diversos ambientes (on-premise ou cloud). Iremos destacar os mais utilizados:
  - emptyDir: volume utilizado para cenário de informações não persistentes. Após a remoção da POD, seus dados são perdidos.
  - hostPath: monta um volume (diretório ou arquivo) num path dentro do filesystem do node do cluster.
  - nfs: permite associar um volume persistente do tipo NFS ([Network File System](https://en.wikipedia.org/wiki/Network_File_System)) dentro da POD.
  - glusterfs: volume persistente do tipo [GlusterFS](https://www.gluster.org/).
  - cephfs: volume persistente do tipo [CephFS](https://ceph.io/).
  - secret: volume utilizado com secrets.  
  - Clouds
    - gcePersistentDisk: volume utilizado pela Google Cloud.
    - awsElasticBlockStore: volume utilizado pela AWS Cloud.
    - azureDiskVolume: volume utilizado pela Azure Cloud.
  - persistentVolumeClaim: monta um volume persistente dentro da POD, permitindo abstrair os detalhes do ambiente e tipo de armazenamento. 

## Persistent Volume (PV)
Área de armazenamento provisionada pelo administrador do cluster.
Basicamente aloca um determinado tamanho de disco e um path para ser utilizado pelo cluster k8s.
Vide exemplo da configuração abaixo:

```yaml
apiVersion: v1
kind: PersistentVolume # 1
metadata:
  name: nfs-0001 # 2
spec:
  capacity:
    storage: 2Gi # 3
  accessModes: # 4
    - ReadWriteOnce
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain # 5
  nfs: # 6
    server: 172.17.0.83 # 7
    path: /data/data-0001 # 8
```

1. Define o tipo do resource para o k8s, que nesse cenário é *PersistentVolume*.
2. Define o nome do PV (persistent volume) que será definido para o cluster.
3. Define o tamanho do armazenamento que será alocado para o PV. Nesse exemplo, serão 2GB.
4. Definição do tipo de acesso ao volume. Vide (detalhes)[https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes].
5. Define o tipo do comportamento quando o volume é liberado pelo cluster. Vide [detalhes](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.16/#persistentvolumeclaim-v1-core). Opções permitidas:
  - Retain: dados serão mantidos. *Opção padrão*,
  - Delete: Dados serão removidos.
6. Tipo do volume persistente.
7. Ip do servidor ou serviço de NFS (específico para esse tipo de volume).
8. Define o path onde o volume persistente será criado fisicamente na camada de armazenamento de dados.

## Persistent Volume Clain (PVC)
Área de armazenamento requisitada pelo cluster k8s para uso pelas PODs.

```yaml
kind: PersistentVolumeClaim # 1
apiVersion: v1
metadata:
  name: my-pv-claim # 2
spec:
  accessModes: # 3
    - ReadWriteMany
  resources:
    requests:
      storage: 500Mi # 4
```

1. Define o tipo do resource para o k8s, que nesse cenário é *PersistentVolumeClaim*.
2. Define o nome do PVC (persistent volume) que será definido no namespace para uso pelas PODs.
3. Definição do tipo de acesso ao volume.
4. Define o tamanho do armazenamento que será requisitado. Nesse exemplo, serão 500MB.
