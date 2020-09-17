<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">

## PID Namespaces

If you run the ps command inside a Docker container, you can see only the processes running inside that container and none of the processes running on the host

`docker run --rm -it --name hello ubuntu`{{execute}}

A ps reveals only the bash shell and the ps command being active

```
ps -eaf
exit
```{{execute}}

This is achieved with the process ID namespace, which restricts the set of process IDs that are visible.

By changing the Pid namespace allows a container to interact with processes beyond its normal scope.

`docker run --rm -it --pid=host --name hello ubuntu`{{execute}}
```
ps -eaf
exit
```{{execute}}


## Advanced

By run unshare you can specify that you want a new PID namespace with the --pid  flag:

sudo unshare --pid sh
whoami

Why does the second time you run the whoami the command fails ?
