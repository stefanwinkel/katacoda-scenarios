<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">

## Use of the PID  Namespace

Lets build a simple Docker Image that calls stress program for 30s

```
echo "FROM ubuntu:latest" > ./Dockerfile
echo "CMD /usr/bin/stress -c 4 --timeout 30s" >> ./Dockerfile
docker build -t my_stresser .
```{{execute}}

# Run the container and limit the memory to 100Mb
`docker container run -d --cpuset-cpus 0 --memory 100m --name s100 my_stresser`{{execute}}

# Verify the container is running with a 100Mb Memory limit
`docker stats --no-stream`{{execute}}`

