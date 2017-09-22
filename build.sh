#!/bin/bash

SITE_ROOT="docs\/"

docker-compose down && docker-compose up --build -d
#Wait Docker is Ready!
docker logs -f docs-asciidoctor | while read line
do
    if echo $line | grep -q 'Guard is now watching'; then
        echo 'Server Started'
        LOG_PID=$(pgrep -f 'docker logs')
        kill -9 $LOG_PID;
    fi
    echo $line
done

function replace {
  find main -name '*.html' -type f -exec sed -i "s/$1/$2/g" '{}' \;
  find main -name '*.css' -type f -exec sed -i "s/$1/$2/g" '{}' \;
}


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

cd -

echo "BUILD DONE!"
