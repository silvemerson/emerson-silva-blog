---
title: "Desbravando o OpenTofu: Parte 01 - Introdução e Fundamentos"
date: 2023-12-01T12:24:03-03:00
draft: false
author: "Emerson Silva"
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["devops", "iac"]
categories: ["IaC"]

lightgallery: true
---

Olá pessoal, hoje no blog, vamos falar de uma ferramenta em potencial de Infra as Code chamada OpenTofu. Bora lá

## Como surgiu o OpenTofu

Em 10 de agosto de 2023, a HashiCorp anunciou que após cerca de 9 anos de Terraform sendo de código aberto sob a licença MPL v2, eles repentinamente o mudaram para uma licença BSL v1.1 de código não aberto. Essa mudança é algo venoso para o Terraform e também para toda a comunidade. Foi então que surge o anteriormente denominado OpenTF, OpenTofu que é um fork do Terraform de código aberto, dirigido pela comunidade e fou abraçado(gerenciado) pela Linux Foundation. 

## Por que a licença BSL vai impactar Terraform

O Terraform foi originalmente lançado sob a Licença Pública Mozilla (MPL) v2.0, que é uma licença de código aberto bem conhecida, confiável e permissiva: MPL permite que você use o Terraform para praticamente qualquer finalidade e incorpore-o em qualquer produto, incluindo copiar, modificar e redistribuir o código. A única limitação é que se você modificar o código-fonte do próprio Terraform, deverá liberar essas modificações sob a mesma licença MPL.

Os termos permissivos desta licença foram um fator chave para a adoção do Terraform pela comunidade:

- As empresas sentiram-se confortáveis em adotar o Terraform, pois a licença garantia que não haveria taxas inesperadas ou problemas de propriedade intelectual.

- Os desenvolvedores se sentiram confortáveis em contribuir para o núcleo do Terraform (que tinha mais de 1.700 contribuidores no momento da redação deste artigo) e as centenas de provedores do Terraform (o provedor da AWS tinha mais de 2.800 contribuidores e o provedor do Azure tinha mais de 1.300 contribuidores no momento da redação deste artigo), como a licença garantiu que eles seriam capazes de usar seu trabalho tanto em seus empregos atuais quanto em quaisquer futuros.

- Os fornecedores criaram ferramentas, módulos e extensões para o Terraform (por exemplo, na Gruntwork, criado o Terragrunt e oTerratest), pois a licença garantia que você seria capaz de usar este trabalho, seja para diversão (por exemplo, como parte de um projeto paralelo) ou lucro (por exemplo, como parte de um projeto proprietário).

Isto levou a um ciclo virtuoso: à medida que mais empresas adotam o Terraform, mais desenvolvedores começam a usá-lo, esses desenvolvedores contribuem para o Terraform, corrigindo bugs, melhorando a segurança, adicionando novos recursos, criando novas ferramentas e extensões, etc. 

Isso torna o Terraform ainda mais atraente, então ainda mais empresas o adotam e o ciclo continua. Como resultado, o Terraform se tornou uma das ferramentas de infraestrutura como código (IaC) mais populares do mercado.

Mas nada disso teria acontecido se o Terraform não tivesse sido lançado sob uma licença verdadeiramente de código aberto. Essas empresas não o teriam adotado, esses desenvolvedores não teriam contribuído para isso. 
Posso dizer com certeza que nunca teria sido construído por exemplo o Terragrunt ou Terratest, se o Terraform não fosse de código aberto.

## A mudança para BSL

Após cerca de 9 anos vendo o ciclo virtuoso do código aberto em ação, ficamos chocados ao ouvir o anúncio da HashiCorp de que eles estavam repentinamente mudando o Terraform para a Business Source License (BSL) v1.1, que não é uma licença de código aberto (própria da HashiCorp). FAQ ainda diz que o BSL não atende à definição de código aberto). Na verdade, não apenas o Terraform, mas todos os outros produtos principais da HashiCorp também estão migrando para o BSL: por exemplo, Vault, Consul, Nomad, etc.

Até certo ponto, entendemos o que levou a HashiCorp nessa direção. Eles estão tentando manter um equilíbrio delicado: por um lado, estão criando um valor incrível ao fornecer software de código aberto, gratuito e de alta qualidade para uma comunidade de milhares de desenvolvedores, por outro lado, estão a tentar gerir um negócio sustentável, pelo que precisam de capturar e rentabilizar parte do valor que criam.

A parte complicada é decidir o que tornar open source e o que comercializar. Se você fizer muito código aberto, não terá o suficiente para vender, então não poderá ganhar dinheiro suficiente para pagar os próprios funcionários que estão criando e mantendo esses incríveis projetos de código aberto, então todos perdem. Mas se você produzir pouco código aberto, nunca construirá uma comunidade e, sem essa comunidade, não conseguirá vender o suficiente, não poderá pagar aos funcionários e, novamente, todos perderão. Somente quando você consegue esse equilíbrio é que todos ganham.


