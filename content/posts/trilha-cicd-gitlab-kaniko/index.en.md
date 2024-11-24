---
title: "Trilha CI/CD - Gitlab-CI - Build de imagens de contêineres com Kaniko"
date: 2024-11-20T12:24:03-03:00
draft: false
author: "Emerson Silva"
comment: true 
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["git","gitlab","kaniko","ci","cd"]
categories: ["Trilha CI/CD"]


lightgallery: true
---

Salve salve pessoal!!!

Tudo bem com vocês? Espero que sim!  

Hoje no nosso blog se inicia uma nova sequência de post voltado a CI/CD. Vamos começar falando de como fazer build de imagens com o Kaniko no Gitlab-CI

## O que é o Kaniko

O Kaniko é um ferramenta utilizada para a criação de de imagens de contêineres em um arquivo Docker, dentro de um contêiner, cluster de K8s ou até mesmo dentro de uma pipeline, que é o objetivo do nosso artigo. Com o Kaniko, não há a necessidade da execução de um daemom do Docker, pois é possível executar os comandos de dentro de um arquivo Docker dentro do espaço do usuário.  Basicamente, ele vai gerar a imagem do contêiner baseado de um Dockerfile e enviar para o repositório de imagens definido.

Usando o Kaniko com o GitLab CI/CD
Para usar o Kaniko é necessário que exista um executor para que seja feito a criação da imagem e os executores são:

- Docker
- Docker Machine
- Kubernetes

Ao construir uma imagem com Kaniko em conjunto do GitLab CI/CD, é recomendado que se utilize a imagem na pipeline do  gcr.io/kaniko-project/executor:debug , porque ela possui um shell, e ter um shell é necessário para utilizar imagens no GitLab CI/CD. Além disso, é necessário que exista um arquivo config.json com as informações de autenticação para o servidor de Registry do contêiner desejado.

## Criando Pipeline

No nosso exemplo, vamos criar uma pipeline simples onde o nosso Registry será o DockerHub e o nosso Dockerfile vai criar uma aplicação simples do nodejs. Então crie um repositório no Dockerhub com o nome da aplicação e no GitLab e crie os arquivos abaixo.

**Dockerfile**:

```Dockerfile
FROM node:12-alpine
RUN apk add --no-cache python2 g++ make
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "src/index.js"]
EXPOSE 3000
```

Pipeline, com o nome de arquivo .gitlab-ci.yaml:

```yml
variables:
  DOCKER_HUB_IMAGE: $DOCKER_HUB_IMAGE
  DOCKER_HUB_PASSWORD: $DOCKER_HUB_PASSWORD
  DOCKER_HUB_REGISTRY: $DOCKER_HUB_REGISTRY
  DOCKER_HUB_USER: $DOCKER_HUB_USER
  DOCKER_HOST: tcp://docker:2375

stages:
  - build

kaniko:
  stage: build
  image:
    name: gcr.io/kaniko-project/executor:debug
    entrypoint: [""]
  script:
    - mkdir -p /kaniko/.docker
    - echo "{\"auths\":{\"${DOCKER_HUB_REGISTRY}\":{\"auth\":\"$(printf "%s:%s" "${DOCKER_HUB_USER}" "${DOCKER_HUB_PASSWORD}" | base64 | tr -d '\n')\"}}}" > /kaniko/.docker/config.json
    - >-
      /kaniko/executor
      --context "${CI_PROJECT_DIR}"
      --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
      --destination "${DOCKER_HUB_IMAGE}:${CI_COMMIT_TAG}"
```

Os pontos de atenção nessa nossa pipeline é as variáveis, elas são definidas no próprio GitLab, no menu de Settings -> CI/CD -> Variables

![alt text](https://blog.4linux.com.br/wp-content/uploads/2022/04/gitlab01.png)

**DOCKER_HUB_IMAGE**: Nome da imagem
**DOCKER_HUB_PASSWORD**: Senha do seu DockerHub
**DOCKER_HUB_REGISTRY**: URL do seu DockerHub, por padrão é https://index.docker.io/v1/
**DOCKER_HUB_USER**: Nome do seu usuario que faz login no DockerHub.

Observem que na Pipeline,  existe a linha que cria um diretório .docker, nesse diretório, é onde é criado também o arquivo config.json que vai receber as credenciais de acessos do DockerHub ou do Registry definido nas variáveis.

## Executando Job

A pipeline de vocês irá ser executada após o commit enviados ao repositório do GitLab, na branch definida, por padrão irá rodar na “main” e vocês terão a seguinte visão conforme imagens abaixo.

Job em execução:

![](https://blog.4linux.com.br/wp-content/uploads/2022/04/kaniko01.png)

O gitlab-runner foi criado e está preparando o executor, que trata-se de uma Docker-Machine, e usando a imagem que recomendamos no começo do post:

![](https://blog.4linux.com.br/wp-content/uploads/2022/04/kaniko02.png)

Pronto, foi feito o build da imagem que escrevemos no Dockerfile:

![](https://blog.4linux.com.br/wp-content/uploads/2022/04/kaniko03.png)

Nosso job foi executado com sucesso:

![](https://blog.4linux.com.br/wp-content/uploads/2022/04/kaniko04.png)

É isso pessoal, testem e explorem essa ótima ferramenta chamada Kaniko. Não se esqueçam de compartilhar em suas redes sociais.

Até a próxima.

## REFERÊNCIAS
https://github.com/GoogleContainerTools/kaniko

https://docs.gitlab.com/ee/ci/docker/using_kaniko.html

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