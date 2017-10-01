#!/bin/bash
# Victor Hugo - victorhundo@gmail.com 10/2017
# Script para fazer deploy no gh-pages

mkdir -p /opt/gh-pages && cp -rf ./_build/main/* /opt/gh-pages/
git add .
git -c user.name='CircleCI' -c user.email='circleci' commit -m 'Commit to checkout'

git checkout gh-pages && rm -rf *
cp -rf /opt/gh-pages/* ./
git add .
git -c user.name='CircleCI' -c user.email='circleci' commit -m 'UPDATE GitHub Pages'
git push
