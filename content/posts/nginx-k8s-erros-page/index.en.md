---
title: "Nginx + Kubernetes: Personalizando Páginas de Erro HTTP"
date: 2025-03-20T19:10:03-03:00
draft: false
author: "Emerson Silva"
comment: true 
resources:
- name: "featured-image"
  src: "featured-image.png"

tags: ["kuberntes","k8s","nginx","http-code"]
categories: ["Containers"]


lightgallery: true
---

Salve salve pessoal!!!

Tudo bem com vocês? Espero que sim!  

Hoje aqui no blog vamos falar sobre como podemos personalizar páginas de erros no Nginx no Kubernetes. Bora lá!

As páginas de erro 404, 401, 500, entre outros, são parte fundamental da navegação na web. Tem outros erros, mas vamos falar de pelo menos um nesse laboratório. Elas surgem quando algo não ocorre como esperado durante a interação do usuário com um site. Esses erros não são somente inevitáveis em muitos casos, mas também oferecem uma oportunidade valiosa para otimizar a experiência do usuário, evitando frustrações e proporcionando uma navegação mais amigável e informativa.


## Erro 404

O erro 404, frequentemente encontrado por quem navega na web, ocorre quando o servidor não consegue localizar o conteúdo solicitado. Isso pode acontecer por diversos motivos, como links quebrados, URLs digitadas incorretamente ou até mesmo quando uma página é removida sem ser redirecionada. Apesar de ser um erro comum, sua importância não deve ser subestimada.

Quando um usuário se depara com uma página 404 genérica e fria, a sensação de frustração é quase inevitável. A falta de informações adicionais pode fazer com que o visitante se sinta perdido e desmotivado a continuar explorando o site. No entanto, ao personalizar a página 404, o proprietário do site tem a chance de transformar uma experiência negativa em algo mais construtivo. Em vez de simplesmente mostrar uma mensagem de erro, uma página 404 personalizada pode oferecer links para outras áreas relevantes do site, um mecanismo de busca ou até mesmo uma mensagem divertida e acolhedora que ajude o usuário a se sentir mais confortável. A personalização transforma uma simples falha técnica em uma oportunidade para manter o engajamento e o interesse do usuário.


## Qual o sentido de Personalizar as Páginas de Erro

A personalização dessas páginas não é somente uma questão estética ou técnica, mas uma estratégia de usabilidade e relacionamento com o usuário. Elas representam um ponto de contato com o visitante que, se bem administrado, pode transformar uma falha em uma experiência positiva.

Páginas de erro personalizadas demonstram que o proprietário do site se preocupa com a experiência do usuário. Elas transmitem um sentimento de que o erro não foi ignorado, mas sim compreendido e tratado de forma a não prejudicar a navegação. Isso pode aumentar a confiança do usuário no site, encorajá-lo a voltar, ou até mesmo ajudá-lo a resolver o problema sozinho. Por exemplo, em uma página 404 bem desenhada, o usuário pode ser redirecionado para o conteúdo correto rapidamente, sem precisar procurar por conta própria. Da mesma forma, uma página 500 personalizada pode dar um toque de empatia, explicando que a equipe está trabalhando para resolver o problema, o que humaniza ainda mais a experiência.

Além disso, personalizar essas páginas também pode refletir a identidade da marca. As mensagens, o design e os recursos presentes nessas páginas podem ser alinhados com o tom e a voz do site, criando uma continuidade na comunicação. Isso é crucial em uma época onde os usuários esperam que os sites ofereçam uma experiência coesa e sem fricções.

Pronto pessoal, depois de uma leitura didática e teórica, vamos para o que interessa, mão na massa. Vem comigo!

## Mão na massa 

Como pré-requisito, tenha um K8s em execução, seja na nuvem, bare-metal, minukube, kind, k3s, a sua escolha. E não podemos esquecer do helm e um copo de café. 

