---
title: "Kubernetes - Criando um cluster local com Kind"
date: 2024-02-22T12:56:52-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["kind","kubernetes"]
categories: ["Containers"]

lightgallery: true
---

Olá pessoal

Hoje vou demonstrar como baixar, instalar e configurar o Kind, uma forma de construir um Cluster local do Kubernetes. 

## O que é?

O Kind é uma ferramenta para executar clusters locais do Kubernetes usando “nós” de contêiner Docker. Kind foi projetado principalmente para testar o próprio Kubernetes, mas pode ser usado para desenvolvimento local ou CI.

## Como é o Kind?


Ele consiste em:

- Pacotes Go que implementam criação de cluster, construção de imagem, etc. 
- Uma interface de linha de comando (kind) construída sobre esses pacotes. 
- Imagens Docker escritas para executar systemd, Kubernetes, etc. 
- A integração do kubetest também construída nesses pacotes (WIP) tipo bootstrap cada em “nó” com kubeadm. 

O Kind ainda é um trabalho em em construção. Para acompanhar, consulte [1.0 Roadmap](https://kind.sigs.k8s.io/docs/contributing/1.0-roadmap)

## Instalação

Para seguir o passo a passo de instalação, utilize o [manual de instação](https://kind.sigs.k8s.io/docs/user/quick-start#installation). Para o nosso ambiente, vou demonstrar usando o modo via binários no Linux.

Antes de escutar a criação do cluster, você precisa ter instalado o [Docker](https://github.com/docker/docker-install) ou o [Podman](https://podman.io/docs/installation) em sua máquina. 

Bora instalar o Kind.

**Execute**:

```bash
# para AMD64/x86_64

[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64

# Para ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

```

### Criando nosso cluster local

Antes de criar o nosso cluster, vamos criar um arquivo ```yaml``` com as informações do nosso cluster.

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: sparta
nodes:
  - role: control-plane
  - role: worker
  - role: worker

```

Execute o comando de criar o cluster usando o arquivo de configuração que criamos:

```bash

$ kind create cluster --config cluster.yaml

Creating cluster "sparta" ...
 ✓ Ensuring node image (kindest/node:v1.29.2) 🖼
 ✓ Preparing nodes 📦 📦 📦  
 ✓ Writing configuration 📜 
 ✓ Starting control-plane 🕹️ 
 ✓ Installing CNI 🔌 
 ✓ Installing StorageClass 💾 
 ✓ Joining worker nodes 🚜 
Set kubectl context to "kind-sparta"
You can now use your cluster with:

kubectl cluster-info --context kind-sparta

Have a nice day! 

```

Feito, agora visualize que o nosso cluster está em execução localmente com o ```cluster-info```

```bash
$ kubectl cluster-info --context kind-sparta

Kubernetes control plane is running at https://127.0.0.1:39911
CoreDNS is running at https://127.0.0.1:39911/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

```

### Listando nodes criados 

Agora que passamos da etapa de criação do nosso cluster local, vamos listar os nós criados e visualizar suas informações. 

**Listando nós**:

```bash
$ kubectl get nodes

NAME                   STATUS   ROLES           AGE     VERSION
sparta-control-plane   Ready    control-plane   3m51s   v1.29.2
sparta-worker          Ready    <none>          3m28s   v1.29.2
sparta-worker2         Ready    <none>          3m27s   v1.29.2
```

**Visualizando informações de um dos nodes**:

```bash

$ kubectl describe node sparta-control-plane

Name:               sparta-control-plane
Roles:              control-plane
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=sparta-control-plane
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/control-plane=
                    node.kubernetes.io/exclude-from-external-load-balancers=
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: unix:///run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Thu, 22 Feb 2024 15:53:11 -0300
Taints:             node-role.kubernetes.io/control-plane:NoSchedule
Unschedulable:      false

(...)

```

### Criando nosso primeiro deploy 

Agora que visualizamos as informações dos nodes, vamos realizar um deploy para teste.

**Criando deploy**

```bash
$ kubectl create deploy webserver --image nginx

deployment.apps/webserver created

```
**Validando aplicação:**

Crie um ```port-forward```:

```bash

$ kubectl port-forward webserver-667ddc69b6-5qnp2 8081:80

Forwarding from 127.0.0.1:8081 -> 80
Forwarding from [::1]:8081 -> 80

```
Agora, execute um curl em outro terminal no endereço ```http://127.0.0.1:8081```

```bash
$ curl http://127.0.0.1:8081 

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

Feito, viram como foi tranquilo a criação de um cluster local com o Kind e ainda realizar um deploy? Rápido, leve e prático. 

Espero que vocês tenham gostado do post prático de hoje. Nos veremos em breve. 

Se púderem, compartilhem em suas redes sociais. 

Abraço.


## Referências

https://kind.sigs.k8s.io/