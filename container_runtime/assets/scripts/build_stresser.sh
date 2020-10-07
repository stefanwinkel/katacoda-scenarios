#!/bin/bash

# Create the Dockerfile
echo "Building stresser Docker image"
echo "FROM ubuntu:latest" > ./Dockerfile
echo "RUN apt-get -y update &&  apt-get install -y stress " >> ./Dockerfile
echo "CMD /usr/bin/stress -c 1 --timeout 60s" >> ./Dockerfile
# Delete any old images
docker image rm my_stresser -f 2&>1 /dev/null
#Build image based on Dockerfile
docker build -t my_stresser .  > /dev/null
#List results of the build
docker image ls | grep my_stresser
echo "Done Building"

#Run the container
#docker container run -d --cpuset-cpus 0 --memory 150m --name s100m my_stresser
#List the results
#docker stats --no-stream

