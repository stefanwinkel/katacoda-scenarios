<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">

Memory limits are one of the most basic restriction you can place on a container. They restrict the amount of memory that processes inside a container  can use. Control Groups a Linux kernel feature that controls how much resources (CPU, memory, filesystem, network, etc) a process can use.

1. By adding limits you can protect the system from potentially malicious users or applications aiming to perform Denial of Service (DoS) applications via resource exhaustion.
2. You can deliver a guaranteed Quality of Service to applications by ensuring they have enough space available.
3. It's also possible to help limit applications from memory leaks or other programming bugs by defining upper boundaries.

You can put a limit in place by using the -m or --memory flag on the docker container run or docker container create commands. If the image reaches the upper threshold the image will be halted. Similar can be done for Swap memory

`docker run -d --name alp100 --memory 100m alpine top`{{execute}}

The memory usage ad limits of containers can be identified via the docker stats command.

`docker stats --no-stream`{{execute}}

## Important
The most important thing to understand about memory limits is that they’re not reservations. They don’t guarantee that the specified amount of memory will be available. They’re only a protection from overconsumption.

## Considerations
1. Can the software you’re running operate under the proposed memory allowance?
2. Can the system you’re running on support the allowance?

## Advanced
1. How does this apply to a Java Image with the JVM and parameters like maximum heap size (-Xmx) ?
