<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">
In this scenario we will see how we can protect/hardening the Docker Runtime by using Cgroups and Namespaces to limit host resources. Each step will help you understand how to protect your containers better against potential malicious behaviour from adversaries.

You will learn how:

- How to set memory limits on containers
- How to limit/slice CPU usage
- How to isolate and share network
- How to map user/group IDs in use the PID Namespace
- How to isolate and share Namespaces

This help by protecting against:

- Resource starvation
- Denial of Service (DoS) attacks
- Privilege escalation
- CryptoCurrency mining attacks

> [Docker](https://www.docker.com) is multi-paradigm platform/tool designed to make it easier to create, deploy and run applications by running containers. Containers allow a developer to package up an application with all of the parts it needs, such as libraries and other dependencies, and deploy it as one package . -[opensource.com > resources > what-docker](https://opensource.com/resources/what-docker))

