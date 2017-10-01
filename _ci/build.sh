#!/bin/bash
# Victor Hugo - victorhundo@gmail.com 10/2017
# Script para montar containers
docker-compose -f docker-circle.yaml up --build -d

echo Wait container is ready!
sleep 10