Vamos começar adicionando o chart no Nginx: 

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update
```

Agora, instalando chart: 

```bash
helm install emersonlabs-nginx ingress-nginx/ingress-nginx
```
Pronto, instalado. 

### Personalizações

Agora, iremos criar um arquivo chamado `custom-error-pages.yaml` e adicione o conteúdo abaixo:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: custom-error-pages
data: 
  404.html: | 
    <!DOCTYPE html>
    <html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Erro 404 - Página Não Encontrada</title>
        <style>
            body { text-align: center; font-family: Arial, sans-serif; background-color: #222; color: #fff; }
            h1 { font-size: 5rem; }
            p { font-size: 1.5rem; }
            img { width: 300px; margin-top: 20px; }
        </style>
    </head>
    <body>
        <h1>404</h1>
        <p>Oops! A página não foi encontrada!</p>
        <p><a href="/">Voltar para o Home</a></p>
    </body>
    </html>
```

Aplique esse `ConfigMap`:

```bash
kubectl apply -f custom-error-pages.yaml

```
Agora vamos configurar o arquivo de values personalizado para carregar essa configuração. 

`custom-backend-values.yaml`

```yaml

controller:
  config:
    custom-http-errors: "404"
  enabled: true
  image:
    registry: registry.k8s.io
    image: ingress-nginx/custom-error-pages
    tag: v1.1.1@sha256:8c10776191ae44b5c387b8c7696d8bc17ceec90d7184a3a38b89ac8434b6c56b
  extraVolumes:
  - name: custom-error-pages
    configMap:
      name: custom-error-pages
      items:
      - key: "404.html" 
        path: "404.html"     
  extraVolumeMounts:
  - name: custom-error-pages
    mountPath: /www

```
Agora vamos aplicar essa personalização e criar um novo microsserviço chamado backend. 

```bash
helm install emersonlabs-nginx ingress-nginx/ingress-nginx
```
Vocês vão ter o seguinte resultado: 


```bash
kubectl get pods,svc

NAME                                                       READY   STATUS    RESTARTS      AGE
pod/emersonlabs-nginx-ingress-nginx-controller-5c4797fff4-xttbc      1/1     Running   0 (1s)   1s
pod/emersonlabs-nginx-ingress-nginx-defaultbackend-fbdc6987c-d7n82   1/1     Running   0 (1s)   1s

NAME                                                 TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)                      AGE
service/emersonlabs-nginx-ingress-nginx-controller             LoadBalancer   10.109.118.177   192.168.56.100   80:30910/TCP,443:31572/TCP   142m
service/emersonlabs-nginx-ingress-nginx-controller-admission   ClusterIP      10.103.142.127   <none>           443/TCP                      142m
service/emersonlabs-nginx-ingress-nginx-defaultbackend         ClusterIP      10.101.15.139    <none>           80/TCP                       133m

```
### O que estamos fazendo de fato?


O serviço do emersonlabs-nginx-ingress-nginx-defaultbackend, vai ser responsável por tratar os erros de HTTP que o Nginx Controller receber, como criamos uma página personalizada, ela quem vai aparece em erros 404 HTTP. 

Vamos simular? 

Se você não estiver usando um LoadBalancer para acessar o IP dele, use o port-forward: 

```bash
kubectl -n nginx port-forward service/emersonlabs-nginx-ingress-nginx-controller 8080:80
```

Resultado:

[![Captura de tela](https://i.ibb.co/Kz3kkpZy/Captura-de-tela-de-2025-03-20-14-42-05.png)](https://i.ibb.co/Kz3kkpZy/Captura-de-tela-de-2025-03-20-14-42-05.png)


## Conclusão

É isso pessoal, dessa forma vocês podemos personalizar a página de Erro do Nginx. 
Não se esqueçam de compartilhar em suas redes sociais. 



## Referências

https://github.com/kubernetes/ingress-nginx/tree/main/docs/examples/customization/custom-errors

https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx

https://kubernetes.github.io/ingress-nginx/user-guide/custom-errors/

https://docs.gitlab.com/ee/user/infrastructure/iac/terraform_state.html

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