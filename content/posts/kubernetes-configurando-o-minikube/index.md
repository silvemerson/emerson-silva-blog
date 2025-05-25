---
title: "Kubernetes - Configurando O Minikube"
date: 2022-03-22T17:56:52-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["minikube","kubernetes"]
categories: ["Containers"]

lightgallery: true
---

Olá pessoal

Hoje vou demonstrar como baixar, instalar e configurar o Minikube. Nesse passo a passo vou exemplificar como fazer isso no Linux.


Primeiro, vamos entender o que é exatamente o Minikube.

## O que é?

O Minikube configura rapidamente um cluster local do Kubernetes no macOS, Linux e Windows. Ele é totalmente gratuito e fácil de instalar. Ele cria uma VM com nó único para que você possa fazer seus testes no K8s. Para mais informações sobre ele acesso aqui a [documentação](https://minikube.sigs.k8s.io/docs/).

## Instalação

Sem mais delongas, vamos configurar nosso cluster. Let’s go!!
Antes de instalar o Minikube, precisamos realizar a instalação do kubectl:


```$ curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl```


Feito isso, execute:


```$ chmod +x kubectl && mv kubectl /usr/local/bin/```


Pronto, o kubectl está instalado. Para confirmar que ele de fato está configurado, cheque a versão dele com:


```$ kubectl version```

O comando acima irá trazer a versão do kubectl instalada.
Próximo passo é instalar o Minikube. Para isso execute no seu terminal:

``` $  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \ && chmod +x minikube ```

Posteriormente:

``` $ sudo cp minikube /usr/local/bin && rm minikube```

## Inicializando Cluster

Agora vamos iniciar nosso cluster com o comando minikube start:

![Alt text for broken image link](minikube-start.png)

Feito, nosso cluster está instalado e em execução localmente. Vamos consultar os nodes criados:

![Alt text for broken image link](minikube-nodes.png)

Por default ele criou um node para quê possamos fazer nossos testes. 


## Primeiro Deploy


Que tal criarmos nosso primeiro deployment? Execute o comando abaixo em seu terminal:

``` $ kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4 ```


Nosso primeiro deployment foi criado. Vamos consultar os recursos criados:

![Alt text for broken image link](minikube-deploy.png)


Feito! Nosso cluster está em execução e com uma aplicação provisionada.

## Minikube Dashboard

Outro recurso interessante que o Minikube oferece é um painel web com a saúde e recursos do cluster. Para visualiza-lo execute:


```$ minikube dashboard```

Ele vai gerar um link do painel do cluster, acesse em seu navegador:


![Alt text for broken image link](minikube-dashboard.png)



Veja, nosso deployment está sendo exibido no painel!!


## Comandos 

Mais alguns comandos para vocês testarem:


**minikube ip**: exibe o IP do Cluster


**minikube ssh**: acessa o cluster por SSH


**minikube logs**: visualiza os logs do cluster


Por hoje é só pessoal, o Minikube é uma ótima ferramenta para testar o Kubernetes e brincar com orquestração de contêineres.

## Referências

https://kubernetes.io/pt-br/docs/tutorials/hello-minikube/

https://minikube.sigs.k8s.io/doc


<div id="giscus-comments">
  <script src="https://giscus.app/client.js"
          data-repo="silvemerson/emerson-silva-blog"
          data-repo-id="R_kgDONTalJA"
          data-category="General"
          data-category-id="DIC_kwDONTalJM4CkhmM"
          data-mapping="pathname"
          data-strict="0"
          data-reactions-enabled="1"
          data-emit-metadata="1"
          data-input-position="top"
          data-theme="dark"
          data-lang="pt"
          data-loading="lazy"
          crossorigin="anonymous"
          async>
  </script>
</div>