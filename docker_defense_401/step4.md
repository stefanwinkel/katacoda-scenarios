<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">

## PID Namespaces

If you run the ps command inside a Docker container, you can see only the processes running inside that container and none of the processes running on the host

`docker run --rm -it --name hello ubuntu`{{execute}}

A ps reveals only the bash shell and the ps command being active

`ps -eaf`{{execute}}

This is achieved with the process ID namespace, which restricts the set of process IDs that are visible.

By running unshare you can specify that you want a new PID namespace with the --pid  flag:


`sudo unshare --pid sh`{{execute}}

Now let's run `whoami`{{execute}}

