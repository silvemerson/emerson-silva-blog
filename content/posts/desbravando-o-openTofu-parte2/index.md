---
title: "Desbravando o OpenTofu: Parte 02 – Provisionando uma VM na GCP"
date: 2024-11-19T12:24:03-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["devops", "iac"]
categories: ["IaC"]

lightgallery: true
---


Olá pessoal, hoje no blog, vamos realizar um deploy na GCP com uma ferramenta em potencial de Infra as Code chamada OpenTofu, um fork do Terraform. Bora lá!

## Antes de iniciar, vocês precisam ler isso

Antes que possamos iniciar o passo a passo para provisionar uma VM na GCP usando o [OpenTofu](https://opentofu.org/), você precisa ler o post anterior que fala sobre o que é, porque ela nasceu e sobre a licença BSL. 

Então leia [Desbravando o OpenTofu: Parte 01 – Introdução e Fundamentos
](https://emerson-silva.blog.br/posts/desbravando-o-opentofu-primeira-parte1/)


## Instalação do OpenTofu

Certifique-se de que o OpenTofu está instalado. Siga os passos abaixo:
```bash

curl -s https://packagecloud.io/install/repositories/opentofu/tofu/script.deb.sh?any=true -o /tmp/tofu-repository-setup.sh

sudo bash /tmp/tofu-repository-setup.sh

rm /tmp/tofu-repository-setup.sh

sudo apt-get install tofu
```

## Conecte-se a GCP

###  Instalar e Configurar o gcloud CLI

Baixe e instale o SDK do Google Cloud em sua máquina seguindo as instruções de instalação do [SDK](https://cloud.google.com/sdk/docs/install?hl=pt-br).

1. **Faça login na sua conta GCP**:

Depois de instalar o SDK, abra o terminal e execute:

```bash
gcloud auth login

```
Isso abrirá uma página de autenticação no seu navegador. Após o login, seu terminal estará autenticado com sua conta do Google Cloud.

2. **Defina o projeto padrão**:

Para evitar a necessidade de especificar o projeto em cada comando, defina o projeto padrão. Substitua PROJECT_ID pelo ID do seu projeto na GCP:

```bash
gcloud config set project PROJECT_ID
```

Pronto, agora podemos configurar nossos arquivos para provisionar a VM na GCP.

## Configure o Provedor GCP no provider.tf

```json

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0" # Ou a versão mais recente suportada pelo OpenTofu
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}


```
Nesse arquivo vamos configurar o provider da Google. 


## Defina Variáveis Básicas no variables.tf

```json
variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "instance_name" {
  default = "opentofu-vm-instance"
}

variable "machine_type" {
  default = "e2-micro"
}
```

Nesse arquivo pessoal, estamos configurando as váriaveis que serão defindas nos arquivos ```provider.tf```, ```vm.tf``` e ```fw.tf```.

## Crie o Recurso do Firewall


No ```fw.tf```, defina a instância da VM e um firewall básico para permitir o acesso SSH.

```json

resource "google_compute_network" "vpc_network" {
  name = "opentofu-network"
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

```
## Crie o Recurso da Instância

Agora galera, crie um arquivo chamado ```vm.tf```:

```json

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      # Para criar um IP público
    }
  }

  metadata = {
    ssh-keys = "usuario_gcp:${file("~/.ssh/id_rsa.pub")}"
  }
}
```

## Adicione um Arquivo de Saída

Para facilitar a visualização do IP público da instância, você pode criar um arquivo ```outputs.tf```:

```json
output "instance_ip" {
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
  description = "Endereço IP público da instância GCP"
}
```

## Construindo o ambiente

Como vocês observaram, a forma de desenvolver a infra segue usando a linguagem HCL o que mude para o deploy é o binário de execução, ao invés de ```terraform``` vamos usar ```tofu```

Então execute em seu terminal os comandos abaixo.

Para inicializar o diretório e baixar os plugins necessários:

```bash
tofu init

```
**Mensagem**:

```bash
Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/google versions matching "~> 4.0"...
- Installing hashicorp/google v4.85.0...
- Installed hashicorp/google v4.85.0 (signed, key ID 0C0AF313E5FD9F80)

Providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://opentofu.org/docs/cli/plugins/signing/

OpenTofu has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that OpenTofu can guarantee to make the same selections by default when
you run "tofu init" in the future.

OpenTofu has been successfully initialized!

You may now begin working with OpenTofu. Try running "tofu plan" to see
any changes that are required for your infrastructure. All OpenTofu commands
should now work.

If you ever set or change modules or backend configuration for OpenTofu,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

```
Observe as referências do OpenTofu. Siga com os demais comandos. 

Planejando a criação da infra:

```bash
tofu plan
```

Criando a Infraestrutura:

```bash
tofu apply
```
Pronto pessoal, feito o deploy de uma VM na GCP usando o OpenTofu!!! 

Caso queria deletar a infra execute ```tofu destroy```

Por hoje é só pessoal, em breve voltamos com mais. 
Não esqueçam de compartilhar esse post em suas redes sociais

Abraço

# Repositório do exemplo

https://github.com/silvemerson/gcp-vm-infra-opentofu-example

# Referências

https://opentofu.org/

https://opentofu.org/docs/intro/install/

https://opentofu.org/docs/intro/

https://www.linuxfoundation.org/press/announcing-opentofu

https://emerson-silva.blog.br/posts/desbravando-o-opentofu-primeira-parte1/


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