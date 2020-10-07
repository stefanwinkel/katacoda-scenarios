#!/bin/bash

#Run the container
docker container run -d --cpuset-cpus 0 --memory 150m --name s100m my_stresser

#List the results
docker stats --no-stream

