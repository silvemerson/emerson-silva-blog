---
title: "Vagrant - Primeiros passos"
date: 2022-03-22T17:57:54-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "vagrant"
  src: "vagrant.png"

tags: ["infra","vagrant"]
categories: ["Infra"]

lightgallery: true
---


Olá pessoal, 

No post de hoje, vou falar um pouco sobre o Vagrant, a ferramenta da gigante Hashicorp que nos permite a criação de ambientes de desenvolvimento de forma rápida, estruturada e 
com controle de código. 

Controle de código? Sim, isso mesmo, você irá construir seu ambiente de VM via código. O Vagrant entra com uma ferramente de IaC(Infra as code), onde fazemos a construção da nossa Infra de forma declarativa com o arquivo chamado Vagrantfile
