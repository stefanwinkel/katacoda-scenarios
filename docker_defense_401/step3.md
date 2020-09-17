<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">


## Remapping Users with the USER id Namespace

Docker supports isolating the user namespace. By default, user and group IDs inside a container are equivalent to the same IDs on the host machine.
When the user namespace is enabled, user and group IDs in the container are remapped to IDs that do not exist on the host. A number of relatively recent challenges need to be  addressed but one thing you can do to make a significant difference is remap our server’s user (UIDs) and group (GIDs) ranges to different user and group ranges within your containers.

The best way to prevent privilege-escalation attacks from within a container is to configure your container’s applications to run as unprivileged users.
For containers whose processes must run as the root user within the container, you can re-map this user to a less-privileged user on the Docker host.

The mapped user is assigned a range of UIDs which function within the namespace as normal UIDs from 0 to 65536, but have no privileges on the host machine itself.

Watch the video for a short demo on remapping an Nmap container process while still allowing Nmap to run as root inside the container
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/wMjHunoR0zQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



## Use Network Namespace

When containers are launched, a network interface is defined and  create. This gives the container a unique IP address and interface.

`docker run -it alpine ip addr show`{{execute}}

By changing the namespace to host, instead of the  container's network being isolated with its interface, the process will  have access to the host machines network interface.

`docker run -it --net=host alpine ip addr show`{{execute}}

If the process listens on ports, they'll be listened on the host interface and mapped to the container.

