
<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">

Containers are everwhere these days.

DevOps concepts like microsevices and Orchestration engines like Kubernetes and Docker Swarm have solved problems when it comes to installing and running containers but also introduced many complexities when it comes to protecting those Container images

In many instances Docker containers are running with permissions set too wide/open. Users sometimes think that because they are running things within a container or throwing the container quickly away they are safe from attackers. These incorrect assumptions lead to fairly easy exploitation through attacks like Priv Escalation, DoS and resource exhaustion for example often seen with crypocurrency (e.g Bitcoin) mining attacks.

Container just as many other aspects of the Security needs to be protected according the least privilege aspect in order to minimize the attack surface.

We will take look how easily Containers can be deployed with use of a Orchestration engine.

Then we will take a look at some notorious Docker exploit that have made the news over the last few months.

> [Docker](https://www.docker.com) is multi-paradigm platform/tool designed to make it easier to create, deploy and run applications by running containers. Containers allow a developer to package up an application with all of the parts it needs, such as libraries and other dependencies, and deploy it as one package . -[opensource.com > resources > what-docker](https://opensource.com/resources/what-docker))


