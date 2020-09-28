# Default Kernel Capabilities Docker Container
Docker drops most of the capabilities for the containers process.
Here are the defaults capabilities: https://github.com/moby/moby/blob/master/oci/caps/defaults.go

## Do not use the privilege flag unless absolutely necessary

### Start a webserver and use getpcaps to list the capabilities
```
docker container run --name web -p 80:80
pid=\`ps -ef |grep "httpd" | tail -1 | awk '{print $2}'\`
getpcaps $pid
```{{execute}}

### Same but now with the privileged flag set and notice all the unnecessary capabilities
```
docker container run --name web2 -p 80:80
pid=\`ps -ef |grep "httpd2" | tail -1 | awk '{print $2}'\`
getpcaps $pid
```{{execute}}


## Whitelist Capabilities & SystemCalls

### Fine grained ACLs -Drop all Kernel Capabilities and add back
`docker container run -d --cap-drop=all --cap-add=net_bind_service --name web3 -p 80:80 httpd`{{execute}}
`pd=\`ps -fC httpd | tail -1 | awk '{print $2}'\`&& getpcaps $pd`{{execute}}

### Limit System Calls
Kernel is shared, container should not be able to call system calls out of the host
seccomp is a kernel feature that determines allows or disallows process to allow system calls
Docker uses default profile

#### only allows systems calls for our application and block all
`docker container run --security-opt  seccomp=/path/to/seccomp/profile.json myapp`{{execute}}

#### Tool to pipe output of strace and auto generate docker seccomp profile
# to whitelist syscalls needed only
https://github.com/blacktop/seccomp-gen

##### Mandatory access control - AppArmor & SELinux Profiles
https://github.com/genuinetools/bane

# Install Bane
`
# Export the sha256sum for verification. # Download and check the sha256sum.
`export BANE_SHA256="69df3447cc79b028d4a435e151428bd85a816b3e26199cd010c74b7a17807a05"
curl -fSL "https://github.com/genuinetools/bane/releases/download/v0.4.4/bane-linux-amd64" -o "/usr/local/bin/bane" \
	&& echo "${BANE_SHA256}  /usr/local/bin/bane" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/bane"
echo "bane installed!"
`{{execute}}

# Execute bane on sample.toml
## sample.toml is a AppArmor sample config for nginx in a container.
`sudo bane sample.toml`{{execute}}
`sudo apparmor_parser -r -W /path/to/your/apparmor-nginx-profile`{{execute}
`docker run -d --security-opt  "apparmor=apparmor-profile-name" -p 80:80 nginx`{{execute}}
`sudo apparmor_parser -r -W ./apparmor-nginx-profile`{{execute}}

# Run nginx
`docker container run -d --security-opt "apparmor=apparmor-nginx" -p 80:80 --name nginx nginx`{{execute}}

# Malicious activity
`docker container exec -it nginx /bin/bash`{{execute}}
touch ~/hello

