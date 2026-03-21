---
title: "KCNA - Como se preparar e passar na certificação"
date: 2026-03-16T00:00:00-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["kubernetes", "kcna", "certificação", "devops", "cloud-native"]
categories: ["Kubernetes"]

lightgallery: true
---

Salve salve pessoal!!!

Tudo bem com vocês? Espero que sim!

Recentemente fui aprovado na **KCNA (Kubernetes and Cloud Native Associate)** e hoje quero compartilhar como foi essa jornada e, principalmente, como você pode se preparar para passar nessa prova também. Bora lá?

## O que é a KCNA?

A KCNA é uma certificação da **Linux Foundation** em parceria com a **CNCF (Cloud Native Computing Foundation)**. Ela é voltada para quem está começando no mundo Kubernetes e Cloud Native, validando conhecimentos fundamentais sobre:

- Fundamentos do Kubernetes
- Orquestração de containers
- Arquitetura Cloud Native
- Ecossistema CNCF
- Observabilidade
- Segurança básica em Kubernetes

É uma prova **teórica**, no formato de múltipla escolha, com **90 minutos** de duração e **60 questões**. A nota mínima para aprovação é **75%**.

Diferente da CKA e CKS, não é uma prova prática — mas isso não significa que é fácil. Ela exige que você entenda bem os conceitos e o ecossistema Cloud Native como um todo.

## Para quem é essa certificação?

A KCNA é ideal para:

- Profissionais que estão **começando com Kubernetes** e querem validar seus conhecimentos
- Desenvolvedores que querem entender melhor o ecossistema Cloud Native
- Quem quer dar o **primeiro passo** antes de partir para certificações mais avançadas como CKA, CKAD ou CKS


## Domínios cobrados na prova

Antes de estudar, entenda o que cai na prova. Os principais domínios são:

**Fundamentos do Kubernetes (46%)**
- Arquitetura do cluster (control plane, worker nodes)
- Workloads: Pods, Deployments, ReplicaSets, StatefulSets, DaemonSets
- Scheduling e recursos
- Services e networking
- Storage: PV, PVC, StorageClass
- ConfigMaps e Secrets

**Orquestração de Containers (22%)**
- Fundamentos de containers
- Container runtime (containerd, CRI-O)
- Imagens e registries

**Arquitetura Cloud Native (16%)**
- Padrões Cloud Native
- Microservices
- Service Mesh

**Ecossistema CNCF (8%)**
- Projetos CNCF (Prometheus, Fluentd, Jaeger, Argo, etc)
- Graduated vs Incubating projects

**Observabilidade (8%)**
- Logs, métricas e tracing
- Ferramentas de monitoramento

## Recursos que usei na preparação

### 1. Documentação oficial do Kubernetes

