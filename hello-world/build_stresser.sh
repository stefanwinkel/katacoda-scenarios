#!/bin/bash

echo "Building stresser Docker image"
echo "FROM ubuntu:latest" > ./Dockerfile
echo "RUN apt-get -y update &&  apt-get install -y stress " >> ./Dockerfile
echo "CMD /usr/bin/stress -c 1 --timeout 60s" >> ./Dockerfile
docker build -t my_stresser .  > /dev/null
docker image ls

#docker container run -d --cpuset-cpus 0 --memory 150m --name s100m my_stresser
#docker stats --no-stream

