---
title: "Docker Primeiros Passos"
date: 2022-04-12T13:33:01-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["containers","docker"]
categories: ["Containers"]

lightgallery: true
---

Olá pessoal, hoje vou apresentar uma tecnologia de software que fornece conteiners, chamada Docker. Vamos lá!

## O que é Docker

O Docker é uma plataforma aberta que separa suas aplicações para que seja possível uma entrega rápida de software. Essa tecnologia permite a executço um serviço em um ambiente isolado, esse provisionamento é chamado de container. Esse isolamento e segurança permite que seja executado muitos containers simultâneamente em um determinado host. Os containers são executados diretamente no kernel da máquina utilizada.

## Arquitetura Docker

- Docker Engine: permite que os containers sejam contruídos, enviados e executados.

- Docker Client: Recebe ás entradas do usuário, via CLI, e as envias para a Engine

- Docker Registry: Gerencia os armazenamento de imagens

- Images: Template usado para criar os containers

- Containers: Provisionamento da aplicação e de recursos. Os containers são baseados nas IMAGES.


![docker](https://media-exp1.licdn.com/dms/image/C4D12AQGu3FD9yV7IDA/article-inline_image-shrink_1000_1488/0/1564695520243?e=2147483647&v=beta&t=adhSiK5QSoMgng0BN1-_wmPiavn3JPGi2dIM9JbFOK0)


O Client cria um container, que é uma soliciação ao Docker Engine(daemon), em seguida é feita uma busca pela imagem no Docker Registry. Atráves do Registry é feito o download, que é enviado para o Engine. Este será o responsável por entregar o container.

Enfim, para mais detalhes, acesse a documentação oficial do Docker. Vamos por a mão na massa!!!

Nesse tutorial vamos usar:

VM Debian 9 Stretch

Docker versão 20.10.14

Instalação por Script
Para ambientes de testes, o Docker fornece scripts para instalação de maneira rápida e não interativa. O código fonte dos scripts está no repositório de instalação da própria ferramenta.

O uso desses scripts não são recomendados para ambientes de produção.

Sem mais delongas, vamos lá colocar nosso laboratório para funcionar.

Execute o o comando curl abaixo para que seja realizado o download do script:

```$ curl -fsSL https://get.docker.com -o get-docker.sh```

Após realizado o processo anterior, execute o script;


``` $ sudo sh get-docker.sh ```


O script irá buscar o código fonte nos repositórios do Docker e executar a instalação de tudo que é necessário para o software funcionar corretamente.

Pronto, o Docker está instalado em sua VM Debian!!!

## Baixando primeira imagem

O Docker possui um vasto repositório de images para containers.

Link do repositório Docker: https://hub.docker.com/explore/

Através do link podemos encontrar todas as imagens existentes de S.O, serviços, etc.

Por meio de comandos Docker, também podemos fazer essa pesquisa. O comando que faz essa busca é o docker search image_name. O container que vamos executar é um provisionamento de uma aplicação Nginx.

Execute o comando abaixo para pesquisar o Nginx:

```$ docker search nginx```

O Docker irá exibir o máximo possível de imagens do Nginx em seus repositórios:

Vamos utilizar o primeiro da lista, que é o build oficial do Ngnix.

Para baixar a imagem, digite o comando abaixo:


```$ docker pull nginx```

Esse comando é responsável por realizar o download da imagem diretamente do Registry Docker HUB.

Para visualizar a imagem baixada, digite o comando abaixo:

```$ docker images```

## Criando primeiro Container

Para criar o nosso primeiro container, digite:

```$ docker run -i -t -d -p 8080:8080 nginx```

- **run**: cria o container
- **-i**: permite interação com o container
- **-t**: solicita o uso do shell
-  **-d:** container roda em background
- **-p**: exposição da porta 8080 do container na porta 8080 do host(irei dar mais detalhes em um outro tutorial)

Por fim, o nome da imagem, que no nosso lab é o Nginx.

Para listar o container criado, digite o comando abaixo:

```$ docker ps```

Para que possamos acessar o bash do container, execute:

```$ docker exec -it Container_ID /bin/bash```

- exec: serve acessar o container

- Container_ID: ID gerado na criação do container. Nesse campo também podemos colocar o nome do container

- /bin/bash: O container irá iniciar com shell bash.

Pronto, estamos acessando o bash do container.

Outra demostração, é o acesso a página web padrão do Nginx, demonstrando que a exposição da porta na criação do container funcionou:

## Administração básicas dos containers

Agora que já temos um containers em execução irei compartilhar um guia de comandos básicos do Docker.

- **docker ps**: Lista os containers criados que estão em execução.
- **docker ps -a**: Lista todos os containers, desde os que estão em execução e os que estão parados.
- **docker start**: Inicia o container.
- **docker stop**: Para o container.
- **docker logs ID_container**: Mostra os logs recentes do container criado
- **docker inspect ID_container**: Exibe informações detalhadas sobre o container.
- **docker stats ID_container**: Exibe estatísticas de processamento do container.
- **docker rm ID_container**: Apaga, somente containers que estão parados
- **docker rm -f ID_container**: Apaga, de forma forçada, o container. Independente se o mesmo esteja em execução ou não.
- **docker images**: Lista todas as imagens baixadas.
- **docker rmi image_name**: Apaga imagem baixada.

## Referências

https://docs.docker.com/install/linux/docker-ce/debian/#install-using-the-convenience-script

https://docs.docker.com/engine/reference/commandline/images/

https://hub.docker.com/_/nginx/

https://docs.docker.com/engine/docker-overview/