A [documentação oficial do Kubernetes](https://kubernetes.io/docs/home/) é sua melhor amiga. Ela é gratuita, completa e é exatamente a base que a prova cobra. Foque especialmente nas seções:

- **Concepts** — entenda a arquitetura, os objetos e como tudo se conecta
- **Tasks** — veja exemplos práticos dos principais recursos
- **Reference** — API e componentes do cluster

Não precisa decorar comandos, mas entender os conceitos por trás de cada objeto é fundamental.

### 2. Livros

Livros são ótimos para construir uma base sólida. Se você está começando, recomendo uma leitura estruturada que vai do básico de containers até os conceitos mais avançados de orquestração. O meu próprio livro **[Kubernetes para Iniciantes: Fundamentos e Práticas](https://a.co/d/dmxgdnz)** pode ser um bom ponto de partida — escrevi ele justamente pensando em quem está dando os primeiros passos com K8s.

### 3. Simulado do Tutorials Dojo (gratuito!)

Esse foi um dos recursos mais valiosos da minha preparação. O **Tutorials Dojo** disponibiliza um [simulado gratuito de KCNA](https://portal.tutorialsdojo.com/courses/free-kubernetes-and-cloud-native-associate-kcna-practice-exams-sampler/) com 20 questões em dois modos:

- **Timed Mode** — simula a pressão do tempo real da prova
- **Review Mode** — você vê a explicação de cada resposta, certa ou errada

Meu conselho: faça primeiro no modo timed para sentir o ritmo, depois refaça no modo review para entender cada conceito que errou. As explicações são muito boas e ajudam a fixar o conteúdo.

Eles também têm uma versão paga com mais de 100 questões caso queira se aprofundar ainda mais.

## Como estruturar seus estudos

Independente do seu nível atual, aqui vai uma sugestão de abordagem:

**Semana 1-2 — Base conceitual**
Leia a documentação oficial, focando nos conceitos fundamentais. Entenda a arquitetura do cluster, os principais objetos e como o Kubernetes resolve problemas de orquestração.

**Semana 3 — Ecossistema CNCF**
Pesquise os principais projetos CNCF. Não precisa ser expert em todos, mas entender o propósito de cada um (Prometheus para métricas, Jaeger para tracing, Argo para GitOps, etc) é importante.

**Semana 4 — Simulados e revisão**
Faça os simulados, anote os pontos fracos e revise especificamente esses tópicos. Repita até se sentir confortável com o tempo e com os temas cobrados.

> **Dica importante:** Se você já tem experiência prática com Kubernetes, o tempo de estudo pode ser bem menor. Mas se está começando agora, não tente cortar caminho — a prova exige que você entenda os conceitos, não apenas memorize respostas.

## Como é a prova na prática

A prova é realizada de forma **online, com supervisão remota (proctored)**. Algumas informações importantes:

- **Plataforma:** PSI
- **Duração:** 90 minutos
- **Questões:** 60 (múltipla escolha)
- **Aprovação:** 75% (45 questões certas)
- **Idioma:** Inglês
- **Validade:** 3 anos

O ambiente é tranquilo, mas requer atenção com as regras: ambiente silencioso, mesa limpa, documento de identidade em mãos. Chegue com antecedência para o check-in.

Na minha experiência, a prova foi **na medida do esperado** — quem estudar bem os conceitos e fizer os simulados não vai ter surpresas.

## Dicas finais

**Não decore, entenda.** A prova tem questões que exigem raciocínio sobre os conceitos, não apenas memorização.

**Foque no ecossistema CNCF.** Muita gente negligencia essa parte e se surpreende na hora da prova. Conheça os principais projetos e o que eles fazem.

**Use os simulados de forma ativa.** Não basta fazer e ver a nota — revise cada questão errada e entenda por que a resposta correta é aquela.

**A documentação é sua maior aliada.** Tudo que cai na prova está documentado em kubernetes.io. Se tiver dúvida sobre um conceito, vai lá.

## Recursos

- [Documentação oficial do Kubernetes](https://kubernetes.io/docs/home/)
- [Simulado gratuito KCNA - Tutorials Dojo](https://portal.tutorialsdojo.com/courses/free-kubernetes-and-cloud-native-associate-kcna-practice-exams-sampler/)
- [Página oficial da certificação KCNA - Linux Foundation](https://training.linuxfoundation.org/certification/kubernetes-cloud-native-associate/)
- [Projetos CNCF](https://www.cncf.io/projects/)

---

Link do meu certificado do [KCNA](https://ti-user-certificates.s3.amazonaws.com/e0df7fbf-a057-42af-8a1f-590912be5460/7d574cfc-8b45-45df-b6a3-57fd3a98a9a1-emerson-silva-1791983a-ea6f-4f0a-bcda-f7baaebf2d28-certificate.pdf)

É isso, pessoal! Espero que esse post ajude quem está pensando em tirar a KCNA. Qualquer dúvida, me chama nas redes sociais, vou ter um vídeo em breve cobrindo esse mesmo conteúdo com mais detalhes.

Bora pra cima! 🚀