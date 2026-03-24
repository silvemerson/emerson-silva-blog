---
title: "Talos Linux - Criando um cluster local com Vagrant e Libvirt"
date: 2026-03-24T00:00:00-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["kubernetes", "talos", "linux", "docker", "devops", "lab"]
categories: [" Containers"]

lightgallery: true
---

Salve salve pessoal!!!

Tudo bem com vocês? Espero que sim!

Esse é o terceiro post da série sobre Talos Linux. Se você ainda não leu os anteriores, recomendo começar pelo início:

- [Part 1 - Talos Linux: o sistema operacional feito para o Kubernetes](../talos-linux-part1)
- [Part 2 - Talos Linux com Docker - Subindo um cluster local](../talos-linux-part2)

Hoje vamos evoluir o lab! Vamos criar um cluster Talos Linux usando **Vagrant + Libvirt (KVM)**, com alta disponibilidade de verdade: **3 control planes + 2 workers**. Bora lá?

## Por que Libvirt em vez do Docker?

No post anterior com Docker, o Flannel precisava do módulo `br_netfilter` carregado no host. Com Libvirt/KVM, as VMs têm isolamento de rede real — sem essa limitação. Além disso, conseguimos simular um ambiente muito mais próximo de produção, com HA real no control plane.

## Pré-requisitos

Antes de começar, você precisa ter instalado:

- **KVM/Libvirt** — hypervisor
- **Vagrant** — gerenciador de VMs
- **vagrant-libvirt** — plugin do Vagrant para Libvirt
- **talosctl** — CLI do Talos Linux
- **kubectl** — para interagir com o cluster Kubernetes
- **vncviewer** — para visualizar o console das VMs

### Instalando as dependências

A instalação varia conforme sua distribuição. Consulte a documentação oficial do libvirt para o seu sistema:

