<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">

## Limit Image Memory Usage

Lets build a simple Docker image that calls the Unix stress program for 60s

## Create and build a Docker image

We create a Dockerfile based on Ubuntu layout and build the image

```
echo "FROM ubuntu:latest" > ./Dockerfile
echo "CMD /usr/bin/stress -c 1 --timeout 60s" >> ./Dockerfile
docker build -t my_stresser .
```{{execute}}

## Execute the container and limit the memory

We run the container with limited memory (--memory) and verify with docker-stats that the runtime limit is set to 100mb

```
docker container run -d --cpuset-cpus 0 --memory 100m --name s100 my_stresser
docker stats --no-stream
```{{execute}}

## Verify
As you can see from the docker stats output the container was limited to 100Mb
Note: The container will end itself after the stress command terminates (60s)


