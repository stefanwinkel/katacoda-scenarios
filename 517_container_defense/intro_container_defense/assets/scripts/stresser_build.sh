#!/bin/bash

# Delete any old images
docker image rm my_stresser -f 2&>1 /dev/null
#Build image based on Dockerfile
docker build -t my_stresser .  > /dev/null
#List results of the build
docker image ls | grep my_stresser
echo "Done Building"