[https://libvirt.org/downloads.html](https://libvirt.org/downloads.html)

**OpenSUSE:**
```bash
sudo zypper install libvirt libvirt-devel qemu-kvm
sudo systemctl enable --now libvirtd
```

**Ubuntu/Debian:**
```bash
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients
sudo systemctl enable --now libvirtd
```

**Fedora/RHEL/CentOS:**
```bash
sudo dnf install qemu-kvm libvirt libvirt-devel
sudo systemctl enable --now libvirtd
```
**Vagrant:**

```bash
curl -LO https://releases.hashicorp.com/vagrant/2.4.3/vagrant-2.4.3-1.x86_64.rpm
sudo rpm -ivh vagrant-2.4.3-1.x86_64.rpm
```

**Plugin vagrant-libvirt:**

```bash
vagrant plugin install vagrant-libvirt
```

**Adicionando seu usuário ao grupo libvirt:**

```bash
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
newgrp libvirt
```

## Baixando a ISO do Talos

Aqui não precisamos de uma box Vagrant, vamos montar a ISO diretamente nas VMs. O Talos vai bootar pela ISO, instalar no disco e reiniciar automaticamente.

Baixe a ISO oficial do Image Factory:

```bash
wget https://factory.talos.dev/image/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba/v1.12.6/metal-amd64.iso \
  -O /tmp/metal-amd64.iso
```

> O schematic ID `376567988ad...` é o padrão "vanilla" sem extensões — ideal para ambientes locais.

## Criando o Vagrantfile

Crie um diretório para o lab e o `Vagrantfile`:

```bash
mkdir talos-lab-libvirt
cd talos-lab-libvirt
```

```ruby
TALOS_VERSION = "v1.12.6"
ISO_PATH      = "/tmp/metal-amd64.iso"

CONTROL_PLANES = 3
WORKERS        = 2

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true

  (1..CONTROL_PLANES).each do |i|
    config.vm.define "talos-cp-#{i}" do |cp|
      cp.vm.communicator = :none
      cp.vm.provider :libvirt do |lv|
        lv.memory  = 2048
        lv.cpus    = 2
        lv.storage :file, :device => :cdrom, :path => ISO_PATH
        lv.storage :file, :size => "10G", :type => "qcow2", :bus => "virtio"
        lv.boot "hd"
        lv.boot "cdrom"
      end
    end
  end

  (1..WORKERS).each do |i|
    config.vm.define "talos-worker-#{i}" do |worker|
      worker.vm.communicator = :none
      worker.vm.provider :libvirt do |lv|
        lv.memory  = 2048
        lv.cpus    = 2
        lv.storage :file, :device => :cdrom, :path => ISO_PATH
        lv.storage :file, :size => "10G", :type => "qcow2", :bus => "virtio"
        lv.boot "hd"
        lv.boot "cdrom"
      end
    end
  end
end
```

> **Importante:** O Vagrant 2.4.x requer a variável de ambiente `VAGRANT_EXPERIMENTAL="none_communicator"` para aceitar `communicator = :none`, já que o Talos não tem SSH.

## Subindo as VMs

```bash
VAGRANT_EXPERIMENTAL="none_communicator" vagrant up --provider=libvirt
```

Aguarde as VMs subirem. Você pode acompanhar o boot via VNC:

```bash
vncviewer 127.0.0.1:5900  # talos-cp-1
```

Na tela do Talos você verá o dashboard de manutenção com o IP atribuído via DHCP.

## Descobrindo os IPs das VMs

O libvirt atribui IPs via DHCP na rede `192.168.121.0/24`. Para descobrir os IPs:

```bash
for vm in talos-cp-1 talos-cp-2 talos-cp-3 talos-worker-1 talos-worker-2; do
  echo "=== $vm ==="
  virsh -c qemu:///system domifaddr talos-vagrant_${vm}
done
```

A saída será algo como:

```
=== talos-cp-1 ===
 Nome       Endereço MAC        Protocol     Address
 vnet11     52:54:00:44:c9:5e   ipv4         192.168.121.72/24

=== talos-cp-2 ===
 Nome       Endereço MAC        Protocol     Address
 vnet10     52:54:00:7b:35:de   ipv4         192.168.121.79/24

=== talos-cp-3 ===
 Nome       Endereço MAC        Protocol     Address
 vnet12     52:54:00:d2:e8:f6   ipv4         192.168.121.181/24

=== talos-worker-1 ===
 Nome       Endereço MAC        Protocol     Address
 vnet13     52:54:00:69:38:ab   ipv4         192.168.121.233/24

=== talos-worker-2 ===
 Nome       Endereço MAC        Protocol     Address
 vnet14     52:54:00:f1:1e:1a   ipv4         192.168.121.122/24
```

> Os IPs variam a cada `vagrant up` pois são atribuídos via DHCP. Anote os IPs do seu ambiente.

## Gerando as configurações do cluster

Vamos usar um VIP (Virtual IP) para o endpoint do Kubernetes — escolha um IP livre na subnet `192.168.121.0/24`, por exemplo `192.168.121.100`.

Crie o patch com o VIP:

```bash
cat > patch.yaml <<EOF
machine:
  network:
    interfaces:
      - deviceSelector:
          physical: true
        dhcp: true
        vip:
          ip: 192.168.121.100
EOF
```

Gere as configurações:

```bash
talosctl gen config talos-lab https://192.168.121.100:6443 \
  --install-disk /dev/vda \
  --config-patch-control-plane @patch.yaml \
  --output-dir _out
```

Isso gera três arquivos em `_out/`:
- `controlplane.yaml` — configuração dos control planes
- `worker.yaml` — configuração dos workers
- `talosconfig` — configuração do cliente talosctl

## Aplicando as configurações

```bash
export TALOSCONFIG=_out/talosconfig

# Control planes
talosctl -n 192.168.121.72  apply-config --insecure --file _out/controlplane.yaml
talosctl -n 192.168.121.79  apply-config --insecure --file _out/controlplane.yaml
talosctl -n 192.168.121.181 apply-config --insecure --file _out/controlplane.yaml

# Workers
talosctl -n 192.168.121.233 apply-config --insecure --file _out/worker.yaml
talosctl -n 192.168.121.122 apply-config --insecure --file _out/worker.yaml
```

Após aplicar a configuração, o Talos vai instalar no disco `vda` e reiniciar automaticamente. Aguarde 2-3 minutos.

## Bootstrap do cluster

Configure os endpoints e faça o bootstrap — **apenas uma vez, em um único control plane**:

```bash
talosctl config endpoint 192.168.121.72 192.168.121.79 192.168.121.181
talosctl config node 192.168.121.72

talosctl -n 192.168.121.72 bootstrap
```

## Verificando o cluster

Após o bootstrap, aguarde alguns minutos e verifique os membros:

```bash
talosctl -n 192.168.121.72 get members
```

A saída esperada mostra os 5 nodes com seus papéis:

```
NODE             NAMESPACE   TYPE     ID              VERSION   HOSTNAME        MACHINE TYPE   OS
192.168.121.72   cluster     Member   talos-mvb-m9g   3         talos-mvb-m9g   controlplane   Talos (v1.12.6)
192.168.121.72   cluster     Member   talos-mvi-v2y   1         talos-mvi-v2y   controlplane   Talos (v1.12.6)
192.168.121.72   cluster     Member   talos-zho-ja0   1         talos-zho-ja0   controlplane   Talos (v1.12.6)
192.168.121.72   cluster     Member   talos-1op-gmn   1         talos-1op-gmn   worker         Talos (v1.12.6)
192.168.121.72   cluster     Member   talos-sdg-7uw   1         talos-sdg-7uw   worker         Talos (v1.12.6)
```

## Acessando o cluster com kubectl

```bash
talosctl -n 192.168.121.72 kubeconfig ./kubeconfig
export KUBECONFIG=./kubeconfig

kubectl get nodes
```

```
NAME            STATUS   ROLES           AGE   VERSION
talos-1op-gmn   Ready    <none>          82s   v1.35.2
talos-mvb-m9g   Ready    control-plane   83s   v1.35.2
talos-mvi-v2y   Ready    control-plane   77s   v1.35.2
talos-sdg-7uw   Ready    <none>          76s   v1.35.2
talos-zho-ja0   Ready    control-plane   77s   v1.35.2
```

Todos os nodes `Ready` e o Kubernetes v1.35.2 rodando! Verifique os pods do sistema:

```bash
kubectl get pods -A
```

## Destruindo o ambiente

Quando terminar o lab:

```bash
VAGRANT_EXPERIMENTAL="none_communicator" vagrant destroy -f
sudo rm -f /tmp/metal-amd64.iso
```

## O que aprendemos nesse lab

- Como subir um cluster Talos com Vagrant + Libvirt
- Como usar a ISO do Talos diretamente nas VMs sem precisar de uma box
- Como descobrir os IPs das VMs via `virsh domifaddr`
- Como configurar um VIP para alta disponibilidade do control plane
- Como fazer o bootstrap do cluster e acessar via kubectl

## Próximos passos

No próximo post da série vamos para o Proxmox, com Packer gerando o template e Terraform provisionando o cluster. 


Se quiser se aprofundar, a documentação oficial está em [docs.siderolabs.com](https://docs.siderolabs.com/talos/v1.12/platform-specific-installations/virtualized-platforms/vagrant-libvirt).

Qualquer dúvida, me chama nas redes sociais. Bora pra cima!