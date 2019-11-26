## Desafio

Combine configurações de autoscale por cpu e memória numa única aplicação.
  - Simule e execute o auto-scale, evidenciando scale por cpu e também por memória.
  - Monte um exemplo considerando a imagem listada no [link](https://github.com/kubernetes/kubernetes/tree/master/test/images/resource-consumer).
  - Monte um arquivo declarativo contendo o service e deployment.
  - Monte outro arquivo declarativo contendo informações do HPA de cpu e memória.
  - Isole tudo num namespace diferente.
  - Dicas:
    - O worker node possui apenas 02 cores e 2GB de memória total.
    - Imagem: gcr.io/kubernetes-e2e-test-images/resource-consumer:1.4
    - Gerar consumo de cpu: `curl --data "millicores=300&durationSec=600" http://<EXTERNAL-IP>:8080/ConsumeCPU`
    - Gerar consumo de memória: `curl --data "megabytes=300&durationSec=600" http://<EXTERNAL-IP>:8080/ConsumeMem`
