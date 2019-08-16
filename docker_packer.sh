#!/bin/bash
#./docker_packer.sh tonglu_webapp:1.1.0
name=$1
cd /home/docker
docker build --rm --tag "$name" .
#docker run -d -p 81:7777 "$name"
docker save -o images/$(date +"%Y%m%d%H%M%S").tar "$name"
