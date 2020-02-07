#!/usr/bin/env bash

cd server 
./download.sh
docker build . -t teocafe/mockserver:latest

cd ..
cd client 
docker build . -t teocafe/mockclient:latest

docker-compose up
