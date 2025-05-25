---
title: "YAML - Introdução rápida"
date: 2022-04-13T18:37:11-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["iac","automacao",yaml]
categories: ["IaC"]

lightgallery: true
---

Olá pessoal, hoje vamos falar sobre o YAML. Entender como ele funciona, como é a sua indentação e como esse formato de serialização de dados facilita na construção de arquivos de configuração.
## O que é

Foi lançado em 2001, inspirado em linguagens como como XML,C, Python entre tantas outras, é um formato de codificação de dados legíveis por humanos. Ela tem como objetivo é ter sintaxe legível e simples, onde ela pode ser mapeada facilmente pelos tipos de dados mais comuns na maioria das linguagens de alto nível. A sigla YAML pode significar em inglês YAML Ain’t markup language (YAML não é linguagem de marcação), uma brincadeira que os criadores fizeram para enfatizar o que o YAML é. 

O YAML possui uma sintaxe minimalista em comparação ao XML e JSON, por exemplo

##  Estrutura do YAML

Uma das suas principais caracteristicas é que possuí um formato com uma fácil legibilidade, o YAML utiliza um grupo de caracteres conhecidos como Unicode, ou seja UTF-8 ou UTF-16. A estrutura do documento é composto por indentação com espaços em branco,  se você usar TAB um erro ocorrerá, isso pode ser um pouco irritante no começo da aprendizagem. 
Os membros das listas, são encabeçados por um traço (-) e nos títulos, cada membro fica em uma linha, ou entre colchetes([]). 
Para os vetores associativos, são representados usando dois pontos ```(: )``` seguido por um espaço. Na seguinte forma  ```Chave: valor```, um por linha ou entre chaves ```{} ``` e separados por vírgula seguido de espaço ```(,)```.


## Sintaxe

Agora que já entendemos um pouco de como é a estrutura, que tal irmos para os exemplos de sintaxe?  

Emerson, como fica para criarmos uma lista? 

Bem vejamos:

```yaml

#Lista de frutas

- Maça
- Banana
- Manga
- Morango

```


E para um dicionário, usa-se  ```chave: valor```

```yaml
# Informação de usuários
- nome: Emerson Silva
  nacionalidade: brasileiro
  job: 'DevOps Enginner'
  skills:
    - Ansible
    - Linux System Administrator
    - Docker
    - AWS
    - Terraform
    - Kubenertes
    - Gitlab CI

```

Podemos também, exibir lista e dicionários de forma abreviada:

```yaml

Emerson: {name: Emerson, job: DevOps Enginner, skill: Ansible, Docker, AWS, Terraform, Kubenertes, Gitlab CI }
fruits: ['Maça', 'Banana', 'Morango', 'Manga']

```

## Como validar o YAML? 

Para quem está aprendendo sobre YAML e está se acostumando com os espaços, ou até mesmo que já usa a muito tempo que só validar algumas coisas, temos o **YAML Lint** que faz a validação do seu código YAML.


O Link para acesso está aqui: http://www.yamllint.com/ e através dele, podemos validar nossas sintaxes.


## Conclusão

Então é isso pessoal, esse o nosso querido YAML!!

A ideia de trazer uma explicação dele é bem objetiva, em breve teremos no blog posts sobre ferramentas que usam o YAML

Até a próxima pessoal. 


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