<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">

## Remapping Users with the USER id Namespace

The best way to prevent privilege-escalation attacks from within a container is to configure your container’s applications to run as unprivileged users. In many instances there is no need to run a container as root user.

By default, user and group IDs inside the consiner are equivalent to the same IDs on the host machine. This is dangerous in the sense that if a container escape might lead to a full host compromise if the process was running as root. Docker supports isolating the user namespace.  For containers whose processes must run as the root user within the container, you can re-map this user to a less-privileged user on the Docker host

When the user namespace is enabled, user and group IDs in the container are remapped to IDs that do not exist on the host. A number of relatively recent challenges need to be  addressed but one thing you can do to make a significant difference is remap our server’s user (UIDs) and group (GIDs) ranges to different user and group ranges within your containers.

The mapped user is assigned a range of UIDs which function within the namespace as normal UIDs from 0 to 65536, but have no privileges on the host machine itself.

In the following demo, we show how an Nmap container can still run the nmap scan as root inside the container, but outside the container the process is mapped to a less privileged user. Watch the video to see how the remapping users ids work and the Container still can run nmap as root
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/wMjHunoR0zQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


## Use Network Namespace

The network namespace allows a container to have its own view of network interfaces and routing tables. When containers are launched, a network interface is defined and  create. This gives the container a unique IP address and interface.

`docker run -it alpine ip addr show`{{execute}}

By changing the namespace to host, instead of the  container's network being isolated with its interface, the process will  have access to the host machines network interface.

`docker run -it --net=host alpine ip addr show`{{execute}}

If the process listens on ports, they'll be listened on the host interface and mapped to the container.

The network namespace isolates both the interfaces and the routing table, so the routing information is independent of the IP routing table on the host.

## Advanced

Configure the network namespace so that the container can send traffic only to 192.168.1.0/24 addresses. You should test this with a ping from within the container to the remote end

