#!/bin/bash

SITE_ROOT=$( echo "$CIRCLE_PROJECT_REPONAME\/")
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET_COLOR=`tput sgr0`

function replace {
  find main -name '*.html' -type f -exec sed -i "s/$1/$2/g" '{}' \;
  find main -name '*.css' -type f -exec sed -i "s/$1/$2/g" '{}' \;
}

docker cp docs-asciidoctor:/docs/_preview .
mkdir -p ./_build/main

rm -rf ./_build/*
cp -r ./_preview/main ./_build/
mv ./_build/main/latest/_stylesheets ./_build/main/css
mv ./_build/main/latest/_javascripts ./_build/main/js
mv ./_build/main/latest/_images ./_build/main/imgs
mv ./_build/main/latest/* ./_build/main/
cp ./index.html ./_build/main/
rm -rf ./_build/main/latest


cd ./_build/
replace "_preview\/main\/" ""
replace "latest\/" $SITE_ROOT
replace "_stylesheets" "css"
replace "_javascripts" "js"
replace "_images" "imgs"
cd - > /dev/null

cp -r ./_build /tmp
if [ $? -eq 0 ]; then
    cp -rf /tmp/_build/main/* . && rm -rf /tmp/_build
    printf "${GREEN}BUILD DONE!\n${RESET_COLOR}"
    printf "${YELLOW}Agora você está na branch gh-pages!\n${RESET_COLOR}"
else
    printf "${RED}Commite as mudanças antes de realizar o build!\n${RESET_COLOR}"
fi
