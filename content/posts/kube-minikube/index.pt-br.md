---
weight: 4
title: "Kubernetes — Configurando o Minikube"
date: 2019-12-01T21:57:40+08:00
lastmod: 2020-01-01T16:45:40+08:00
draft: false
author: "Emerson Silva"
#authorLink: "https://dillonzq.com"
description: "instalação e configuração do Minikube"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["Kubernetes", "Minikube"]
categories: ["DevOps"]

lightgallery: true
---

Olá pessoal! 


Tudo bem? Espero que sim!


Hoje vou demonstrar como baixar, instalar e configurar o Minikube. Nesse passo a passo vou exemplificar como fazer isso no Linux.
Primeiro, vamos entender o que é exatamente o Minikube.

O Minikube configura rapidamente um cluster local do Kubernetes no macOS, Linux e Windows. Ele é totalmente gratuito e fácil de instalar. 
Ele cria uma VM com nó unico para que você possa fazer seus testes no K8s. Para mais informações sobre ele acesso aqui a documentação.
Sem mais delongas, vamos configurar nosso cluster. Let’s go!!

Antes de instalar o Minikube, precisamos realizar a instalação do kubectl:

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
```

Feito isso, execute:

```
chmod +x kubectl && mv kubectl /usr/local/bin/
```

Pronto, o kubectl está instalado. Para confirmar que ele de fato está configurado, cheque a versão dele com:
```
$ kubectl version
```


O comando acima irá trazer a versão do kubectl instalada.

Próximo passo é instalar o Minikube. Para isso execute no seu terminal:

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \ && chmod +x minikube
```

Posteriormente:

```
sudo cp minikube /usr/local/bin && rm minikube
```
Agora vamos iniciar nosso cluster com o comando minikube start:
