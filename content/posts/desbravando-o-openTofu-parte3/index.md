---
title: "Desbravando o OpenTofu: Parte 03 – Importando uma infraestrutura existente"
date: 2024-11-27T09:24:03-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["devops", "iac",opentofu]
categories: ["IaC"]

lightgallery: true
---


Olá pessoal, hoje no blog, vamos seguir com mais um post sobre essa ferramenta em potencial de Infra as Code chamada OpenTofu, um fork do Terraform. Hoje vamos falar 

Bora lá!

## Antes de iniciar, vocês precisam ler isso

Antes que possamos iniciar o passo a passo para provisionar uma VM na GCP usando o [OpenTofu](https://opentofu.org/), você precisa ler o post anterior que fala sobre o que é, porque ela nasceu e sobre a licença BSL. 

Então leia [Desbravando o OpenTofu: Parte 01 – Introdução e Fundamentos
](https://emerson-silva.blog.br/posts/desbravando-o-opentofu-primeira-parte1/)



## Conecte-se a AWS

###  Instalar e Configurar o AWS CLI

Baixe e instale o AWS CLI da AWS em sua máquina seguindo as instruções de instalação do [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

```bash

#Baixe
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

#Descompacte
unzip awscliv2.zip

#Instale
sudo ./aws/install

#Valide
aws --version


```

1. **Faça login na sua conta AWS**:

Crie uma chave de acesso no [IAM da AWS](https://docs.aws.amazon.com/pt_br/IAM/latest/UserGuide/id_credentials_access-keys.html)

Depois de instalar o AWS, abra o terminal e execute:

```bash
aws configure

# output do terminal:

AWS Access Key ID [****************LZWP]: 
AWS Secret Access Key [****************gVB9]:  
Default region name [us-east-1]: 
Default output format [json]: 

```
Insira seus dados de autenticação na AWS

## Conhecendo o OpenTofu Import

o comando import é usado para trazer recursos existentes na infraestrutura para dentro do código do OpenTofu, permitindo que esses recursos sejam gerenciados. É especialmente útil ao trabalhar com recursos criados fora do OpenTofu ou ao adotar o OpenTofu para gerenciar uma infraestrutura já existente. 


### Como funciona o import

**Identificação do recurso**: O OpenTofu precisa saber qual é o recurso existente que você quer importar.
Isso é feito fornecendo o identificador único do recurso (como o ARN de um recurso na AWS, o ID de uma instância EC2, etc.).

**Mapeamento com o estado**: O comando import associa o recurso existente ao estado gerenciado pelo OpenTofu.

**Especificação do recurso**: Você precisa ter a definição do recurso no código OpenTofu antes de importá-lo.


## Sintaxe do Comando

Conhecendo o comando `tofu import`:

```bash
tofu import
The import command expects two arguments.
Usage: tofu [global options] import [options] ADDR ID

  Import existing infrastructure into your OpenTofu state.

  This will find and import the specified resource into your OpenTofu
  state, allowing existing infrastructure to come under OpenTofu
  management without having to be initially created by OpenTofu.

  The ADDR specified is the address to import the resource to. Please
  see the documentation online for resource addresses. The ID is a
  resource-specific ID to identify that resource being imported. Please
  reference the documentation for the resource type you're importing to
  determine the ID syntax to use. It typically matches directly to the ID
  that the provider uses.

  This command will not modify your infrastructure, but it will make
  network requests to inspect parts of your infrastructure relevant to
  the resource being imported.

Options:

  -config=path            Path to a directory of OpenTofu configuration files
                          to use to configure the provider. Defaults to pwd.
                          If no config files are present, they must be provided
                          via the input prompts or env vars.

  -input=false            Disable interactive input prompts.

  -lock=false             Don't hold a state lock during the operation. This is
                          dangerous if others might concurrently run commands
                          against the same workspace.

  -lock-timeout=0s        Duration to retry a state lock.

  -no-color               If specified, output won't contain any color.

  -var 'foo=bar'          Set a variable in the OpenTofu configuration. This
                          flag can be set multiple times. This is only useful
                          with the "-config" flag.

  -var-file=foo           Set variables in the OpenTofu configuration from
                          a file. If "terraform.tfvars" or any ".auto.tfvars"
                          files are present, they will be automatically loaded.

  -ignore-remote-version  A rare option used for the remote backend only. See
                          the remote backend documentation for more information.

  -state, state-out, and -backup are legacy options supported for the local
  backend only. For more information, see the local backend's documentation.

```

Para importar uma infra, o comando fica da seguinte forma:

tofu import <RESOURCE_TYPE> <RESOURCE_NAME> <RESOURCE_ID>

**<RESOURCE_TYPE>**: Tipo de recurso que você quer importar (exemplo: aws_instance, aws_s3_bucket).

**<RESOURCE_NAME>**: Nome que você deu ao recurso no código OpenTofu.

**<RESOURCE_ID>**: Identificador único do recurso existente.

## Exemplo para AWS

Vamos para o nosos cenário.

Você tem uma instância EC2 criada manualmente na AWS e deseja gerenciá-la pelo OpenTofu.


Defina o recurso no código OpenTofu: No arquivo .tf escreva o código do recurso correspondente, por exemplo:

```json
resource "aws_instance" "example" {
  # os atributos exatos serão preenchidos após o import
}
```

Identifique o ID da instância EC2 (por exemplo, i-030cd2c52f9fb25d8) e execute:

```bash
tofu import aws_instance.example i-030cd2c52f9fb25d8
```

**Output**

```bash

aws_instance.example: Importing from ID "i-030cd2c52f9fb25d8"...
aws_instance.example: Import prepared!
  Prepared aws_instance for import
aws_instance.example: Refreshing state... [id=i-030cd2c52f9fb25d8]

Import successful!

The resources that were imported are shown above. These resources are now in
your OpenTofu state and will henceforth be managed by OpenTofu.

```


Após o comando, o OpenTofu vai sincronizar o estado em seu `tfstate`, mas você precisará ajustar o código do recurso com os atributos reais da instância (como AMI, tipo, etc.). Para isso, execute:

```bash
tofu show 

# aws_instance.example:
resource "aws_instance" "example" {
    ami                                  = "ami-0453ec754f44f9a4a"
    arn                                  = "arn:aws:ec2:us-east-1:061039793852:instance/i-030cd2c52f9fb25d8"
    associate_public_ip_address          = true
    availability_zone                    = "us-east-1c"
    cpu_core_count                       = 1
    cpu_threads_per_core                 = 1
(...)
```

Adicione no seu arquivo `tf`:

```json
resource "aws_instance" "example" {
  # os atributos exatos serão preenchidos após o import

    ami                                  = "ami-0453ec754f44f9a4a"
    instance_type                        = "t2.micro"
    key_name                             = "aws-keypairs"
    security_groups                      = [
        "launch-wizard-2",
    ]
    source_dest_check                    = true
    subnet_id                            = "subnet-0bb09b9cceb57d045"
    tags                                 = {
        "Name" = "example"
    }
    tags_all                             = {
        "Name" = "example"

}

}
```


Por fim, execute o `plan` para verificar o estado:

```bash

tofu plan

```
Ele mostrará estado.

Toop! Agora você pode usar o OpenTofu para atualizar, modificar ou destruir o recurso como qualquer outro gerenciado.

##  Benefícios do Import no OpenTofu

- Adaptação incremental: Adote o OpenTofu em uma infraestrutura existente sem recriar tudo.

- Gerenciamento centralizado: Passe a gerenciar recursos que antes eram manuais.

- Compatibilidade com a AWS: O suporte do OpenTofu à AWS é robusto, cobrindo diversos serviços e recursos.

## Referências

https://opentofu.org/docs/cli/import/

https://opentofu.org/

https://docs.aws.amazon.com/pt_br/IAM/latest/UserGuide/id_credentials_access-keys.html

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