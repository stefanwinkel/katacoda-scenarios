
In this scenario you will learn the foundations of CGroups (Control Groups) and Namespces to apply security restrictions to containers.

Docker Images share the underlaying (Host) Kernel
Hence it is important to make sure that a Docker Image
cannot exhaust all the system resources

In this overview we will take a look how a Docker Image
can limit the amount of resources it uses through a concept
called Control Groups (cGroups)

Below are some examples of the types of cgroups and namespaces that exist.

### CGroups Examples
-   --cpu-shares
-  --cpuset-cpus
-  --memory-reservation
-  --kernel-memory
-  --blkio-weight (block IO)
-  --device-read-iops
-  --device-write-iops

### Namespace Examples
- Cgroup      CLONE_NEWCGROUP   Cgroup root directory
- IPC         CLONE_NEWIPC      System V IPC, POSIX message queues
- Network     CLONE_NEWNET      Network devices, stacks, ports, etc.
- Mount       CLONE_NEWNS       Mount points
- PID         CLONE_NEWPID      Process IDs
- User        CLONE_NEWUSER     User and group IDs
- UTS         CLONE_NEWUTS      Hostname and NIS domain name


