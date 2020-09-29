
Docker drops most of the capabilities for the containers process.
Here are the default Kernel capabilities for  a Docker Container: https://github.com/moby/moby/blob/master/oci/caps/defaults.go

### Avoid --privilege flag unless absolutely necessary (Dont's: #5)

Start a webserver and use getpcaps to list the capabilities

```
docker container run -d --name web1 -p 81:80 httpd
pd=`ps -fC httpd | tail -1 | awk '{print $2}'`
getpcaps $pid
```{{execute}}

To compare we use the --privilege flag. Inspect how many unnecessary capabilities are now running !
```
docker container run -d --name web2 --privilege -p 82:80 httpd
pd=`ps -fC httpd | tail -1 | awk '{print $2}'`
getpcaps $pid
```{{execute}}


### Whitelist Capabilities & SystemCalls (DO's, item #3, #4)

To reduce the attack surface we will drop all Kernel Permissions with --cap-drop and only add back the ones we need (whitelisting)
```
docker container run -d --cap-drop=all --cap-add=net_bind_service --name web3 -p 83:80 httpd
pd=`ps -fC httpd | tail -1 | awk '{print $2}'`
getpcaps $pd
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
docker run -d --security-opt  "apparmor=apparmor-profile-name" -p 84:80 nginx
sudo apparmor_parser -r -W ./apparmor-nginx-profile
```{{execute}}

Run nginx

`docker container run -d --security-opt "apparmor=apparmor-nginx" -p 85:80 --name nginx nginx`{{execute}}

Malicious activity

`docker container exec -it nginx /bin/bash`{{execute}}
touch ~/hello


#### References
Mandatory access control - AppArmor & SELinux Profiles: https://github.com/genuinetools/bane

Tool to pipe output of strace and auto generate docker seccomp profile to whitelist syscalls needed only
https://github.com/blacktop/seccomp-gen
