---
title: "Talos Linux com Docker - Subindo um cluster local - part2"
date: 2026-03-20T00:00:00-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["kubernetes", "talos", "linux", "docker", "devops", "lab"]
categories: ["Kubernetes"]

lightgallery: true
---

Salve salve pessoal!!!

Tudo bem com vocês? Espero que sim!

Esse é o segundo post da série sobre Talos Linux. Se você ainda não leu o primeiro, recomendo dar uma olhada no post [Talos Linux: o OS minimalista e sem SSH para o Kubernetes](../talos-linux-o-que-e) antes de continuar — lá explico a filosofia e os conceitos por trás do projeto.

Hoje vamos colocar a mão na massa! O objetivo é subir um cluster Talos Linux localmente usando Docker, do zero até o cluster funcionando. Bora lá?

## O que vamos construir

Um cluster Kubernetes com Talos Linux rodando em containers Docker, com a seguinte topologia:

- **1 control plane node**
- **2 worker nodes**

> O Docker provider do Talos suporta apenas 1 control plane. Para clusters HA com múltiplos control planes, veremos nos próximos posts com VirtualBox e Proxmox.

Tudo gerenciado via `talosctl`, sem SSH, sem shell — exatamente como o Talos foi projetado para funcionar.

## Pré-requisitos

Antes de começar, você precisa ter instalado na sua máquina:

- **Docker** — rodando e acessível
- **kubectl** — para interagir com o cluster Kubernetes
- **talosctl** — a CLI do Talos Linux

### Carregando o módulo br_netfilter

O Flannel (CNI padrão do Talos) depende do módulo `br_netfilter` do kernel do host. Sem ele, os pods do Flannel ficam em `CrashLoopBackOff` e o cluster não funciona corretamente.

Antes de criar o cluster, carregue o módulo no host:

```bash
sudo modprobe br_netfilter
```

> **Nota:** Esse comando precisa ser executado toda vez que o host reiniciar. Para tornar permanente, adicione `br_netfilter` ao arquivo `/etc/modules-load.d/br_netfilter.conf`.

### Instalando o talosctl

**Via script (Linux/macOS/WSL):**

```bash
curl -sL https://talos.dev/install | sh
```

**Via Homebrew (macOS/Linux):**

```bash
brew install siderolabs/tap/talosctl
```

**Download manual:**