É por isso que estamos tão perplexos com a mudança repentina de uma licença de código aberto para uma licença BSL de código aberto. Acreditamos que esse afastamento do código aberto perturbará o delicado equilíbrio e levará a um cenário em que todos perderão: a comunidade perderá, as empresas que usam o Terraform perderão e, em última análise, até a HashiCorp perderá. Vamos discutir o porquê disso entendendo o que é o BSL. 

## Os problemas com BSL

A licença BSL, juntamente com as concessões de uso adicionais que a HashiCorp escreveu para ela, é geralmente bastante permissiva, permitindo copiar, modificar e redistribuir o código. Contudo, há uma exceção. A licença não permite que você use o Terraform se você atender a ambas as condições a seguir:

- Você está construindo um produto competitivo com a HashiCorp.

- Você incorpora ou hospeda o Terraform em seu produto.

O primeiro problema é que os termos do BSL e das concessões de uso são vagos. O que significa “competitivo com a HashiCorp” e quem decide isso? E o que significa “incorporar ou hospedar”? Se você é advogado e vê isso, você começa a suar. O número de perguntas é infinito. Por exemplo, se você é um fornecedor independente de software (ISV) ou provedor de serviços gerenciados (MSP) no espaço DevOps e usa o Terraform com seus clientes (mas não necessariamente o Terraform Cloud/Enterprise), você é um concorrente? Se sua empresa cria um produto CI/CD, ele é competitivo com Terraform Cloud? Se o seu produto CI/CD oferece suporte nativo à execução do Terraform como parte de suas compilações de CI/CD, isso é incorporação ou hospedagem? Se você construiu um wrapper para o Terraform, ele é um concorrente? A incorporação é apenas se você incluir o código-fonte ou o uso da CLI do Terraform conta como incorporação? E se a CLI for instalada pelo cliente? É hospedagem se o cliente executa seu produto em seus próprios servidores?

Portanto, gera várias perguntas que acaba deixando nós da comunidade em dúvida. 

Não é por acaso que esses termos são vagos. Esta é uma prática comum usada por muitas equipes jurídicas para forçá-lo implicitamente a pedir permissão à empresa, para que possam decidir caso a caso: o [FAQ da HashiCorp](https://www.hashicorp.com/license-faq) até diz que para obter esclarecimentos sobre se o que você está fazendo é competitivo ou incorporação ou hospedagem, você precisa entrar em contato com licenciamento@hashicorp.com.

E isso leva ao segundo problema com o BSL: se o seu uso está em conformidade com a licença não é determinado pelos termos legais, mas depende inteiramente do capricho da HashiCorp. Se a HashiCorp não acha que você é um concorrente, você está livre. Mas se eles se sentirem ameaçados pela sua empresa: nada de Terraform para você. Se eles quiserem definir seu uso como incorporação ou hospedagem: nada de Terraform para você. Ou talvez eles concedam a você uma licença para usar o Terraform, mas apenas mediante o pagamento de uma taxa, e se você não puder pagar essa taxa: não há Terraform para você.

E isso nos leva ao terceiro e pior problema do BSL: a HashiCorp pode mudar suas decisões a qualquer momento. Talvez a HashiCorp tenha lhe dito que seu uso era seguro antes, mas um ano depois, você lançou um novo produto e agora eles pensam que você é um concorrente, então, de repente, seu uso não está mais em conformidade com a licença. Ou talvez você não tenha mudado nada, mas foi a HashiCorp quem lançou um novo produto, que por acaso está no seu mercado. 

Enfim, é um discussão que vai se render bastante, até o momento que foi escrito esse post, fazem 3 meses da decisão da Hashicorp e vamos seguir acompanhando. 


Mas em resumo, com a mudança explicada no tópicos anteriores desse post, a comunidade decidiu criar um fork do Terraform, chamado OpenTF que depois foi renomeado para OpenTofu. E agora, bora fazer a instalação dele 

## Instalação

Até o momento da escrita desse post, ainda não existe binários para a instalação do OpenTofu para nosso querido Windows. 

**Via Script**

```curl -s https://packagecloud.io/install/repositories/opentofu/tofu/script.deb.sh?any=true -o /tmp/tofu-repository-setup.sh```

```sudo bash /tmp/tofu-repository-setup.sh```

```rm /tmp/tofu-repository-setup.sh```

```sudo apt-get install tofu```


Pronto, o OpenTofu está instalado. Aguardo vocês no próximo post para que possamos construir nossa Infra como Código. Por se tratar algo novo, bugs podem ser identificados, então galerinha, não deixem de contribuir criando Issues e soluções para possíves problemas. 

Abraço. 


## Referências 

https://github.com/opentofu

https://www.hashicorp.com/license-faq

https://opentofu.org/docs/intro/install/

https://opentofu.org/docs/intro/

https://www.linuxfoundation.org/press/announcing-opentofu

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