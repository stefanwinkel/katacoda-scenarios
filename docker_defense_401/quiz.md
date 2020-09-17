In many instances Docker containers are running with permissions set too wide, allowing for fairly easy exploitation through for Priv Escalation, DoS and resource exhaustion attacks often seen with CrypoCurrency attacks. To constrain and limit use of host resources, users can customize the Docker runtime by use of Cgroups and Namespaces Linux kernel features

## 401 Container Defense - Docker Runtime Protection Quiz

What is command flag to limit the amount of memory a container can use to  150 ?

>>Q1: Enter just the command option (just enter option itself (not abbrevation and not the full command). Example --limit 250g)<<
=== --memory 150m

>>Q2: What is the name of the Linux feature that limits the amount of resources a process can use ? <<
=~= cgroups

>>Q3: To avoid resource starvation a user can run use the --cpus option to specify a fixed cpu quota when starting a container   <<
(*) Correct
( ) Incorrect

>>Q4: Protecting the Docker Runtime does not apply to Docker Image Developers but only to Operators and other personel running Containers <<
(*) Incorrect
( ) Correct

>>Q5: To avoid privilege escalation attacks, a user can  <<
[ ] Use the --no_priv flag when starting the Docker Daemon
[*] Remap UserID defined by the  USER namespace
[ ] Set the --cpuset flag to 0
[ ] Run the container as root

## Correct and Incorrect Ansers

When a user clicks **Check Answers**, the correct answers will appear with a Green tick! If a user has entered anything incorrect he/she will be asked to check and try again.