Acesse a [página de releases do Talos no GitHub](https://github.com/siderolabs/talos/releases/) e baixe o binário para sua arquitetura. Após o download, adicione ao seu `$PATH`:

```bash
chmod +x talosctl
sudo mv talosctl /usr/local/bin/
```

Verifique a instalação:

```bash
talosctl version --client
```

> **Dica importante:** A versão do `talosctl` deve ser compatível com a versão do Talos Linux que você vai rodar no cluster. Sempre use versões correspondentes.

### Instalando o kubectl

Se ainda não tiver o kubectl instalado:

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

## Subindo o cluster

Com o `talosctl` instalado, subir o cluster com Docker é surpreendentemente simples. Execute o comando abaixo:

```bash
talosctl cluster create docker \
  --workers 2 \
  --name talos-lab
```

O `talosctl` vai:

1. Baixar a imagem do Talos Linux para Docker
2. Criar os containers dos nodes (3 control planes + 2 workers)
3. Gerar as configurações de máquina automaticamente
4. Fazer o bootstrap do cluster etcd
5. Inicializar os componentes do Kubernetes

Aguarde alguns minutos enquanto o cluster sobe. Você pode acompanhar o progresso diretamente no terminal.

## Verificando o cluster

### Verificando os nodes com talosctl

Aqui começa a parte interessante. Diferente de qualquer outra distro Linux, você não usa SSH para verificar o estado dos nodes — você usa a API do Talos via `talosctl`.

Liste os membros do cluster:

```bash
talosctl get members --nodes 10.5.0.2
```

A saída esperada mostra os três nodes com seus IPs e papéis:

```
NODE       NAMESPACE   TYPE     ID                         VERSION   HOSTNAME                   MACHINE TYPE   OS                ADDRESSES
10.5.0.2   cluster     Member   talos-lab-controlplane-1   1         talos-lab-controlplane-1   controlplane   Talos (v1.12.6)   ["10.5.0.2"]
10.5.0.2   cluster     Member   talos-lab-worker-1         1         talos-lab-worker-1         worker         Talos (v1.12.6)   ["10.5.0.3"]
10.5.0.2   cluster     Member   talos-lab-worker-2         1         talos-lab-worker-2         worker         Talos (v1.12.6)   ["10.5.0.4"]
```

Verifique os serviços rodando em um node:

```bash
talosctl services --nodes 10.5.0.2
```

Acesse o dashboard interativo do Talos (um dos recursos mais legais do projeto):

```bash
talosctl dashboard --nodes 10.5.0.2
```

O dashboard mostra em tempo real: CPU, memória, disco, serviços ativos e logs do sistema — tudo sem precisar de SSH.

### Verificando os nodes com kubectl

Obtenha o kubeconfig do cluster:

```bash
talosctl kubeconfig --nodes 10.5.0.2
```

Agora verifique os nodes Kubernetes:

```bash
kubectl get nodes
```

A saída esperada é algo como:

```
NAME                       STATUS   ROLES           AGE   VERSION
talos-lab-controlplane-1   Ready    control-plane   5m    v1.32.0
talos-lab-worker-1         Ready    <none>          4m    v1.32.0
talos-lab-worker-2         Ready    <none>          4m    v1.32.0
```

Verifique os pods do sistema:

```bash
kubectl get pods -A
```

## Explorando o Talos na prática

### Tentando acessar via SSH

Uma das demonstrações mais impactantes do Talos é mostrar o que **não** existe. Tente acessar um node via SSH:

```bash
ssh root@10.5.0.2
```

Resultado esperado: **conexão recusada**. Não existe daemon SSH no Talos. Essa é a proposta — toda interação acontece via API.

### Verificando os logs do sistema

```bash
talosctl logs --nodes 10.5.0.2 machined
```

### Inspecionando a configuração do node

```bash
talosctl get machineconfig --nodes 10.5.0.2
```

### Verificando as partições do disco

```bash
talosctl get disks --nodes 10.5.0.2
```

Repare nas partições que o Talos cria: EFI, BIOS, BOOT, META, STATE e EPHEMERAL — exatamente a arquitetura que discutimos no post anterior.

## Subindo um workload de exemplo

Com o cluster funcionando, vamos subir um Nginx para validar que tudo está ok:

```bash
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=ClusterIP
kubectl get pods
```

Verifique se o pod subiu com sucesso:

```bash
kubectl get pods -l app=nginx
```

## Destruindo o cluster

Quando terminar o lab, remova tudo com:

```bash
talosctl cluster destroy --name talos-lab
```

Esse comando remove todos os containers e limpa as configurações geradas.

## O que aprendemos nesse lab

- Como instalar o `talosctl`
- Como subir um cluster Talos com Docker em um único comando
- Como interagir com o cluster via API, sem SSH e sem shell
- Como usar o `talosctl dashboard` para monitorar os nodes
- Como obter o kubeconfig e usar o `kubectl` normalmente

## Próximos passos

Nos próximos posts da série vamos evoluir o ambiente:

- **EmersonLabs: Talos Linux com VirtualBox** — subindo o cluster em VMs locais, mais próximo de um ambiente real
- **EmersonLabs: Talos Linux com Proxmox** — ambiente de homelab completo com HA real

Se quiser se aprofundar, a documentação oficial está em [docs.siderolabs.com](https://docs.siderolabs.com/talos/v1.12/overview/what-is-talos).

Qualquer dúvida, me chama nas redes sociais. Bora pra cima! 🚀