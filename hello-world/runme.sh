#!/bin/bash

docker rm -f s100m
echo "FROM ubuntu:latest" > ./Dockerfile
echo "RUN apt-get install -y stress " >> ./Dockerfile
echo "CMD /usr/bin/stress -c 1 --timeout 60s" >> ./Dockerfile
docker build -t my_stresser .

docker container run -d --cpuset-cpus 0 --memory 150m --name s100m my_stresser
docker stats --no-stream

