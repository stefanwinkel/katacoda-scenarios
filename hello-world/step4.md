<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">

## Use of the PID  Namespace

# Lets build a simple Docker Image that calls stress program for 30s
# echo "RUN apt-get update && apt-get install -y stress " >> ./Dockerfile

```
echo "FROM ubuntu:latest" > ./Dockerfile
echo "CMD /usr/bin/stress -c 4 -t 30" >> ./Dockerfile
docker build -t mystresser .
```{{execute}}

# Run the container and limit the memory to 100Mb
`docker container run -d --cpuset-cpus 0 --name s100 stresser`{{execute}}

# Verify tha 100Mb limit that was put on the runtime for the Container
`docker stats --no-stream`{{execute}}

