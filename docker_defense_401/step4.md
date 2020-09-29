Default Kernel Capabilities Docker Container

Docker drops most of the capabilities for the containers process.
Here are the defaults capabilities: https://github.com/moby/moby/blob/master/oci/caps/defaults.go

### Do not use the privilege flag unless absolutely necessary (Dont's: #5)

Start a webserver and use getpcaps to list the capabilities

```
docker container run --name web -p 80:80 httpd
pid=`ps -ef |grep "httpd" | tail -1 | awk '{print $2}'`
getpcaps $pid
```{{execute}}

### Same but now with the privileged flag set and notice all the unnecessary capabilities
```
docker container run --name web2 -p 80:80 httpd
pid=`ps -ef |grep "httpd2" | tail -1 | awk '{print $2}'
getpcaps $pid
```{{execute}}


### Whitelist Capabilities & SystemCalls (DO's, item #3, #4)

Fine grained ACLs -Drop all Kernel Capabilities and add back
```
docker container run -d --cap-drop=all --cap-add=net_bind_service --name web3 -p 80:80 httpd
pd=`ps -fC httpd | tail -1 | awk '{print $2}'
getpcaps $pd`
```{{execute}}

#### Limit System Calls

Since the Kernel is shared, container(s) should not be able to call random system calls out of the host. seccomp is a kernel feature that determines allows or disallows process to allow system calls. Docker uses default profile

Only allows systems calls for our application and block all

`docker container run --security-opt  seccomp=/path/to/seccomp/profile.json myapp`{{execute}}

#### Autogenerate AppArmor Profile with Bane

Install Bane `/usr/local/bin/install_bane.sh`{{execute}}.
If you are curious, view the installation script `cat /usr/local/bin/install_bane.sh`{{execute}}

Execute Bane and auto generate Nginx AppArmor Profile

```
bane sample.toml
apparmor_parser -r -W /path/to/your/apparmor-nginx-profile
docker run -d --security-opt  "apparmor=apparmor-profile-name" -p 80:80 nginx
sudo apparmor_parser -r -W ./apparmor-nginx-profile
```{{execute}}

Run nginx

`docker container run -d --security-opt "apparmor=apparmor-nginx" -p 80:80 --name nginx nginx`{{execute}}

Malicious activity

`docker container exec -it nginx /bin/bash`{{execute}}
touch ~/hello


#### References
Mandatory access control - AppArmor & SELinux Profiles: https://github.com/genuinetools/bane

Tool to pipe output of strace and auto generate docker seccomp profile to whitelist syscalls needed only
https://github.com/blacktop/seccomp-gen
