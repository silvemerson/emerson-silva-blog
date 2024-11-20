---
title: "003 - Glossário Tech - o que é Continuous Integration"
date: 2024-03-27T01:30:26-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["ci","devops"]
categories: ["glossario-tech"]

lightgallery: true
---

Salve salve pessoal!!!

Tudo bem com vocês? Espero que sim!  
E bora pra mais um post do **Glossario Tech** onde irei trazer algumas tecnologias e falar delas de forma teórica. Bora lá?

## O que é CI

CI é a sigla para Continuous Integration (Integração Contínua), uma prática de desenvolvimento de software em que as mudanças no código são integradas regularmente em um repositório compartilhado e, em seguida, automaticamente testadas e validadas.

O objetivo do CI é detectar erros rapidamente, melhorar a qualidade do software e reduzir o tempo de entrega.

## Como Funciona o CI?

A Integração Contínua (CI) é uma prática que promove a integração frequente de mudanças de código em um repositório central, o que permite maior agilidade e confiabilidade no desenvolvimento de software. Nesse processo, os desenvolvedores enviam alterações regularmente, muitas vezes várias vezes ao dia, garantindo que as novas funcionalidades ou correções estejam sempre alinhadas ao restante do projeto.

Um dos pilares do CI é a automação do build. Assim que uma mudança é detectada no repositório, um servidor de CI dispara automaticamente um processo de compilação do código, o que inclui a geração de artefatos necessários para o funcionamento do software. Esse processo automatizado assegura que o sistema seja continuamente validado, reduzindo a probabilidade de falhas inesperadas.

Outro elemento essencial da Integração Contínua é a execução de testes automatizados. Após a compilação, o servidor executa uma suíte de testes para verificar se as alterações realizadas não causaram problemas ou quebraram funcionalidades existentes. Isso permite que o software mantenha um alto padrão de qualidade durante todo o ciclo de desenvolvimento.

A prática de CI também se destaca por fornecer feedback imediato. Geralmente em questão de minutos, o servidor informa aos desenvolvedores se o processo de build e os testes foram bem-sucedidos ou se houve alguma falha. Esse retorno rápido permite que problemas sejam detectados e resolvidos quase instantaneamente.

Por fim, a correção de erros ocorre de forma ágil. Caso alguma falha seja identificada, os desenvolvedores podem agir prontamente para corrigir os problemas antes de dar continuidade ao trabalho. Essa dinâmica contínua de integração, validação e resolução de erros contribui para um desenvolvimento mais eficiente e com menor risco de acúmulo de problemas ao longo do projeto.

## Por que Usar CI?

A prática de Integração Contínua (CI) é fundamental para aprimorar o desenvolvimento de software, pois permite a detecção rápida de problemas. Por meio da automação de processos, bugs são identificados logo após serem introduzidos, possibilitando sua correção imediata e minimizando o impacto no projeto como um todo. Essa agilidade evita o acúmulo de erros, que poderiam ser mais difíceis de rastrear em etapas posteriores.

Além disso, a CI promove uma integração suave entre os códigos produzidos por diferentes desenvolvedores. Quando muitas pessoas trabalham em um mesmo projeto, é comum que ocorram conflitos ao unir as alterações feitas individualmente. No entanto, a prática de integrar frequentemente essas mudanças reduz a chance de conflitos maiores e torna o processo colaborativo mais eficiente.

Outro benefício significativo da CI é a melhoria contínua na qualidade do software. A validação automática após cada alteração garante que o sistema funcione como esperado, mantendo altos padrões de confiabilidade e desempenho. Isso reduz o risco de falhas em produção e assegura que o produto atenda às expectativas dos usuários.

Por fim, a automação desempenha um papel central nesse contexto. Processos que antes eram manuais, como a compilação do código e a execução de testes, tornam-se automáticos, economizando tempo e esforço da equipe de desenvolvimento. Essa abordagem não apenas aumenta a produtividade, mas também reduz a probabilidade de erros humanos, contribuindo para um fluxo de trabalho mais eficiente e robusto.


## Ferramentas Populares de CI

**Jenkins**: Open-source e altamente configurável.

**GitHub Actions**: Integração nativa com repositórios GitHub.

**GitLab CI/CD**: Integrado ao GitLab.

**CircleCI**: Fácil de configurar e otimizado para agilidade.

T**Travis CI**: Muito usado em projetos open-source.

**Azure DevOps Pipelines**: Solução da Microsoft para CI/CD.


## Referências

https://www.redhat.com/en/topics/devops/what-is-ci-cd