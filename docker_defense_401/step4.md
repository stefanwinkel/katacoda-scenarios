
Docker drops most of the capabilities for the containers process.
Here are the default Kernel capabilities for  a Docker Container: https://github.com/moby/moby/blob/master/oci/caps/defaults.go

### Avoid --privilege flag unless absolutely necessary (Dont's: #5)

Start a webserver and use getpcaps to list the capabilities

```
docker container run -d --name web1 -p 81:80 httpd
pid=`ps -fC httpd | tail -1 | awk '{print $2}'`
getpcaps $pid
```{{execute}}

To compare we use the --privileged flag. Inspect how many unnecessary capabilities are now running !
```
docker container run -d --name web2 --privileged -p 82:80 httpd
pid=`ps -fC httpd | tail -1 | awk '{print $2}'`
getpcaps $pid
```{{execute}}


### Whitelist Capabilities & SystemCalls (DO's, item #3, #4)

To reduce the attack surface we will drop all Kernel Permissions with --cap-drop and only add back the ones we need (whitelisting)
```
docker container run -d --cap-drop=all --cap-add=net_bind_service --name web3 -p 83:80 httpd
pid=`ps -fC httpd | tail -1 | awk '{print $2}'`
getpcaps $pid
```{{execute}}

#### Limit System Calls (Dont's : #9) - Autogenerate SysCall whitelists

Since the Kernel is shared, container(s) should not be able to call random system calls out of the host.

seccomp is a kernel feature that determines allows or disallows process to allow system calls. Docker uses default profile which we can easily customize to constraint it further. We should customize to  only allows systems calls for our application and block all others. We can generate automatically a list of system calls from strace and then use the OpenSource tool seccomp-gen to automatically generate a custom seccomp profile. This adds a LOT of security by drastically limiting your attack surface to only what is needed.

https://github.com/blacktop/seccomp-gen

We then could run our App Docker Container something like: docker container run --security-opt no-new-privileges --security-opt seccomp=/usr/local/seccomp/profile1_seccomp.json image_tag.Let's see how something similar will work for AppArmor

#### Autogenerate WhiteListed AppArmor Profile with Bane (DO's: #3, #6)

Install Bane `/usr/local/bin/scripts/install_bane.sh`{{execute}}.

If you are curious, view the installation script `cat /usr/local/bin/scripts/install_bane.sh`{{execute}}

Execute Bane, automatically generate a Nginx profile based upon our configuration and check the profile for issues:

```
mkdir -p /etc/apparmor.d/containers
bane /root/sample/bane/sample.toml
apparmor_parser -r -W /etc/apparmor.d/containers/docker-nginx-sample
```{{execute}}

Start the container with the generated profile and launch a shell:

`docker run --security-opt="apparmor:docker-nginx-sample" -p 84:80 --rm -it nginx bash`{{execute}}

Now, when we try to perform a malicious operation, like touching a file, we notice that the operation is blocked by our AppArmor profile:

`touch ~/hello || exit `{{execute}}

Let's cleanup

This is the end of this demo. You can now stop/remove all containers by running:
`/usr/local/bin/scripts/kill_dockers.sh`{{execute}}


#### References

- Tool for autogenerate AppArmor Profiles: https://github.com/genuinetools/bane
- Tool for autogenerate SecComp Profiles: https://github.com/blacktop/seccomp-gen
