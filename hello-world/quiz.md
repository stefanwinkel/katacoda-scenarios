Docker makes uses of CGroups and Namespaces to limit resources at runtime execution

## 401 Container Defense - Docker Runtime Protection Quiz

What is command flag to limit the amount of memory a container can use to  150 ?

>>Q1: Enter just the command option (just enter option itself (not abbrevation and not the full command). Example --limit 250g)<<
=== --memory 150m

>>Q2: What is the name of the Linux feature that limits the amount of resources a process can use ? <<
=~= cgroups

>>Q3: To avoid privilege escalation attacks, a user can  <<
[ ] Use the --no_priv flag when starting the Docker Daemon
[*] Remap UserID defined by the  USER namespace
[ ] Set the --cpuset flag to 0
[*] Run the container as root user

Q4 is a single choice where users must select the correct answer.

>>Q4: Protecting the Docker Runtime does not apply to Developers only to Operators running images <<
(*) Correct
( ) Incorrect

## Correct and Incorrect Ansers

When a user clicks **Check Answers**, the correct answers will appear with a Green tick! If they have entered anything incorrect they will be asked to check and try again.
