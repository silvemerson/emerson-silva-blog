# Emerson Silva Blog 

### Hugo + LoveIT + Netlify


Blog Link: https://emerson-silva.blog.br

Projeto **OpenSource**, faça seu blog e compartilhe conhecimento! 

![](https://gohugo.io/images/hugo-logo-wide.svg)

## Install Hugo 

1. Instale via gerenciador de pacotes:

```bash
sudo apt update
sudo apt install hugo -y
```
OU instale o binário mais recente manualmente, baixando da página de releases do [Hugo](https://github.com/gohugoio/hugo/releases).

2. Verifique a instalação:

```bash
hugo version
```

## Inicializar um Novo Site

Crie um novo site Hugo:

Execute o comando:

```bash
hugo new site meuprojeto
```

## Escolha e instale um tema:

1. Acesse o diretório do projeto:

```bash
cd meuprojeto
```

2. Baixe um tema da galeria de [temas do Hugo](https://themes.gohugo.io/).

Clone o repositório do tema no diretório themes. Por exemplo:

```bash
git clone https://github.com/theNewDynamic/gohugo-theme-ananke themes/ananke
```
Ative o tema no arquivo `config.toml`:

```bash
theme = "ananke"
```

3. Crie o primeiro conteúdo:

Gere um novo post:

```bash
hugo new posts/meu-primeiro-post.md
```
Edite o arquivo gerado em ```content/posts/meu-primeiro-post.md```.

Inicie o servidor de desenvolvimento:

Execute:

```bash
hugo server
```
O site estará disponível em http://localhost:1313.

## Construir o Site para Produção

Para gerar os arquivos do site estático, use:

```bash
hugo
```

Os arquivos prontos estarão no diretório public.

Agora, você pode hospedar o site em qualquer serviço de hospedagem estática, como GitHub Pages, Netlify ou Vercel.
