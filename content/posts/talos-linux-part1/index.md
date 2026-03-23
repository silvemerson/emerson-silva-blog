---
title: "Talos Linux: o sistema operacional feito para o Kubernetes - part1"
date: 2026-03-20T00:00:00-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["kubernetes", "talos", "linux", "devops", "segurança", "imutabilidade"]
categories: [" Containers"]

lightgallery: true
---

Salve salve pessoal!!!

Tudo bem com vocês? Espero que sim!

Hoje vamos falar de um projeto que me chamou muito a atenção: o **Talos Linux**. Se você opera Kubernetes no dia a dia, esse post vai fazer você repensar como você enxerga o sistema operacional dos seus nodes. Bora lá?

## O que é o Talos Linux?

O Talos Linux é uma distribuição Linux projetada **exclusivamente para rodar Kubernetes**. Isso mesmo — ele não é um Linux de propósito geral com Kubernetes instalado em cima. Ele é um OS construído do zero com um único objetivo: ser o melhor host possível para um cluster Kubernetes.

Desenvolvido pela [Sidero Labs](https://www.siderolabs.com/), o Talos pode ser instalado em bare metal, VMs ou clouds e tem um conjunto de características que o tornam bastante único no ecossistema:

- **Gerenciado por API**
- **Sistema de arquivos imutável**
- **Pacotes mínimos**
- **Seguro por padrão**

Mas o que isso significa na prática? Vamos destrinchar cada um desses pontos.

## A filosofia por trás do Talos

Para entender o Talos, é preciso entender a filosofia que guia seu desenvolvimento. Ela se resume em alguns pilares fundamentais.

### Distribuído

O Talos foi pensado para operar de forma distribuída desde o início. Ele é construído para um dataplane de alta disponibilidade em primeiro lugar. O cluster `etcd` é formado de maneira ad-hoc, com cada node ingressando por conta própria (com as devidas validações de segurança). Não há pontos únicos de falha — a ideia é que o nível de coordenação necessária seja o menor possível.

### Imutável

Esse é um dos pilares mais importantes do Talos. Mesmo quando instalado em disco, o Talos **sempre roda a partir de uma imagem SquashFS**. Isso significa que, mesmo que um diretório seja montado como gravável, a imagem em si nunca é modificada.

Todas as imagens são assinadas e entregues como arquivos únicos e versionados. Isso garante que você sempre consiga verificar a integridade do sistema. A partição gravável é chamada de "ephemeral" (efêmera) justamente para reforçar a ideia: nenhum dado único, não replicado e não recriável deve estar ali. Se tudo falhar, é só limpar o disco e subir novamente.

### Minimal

O Talos leva minimalismo a sério. Como praticamente todo o OS é construído do zero em Go, o resultado é impressionante:

- **Sem shell**
- **Sem SSH**
- **Sem utilitários GNU**
- **Sem busybox**
- **Sem pacotes desnecessários**

Tudo que existe no Talos está lá porque é necessário. O resultado? A imagem SquashFS tem menos de **80 MB**.

### Efêmero

Tudo que o Talos escreve em disco é ou replicado ou reconstruível. Como o control plane é altamente disponível, a perda de qualquer node não causa interrupção de serviço nem perda de dados. A vasta maioria do sistema de arquivos não aceita escrita alguma.

### Seguro por padrão

Segurança não é um add-on no Talos — é um requisito de design. Alguns pontos que vale destacar:

- **Não existem senhas** no Talos
- Toda comunicação em rede é **criptografada e autenticada por chave**
- Os certificados Talos têm **vida curta e rotação automática**
- O Kubernetes sempre é construído com sua própria estrutura PKI separada
- O projeto segue as recomendações do **Kernel Self Protection Project (KSPP)**
- Módulos dinâmicos do kernel são completamente desabilitados

### Declarativo

Toda a configuração do Talos é feita através de **um único arquivo YAML**. Sem scripts, sem passos procedurais. Tudo — tanto a configuração do próprio Talos quanto do Kubernetes que ele forma — está definido nesse arquivo declarativo. Isso é possível justamente porque o Talos tem foco total em fazer uma única coisa: rodar Kubernetes da forma mais fácil, segura e confiável possível.

## Gerenciado por API

Esse é o diferencial mais marcante do Talos e o que mais impressiona quem começa a usá-lo. O Talos é gerenciado por uma **única API gRPC declarativa**.

Imagine uma distribuição Linux que já tem o gerenciamento de configuração embutido. Sem scripts frágeis de cloud-init que envolvem scripts `bash` em YAML. O Talos oferece uma API de rede para todas as necessidades de configuração e troubleshooting.

O cliente dessa API é o `talosctl`, a ferramenta de linha de comando que substitui o SSH para qualquer interação com os nodes.

## Não é baseado em nenhuma outra distro

Esse ponto merece destaque: o Talos Linux **não é baseado em nenhuma outra distribuição**. Ele é considerado uma segunda geração de sistemas operacionais otimizados para containers — onde CoreOS, Flatcar e Rancher representam a primeira geração — mas a tecnologia não deriva de nenhum deles.

O Talos Linux é uma reescrita completa do userspace, a partir do PID 1. O Linux kernel roda normalmente, mas tudo a partir daí é código customizado, escrito em Go, rigorosamente testado e publicado como uma imagem imutável e integrada.

O kernel Linux inicializa o `machined`, não o `systemd`. Não existe `systemd` no Talos. Não há utilitários GNU, sem shell, sem SSH, sem pacotes — nada que você associaria a qualquer outra distribuição.

## Arquitetura do sistema de arquivos

O Talos usa uma estrutura de partições bem definida:

| Partição | Função |
|----------|--------|
| **EFI** | Armazena dados de boot EFI |
| **BIOS** | Usado para o segundo estágio do GRUB |
| **BOOT** | Bootloader, initramfs e dados do kernel |
| **META** | Metadados do node (node IDs, etc) |
| **STATE** | Configuração da máquina, identidade do node para discovery e KubeSpan |
| **EPHEMERAL** | Estado efêmero, montado em `/var` |

O sistema de arquivos raiz tem três camadas:

1. **SquashFS read-only** — montado como loop device em memória, fornece a base imutável
2. **tmpfs** — para necessidades de runtime (como `/etc/hosts` e `/etc/resolv.conf`, que precisam ser graváveis)
3. **overlayfs** — para arquivos que precisam persistir entre reboots (como `/etc/kubernetes`)

## Por que isso importa para quem opera Kubernetes?

Se você opera Kubernetes hoje em cima de Ubuntu, CentOS ou qualquer outra distro de propósito geral, pensa no overhead que você carrega:

- Gerenciamento de pacotes e atualizações do OS
- Configuração de SSH e gestão de chaves
- Scripts de bootstrap que podem ou não funcionar
- Surface de ataque enorme por conta dos pacotes instalados
- Configuração manual de hardening de segurança

O Talos elimina toda essa camada de complexidade. Você não gerencia mais nodes individualmente — você gerencia o cluster. Se um node tem problema, você o reconstrói. Sem attachment emocional com servidores. Sem "servidor da produção que ninguém sabe como foi configurado".

Como a própria documentação coloca: assim como em um sistema biológico, se um componente se comporta mal, é só removê-lo e deixar um substituto crescer.

## Próximos passos

Esse post é o primeiro de uma série sobre Talos Linux. Nos próximos, vou cobrir:

- Como provisionar o Talos
- Gerenciando o cluster com `talosctl`
- Configuração declarativa na prática

Se você quiser explorar por conta própria, a documentação oficial está em [docs.siderolabs.com](https://docs.siderolabs.com/talos/v1.12/overview/what-is-talos).

Qualquer dúvida, me chama nas redes sociais. Bora pra cima! 🚀