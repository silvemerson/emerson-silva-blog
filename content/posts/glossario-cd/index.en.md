---
title: "004 - Glossário Tech - o que é Continuous Delivery/Deployment"
date: 2024-04-27T01:30:26-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["cd","devops"]
categories: ["glossario-tech"]

lightgallery: true
---

Salve salve pessoal!!!

Tudo bem com vocês? Espero que sim!  
E bora pra mais um post do **Glossario Tech** onde irei trazer algumas tecnologias e falar delas de forma teórica. Bora lá?

## O que é CD

CD é a sigla para Continuous Delivery (Entrega Contínua) ou Continuous Deployment (Implantação Contínua), duas práticas relacionadas à Integração Contínua (CI) que têm como objetivo automatizar as etapas que seguem a integração de código, garantindo que o software esteja sempre pronto para ser entregue ou implantado em produção.

## Continuous Delivery (Entrega Contínua)

A Entrega Contínua é a prática de garantir que as alterações no código estejam sempre em um estado que possa ser liberado com segurança. Nesse processo, após a Integração Contínua (CI), o código é automaticamente testado e empacotado, sendo disponibilizado para implantação em um ambiente de produção com aprovação manual.

O foco principal do Continuous Delivery é:

 - Garantir que cada versão do software esteja testada e validada.
 - Oferecer aos desenvolvedores e gestores a capacidade de decidir quando liberar a nova versão para produção.

## Continuous Deployment (Implantação Contínua)

A Implantação Contínua vai um passo além da Entrega Contínua, eliminando a necessidade de aprovação manual. Nesse caso, as mudanças aprovadas e validadas nos testes automatizados são automaticamente implantadas nos ambientes de produção. Isso exige um pipeline altamente confiável, onde os testes automatizados cobrem a maioria dos casos possíveis.

O foco do Continuous Deployment é:

 - Automatizar completamente o fluxo de entrega até a produção.
 - Reduzir o tempo de entrega de novas funcionalidades ou correções.

## Diferenças entre CI, CD (Delivery) e CD (Deployment)


| **Prática**          | **Foco**                                                      | **Automatização**          | **Aprovação Manual**      |
|-----------------------|--------------------------------------------------------------|-----------------------------|---------------------------|
| **CI**               | Integração frequente e validação automática do código         | Automatiza *build* e testes | Não necessário            |
| **CD (Delivery)**    | Garantir que o código esteja sempre pronto para produção      | Automatiza até a entrega    | Sim (antes da implantação)|
| **CD (Deployment)**  | Implantação automática de código validado diretamente em produção | Automatiza tudo             | Não (totalmente automatizado)|

## Benefícios do CD

A adoção de práticas modernas como a Integração Contínua (CI) e a Entrega Contínua (CD) traz diversos benefícios que transformam o processo de desenvolvimento de software. Um dos principais é a rapidez, que permite reduzir significativamente o tempo necessário para implementar mudanças no ambiente de produção. Essa agilidade é essencial para equipes que precisam responder rapidamente a novas demandas ou corrigir problemas em tempo hábil.

Outro benefício crucial é a confiabilidade, alcançada por meio de testes automatizados que garantem que o software seja implantado sem erros. Esses testes validam o funcionamento correto do sistema após cada alteração, reduzindo o risco de falhas em produção e aumentando a segurança do processo.

Além disso, o feedback imediato oferecido pelas ferramentas de CI/CD acelera a detecção de alterações problemáticas. Quando uma mudança introduz um erro, o sistema alerta a equipe rapidamente, permitindo uma resposta ágil para solucionar o problema antes que ele impacte o restante do projeto.

A eficiência também é um aspecto marcante. Com processos de automação eliminando tarefas manuais e repetitivas, os desenvolvedores podem se concentrar em atividades mais estratégicas, como a criação de novas funcionalidades. Isso não só otimiza o tempo da equipe, mas também melhora a produtividade geral.

Por fim, a entrega contínua de valor se destaca como um dos maiores ganhos. Com um fluxo contínuo de melhorias e novas funcionalidades chegando aos usuários, as empresas conseguem atender suas expectativas com mais frequência, fortalecendo a confiança e a satisfação do cliente. Esses benefícios tornam as práticas de CI/CD indispensáveis para equipes que buscam eficiência e qualidade no desenvolvimento de software.


## Ferramentas Populares de CI/CD

**Jenkins**: Automação de todo o pipeline de entrega.

**GitLab CI/CD**: Integração e entrega dentro da plataforma GitLab.

**GitHub Actions**: Configuração de pipelines diretamente no GitHub.

**Azure DevOps Pipelines**: Suporte a CI/CD para ambientes de nuvem e on-premise.

**ArgoCD**: Específico para pipelines de entrega contínua em Kubernetes.

Essas práticas ajudam equipes a desenvolver, testar e lançar software de forma ágil, colaborativa e com menos riscos.


## Referências

https://www.redhat.com/en/topics/devops/what-is-ci-cd