#!/bin/bash
# Victor Hugo - victorhundo@gmail.com 10/2017
# Script para montar página do asciibinder da branch master no compativel com github pages

SITE_ROOT=$( echo "$CIRCLE_PROJECT_REPONAME\/")

function replace {
  find main -name '*.html' -type f -exec sed -i "s/$1/$2/g" '{}' \;
  find main -name '*.css' -type f -exec sed -i "s/$1/$2/g" '{}' \;
}

docker cp docs-asciidoctor:/docs/_preview .
mkdir -p ./_build/main

# Replace Folder names
rm -rf ./_build/*
cp -r ./_preview/main ./_build/
mv ./_build/main/latest/_stylesheets ./_build/main/css
mv ./_build/main/latest/_javascripts ./_build/main/js
mv ./_build/main/latest/_images ./_build/main/imgs
mv ./_build/main/latest/* ./_build/main/
cp ./index.html ./_build/main/
rm -rf ./_build/main/latest

# Replace String names
cd ./_build/
replace "_preview\/main\/" ""
replace "latest\/" $SITE_ROOT
replace "_stylesheets" "css"
replace "_javascripts" "js"
replace "_images" "imgs"
cd - > /dev/null
