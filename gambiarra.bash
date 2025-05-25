#!/bin/bash

cd content/posts

for file in *.md; do
  # pega o nome base do arquivo sem extensão
  base=$(basename "$file" .md)

  # cria pasta com esse nome
  mkdir -p "$base"

  # move o arquivo e renomeia pra index.en.md
  mv "$file" "$base/index.en.md"

  echo "Movido: $file → $base/index.en.md"
done

