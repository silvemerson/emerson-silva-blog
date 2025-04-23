---
title: "005 - Glossário Tech - Post Mortem no SRE"
date: 2024-11-27T13:30:26-03:00
draft: true
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["sre", "post mortem"]
categories: ["glossario-tech"]

lightgallery: true
---

Salve salve pessoal!!!

Tudo bem com vocês? Espero que sim!  
E bora pra mais um post do **Glossario Tech** onde irei trazer algumas tecnologias e falar delas de forma teórica. Bora lá?


No universo do Site Reliability Engineering (SRE), um post mortem é um processo estruturado para analisar incidentes ou interrupções nos sistemas com o objetivo de aprender com os erros, identificar melhorias e evitar que problemas semelhantes aconteçam no futuro. Essa prática é essencial para organizações que buscam operar sistemas confiáveis em escala.


## O Propósito de um Post Mortem

O principal objetivo de um post mortem é documentar e analisar o que deu errado, como foi resolvido e o que pode ser feito para melhorar. A ideia não é procurar culpados, mas criar uma cultura de aprendizado contínuo, em que erros são vistos como oportunidades de evolução.

Por que fazer um post mortem?
Melhorar a confiabilidade do sistema.
Documentar lições aprendidas para referência futura.
Identificar problemas recorrentes e suas causas.
Estabelecer um ciclo de feedback que promove inovação e resiliência.
Construir confiança entre equipes e com stakeholders, mostrando transparência e compromisso com a qualidade.


## Estrutura de um Post Mortem
Embora o formato possa variar entre empresas, um post mortem geralmente segue uma estrutura como esta:

Resumo do Incidente

Breve descrição do problema, incluindo:
O que aconteceu.
Quanto tempo durou.
Qual foi o impacto (usuários, sistemas, receita, etc.).
Linha do Tempo

Uma narrativa detalhada dos eventos em ordem cronológica:
Quando o problema foi detectado.
Quais ações foram tomadas para mitigar e resolver o problema.
Como as decisões foram tomadas ao longo do processo.
Causa Raiz

Análise detalhada para identificar:
O gatilho específico do incidente.
Condições subjacentes que permitiram que o problema ocorresse.
Problemas sistêmicos ou operacionais que possam ter contribuído.
Impacto no Negócio

Avaliação clara dos danos causados, como:
Interrupção de serviços.
Perda de receita.
Insatisfação do cliente.
Reputação afetada.
Resolução

Explicação das ações realizadas para resolver o problema:
Correções temporárias (workarounds).
Soluções definitivas implementadas.
Lições Aprendidas

Pontos principais que a equipe descobriu, como:
Processos que funcionaram bem.
Áreas que precisam de melhoria.
Ferramentas ou automações necessárias.
Ações Corretivas

Um plano de melhorias baseado no aprendizado do incidente:
Tarefas específicas para prevenir problemas futuros.
Responsáveis e prazos claramente definidos.
Acompanhamento para garantir a implementação.

## Exemplo Prático de Linha do Tempo
Imagine um incidente em um sistema de e-commerce:

12:00 PM - Alerta disparado indicando lentidão no checkout.
12:05 PM - Engenheiros confirmam alta latência no banco de dados.
12:15 PM - Identificado que o aumento de tráfego ultrapassou os limites configurados.
12:30 PM - Mitigação: escalar recursos manualmente.
01:00 PM - Serviço estabilizado.
02:00 PM - Iniciada a análise do incidente.

## Cultura de Post Mortems Sem Culpa
No SRE, uma prática comum é conduzir post mortems sem culpa (blameless post mortems). Isso significa que o foco está em processos e sistemas, e não em indivíduos. O raciocínio é que sistemas complexos inevitavelmente falharão, e a única maneira de melhorar é criar um ambiente onde todos se sintam seguros para reportar e discutir problemas abertamente.

## 
O Que é um Post Mortem no SRE e Sua Importância
No universo do Site Reliability Engineering (SRE), um post mortem é um processo estruturado para analisar incidentes ou interrupções nos sistemas com o objetivo de aprender com os erros, identificar melhorias e evitar que problemas semelhantes aconteçam no futuro. Essa prática é essencial para organizações que buscam operar sistemas confiáveis em escala.

O Propósito de um Post Mortem
O principal objetivo de um post mortem é documentar e analisar o que deu errado, como foi resolvido e o que pode ser feito para melhorar. A ideia não é procurar culpados, mas criar uma cultura de aprendizado contínuo, em que erros são vistos como oportunidades de evolução.

Por que fazer um post mortem?
Melhorar a confiabilidade do sistema.
Documentar lições aprendidas para referência futura.
Identificar problemas recorrentes e suas causas.
Estabelecer um ciclo de feedback que promove inovação e resiliência.
Construir confiança entre equipes e com stakeholders, mostrando transparência e compromisso com a qualidade.
Estrutura de um Post Mortem
Embora o formato possa variar entre empresas, um post mortem geralmente segue uma estrutura como esta:

Resumo do Incidente

Breve descrição do problema, incluindo:
O que aconteceu.
Quanto tempo durou.
Qual foi o impacto (usuários, sistemas, receita, etc.).
Linha do Tempo

Uma narrativa detalhada dos eventos em ordem cronológica:
Quando o problema foi detectado.
Quais ações foram tomadas para mitigar e resolver o problema.
Como as decisões foram tomadas ao longo do processo.
Causa Raiz

Análise detalhada para identificar:
O gatilho específico do incidente.
Condições subjacentes que permitiram que o problema ocorresse.
Problemas sistêmicos ou operacionais que possam ter contribuído.
Impacto no Negócio

Avaliação clara dos danos causados, como:
Interrupção de serviços.
Perda de receita.
Insatisfação do cliente.
Reputação afetada.
Resolução

Explicação das ações realizadas para resolver o problema:
Correções temporárias (workarounds).
Soluções definitivas implementadas.
Lições Aprendidas

Pontos principais que a equipe descobriu, como:
Processos que funcionaram bem.
Áreas que precisam de melhoria.
Ferramentas ou automações necessárias.
Ações Corretivas

Um plano de melhorias baseado no aprendizado do incidente:
Tarefas específicas para prevenir problemas futuros.
Responsáveis e prazos claramente definidos.
Acompanhamento para garantir a implementação.
Exemplo Prático de Linha do Tempo
Imagine um incidente em um sistema de e-commerce:

12:00 PM - Alerta disparado indicando lentidão no checkout.
12:05 PM - Engenheiros confirmam alta latência no banco de dados.
12:15 PM - Identificado que o aumento de tráfego ultrapassou os limites configurados.
12:30 PM - Mitigação: escalar recursos manualmente.
01:00 PM - Serviço estabilizado.
02:00 PM - Iniciada a análise do incidente.
Cultura de Post Mortems Sem Culpa
No SRE, uma prática comum é conduzir post mortems sem culpa (blameless post mortems). Isso significa que o foco está em processos e sistemas, e não em indivíduos. O raciocínio é que sistemas complexos inevitavelmente falharão, e a única maneira de melhorar é criar um ambiente onde todos se sintam seguros para reportar e discutir problemas abertamente.

## Benefícios de um Post Mortem Bem Executado
Prevenção de Incidentes Futuros: Implementar correções e melhorias que evitam a recorrência do problema.
Transparência Organizacional: Demonstrar compromisso com a melhoria contínua.
Fortalecimento da Equipe: Criar confiança e promover colaboração.
Melhoria da Resiliência: Tornar sistemas mais robustos e preparados para eventos inesperados.


## Refrências:

https://aws.amazon.com/pt/what-is/sre/

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