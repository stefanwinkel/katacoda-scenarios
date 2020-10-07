#!/bin/bash

# Create the Stresser Dockerfile
echo "Building stresser Docker image"
echo "FROM ubuntu:latest" > ./Dockerfile
echo "RUN apt-get -y update &&  apt-get install -y stress " >> ./Dockerfile
echo "CMD /usr/bin/stress -c 1 --timeout 60s" >> ./Dockerfile
