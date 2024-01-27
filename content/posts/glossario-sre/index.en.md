---
title: "002 - Glossário Tech - o que é SRE"
date: 2024-01-27T01:30:26-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["sre"]
categories: ["glossario-tech"]

lightgallery: true
---

Salve salve pessoal!!!

Tudo bem com vocês? Espero que sim!  
E bora pra mais um post do **Glossario Tech** onde irei trazer algumas tecnologias e falar delas de forma teórica. Bora lá?


## O que é SRE


SRE significa "Site Reliability Engineering" (Engenharia de Confiabilidade de Sistemas, em português). É uma disciplina da engenharia de software que se concentra em garantir a confiabilidade e o desempenho dos sistemas, especialmente em ambientes de produção.

Os profissionais de SRE geralmente trabalham para garantir que os sistemas e serviços sejam altamente confiáveis, escaláveis e eficientes. Eles aplicam princípios de engenharia para automatizar processos, monitorar o desempenho do sistema, responder a incidentes e melhorar continuamente a infraestrutura para evitar falhas.

A abordagem do SRE combina práticas de desenvolvimento de software com operações de infraestrutura, buscando criar sistemas que sejam mais fáceis de gerenciar, mais estáveis e que forneçam uma boa experiência aos usuários finais. A metodologia SRE foi desenvolvida pelo Google, onde essa abordagem foi crucial para manter a confiabilidade de serviços online de grande escala.

O Framework, possuí diversos princípios-chaves que possuem artigos para cada um. Futuramente irei trazer detalhes sobre cada tópico.  

## Princípios-chave do SRE

**Metas de Serviço (SLOs, SLIs e SLAs)**: Estabelecer metas claras de serviço é fundamental. SLIs (Indicadores de Nível de Serviço) são métricas quantificáveis do comportamento do sistema (por exemplo, tempo de resposta). SLOs (Objetivos de Nível de Serviço) são as metas desejadas para esses indicadores, e SLAs (Acordos de Nível de Serviço) são compromissos com os usuários quanto a esses objetivos.

**Automação**: SREs priorizam a automação para lidar com tarefas operacionais repetitivas e reduzir a possibilidade de erro humano. A automação ajuda a garantir consistência e eficiência nas operações.

**Monitoramento e Alertas**: Monitoramento constante é crucial para identificar e resolver problemas rapidamente. SREs configuram alertas que indicam desvios do comportamento normal do sistema, permitindo uma resposta imediata a eventos adversos.

**Escalonamento Controlado**: Mudanças no sistema são implementadas gradualmente e monitoradas de perto para detectar qualquer impacto negativo. Se um problema ocorrer, a mudança pode ser revertida rapidamente.

**Engenharia de Confiabilidade Pós-Incidente (PIE - Post-Incident Engineering)**: Após incidentes, a SRE realiza análises aprofundadas para entender as causas raiz, aprender com os problemas e implementar melhorias para evitar recorrências.

## Cases de SRE

Abaixo apresento para vocês 3 cases que encontrei sobre a utilização das práticas SRE no mercado. 

**Google**: O Google é uma referência para a implementação de práticas SRE. Eles usam SRE para garantir a confiabilidade de seus serviços em larga escala. Por exemplo, o Gmail, Google Search e Google Maps contam com equipes SRE para manter a estabilidade e eficiência.

**Netflix**: Embora não seja explicitamente chamada de SRE, a cultura de engenharia na Netflix compartilha muitos princípios com o SRE. A empresa investe em automação, monitoramento e práticas de engenharia para garantir a confiabilidade do serviço de streaming, que é crítico para seus usuários.

**LinkedIn**: O LinkedIn utiliza práticas SRE para garantir a confiabilidade de sua plataforma. Isso inclui a definição de metas de serviço, automação de processos operacionais e uma abordagem de engenharia para melhorar a confiabilidade do sistema.

## Indicação de livro

Um livro que aborda detalhadamente esses processos é o [Site Reliability Engineering: How Google Runs Production Systems](https://www.amazon.com.br/Site-Reliability-Engineering-Betsy-Beyer/dp/149192912X). Ele trás diveros artigos sobre cada metodo SRE. 


E por hoje é só pessoal, nos veremos em breve com novos posts sobre o **Glossario Tech** aqui no blog.  

Abraço! 


## Refrências:

https://aws.amazon.com/pt/what-is/sre/