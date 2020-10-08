
<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">

For this scenario, Katacoda will start a fresh Kubernetes cluster for you.

We will see how Nginx is running on Kubernetes and how Containers are easily deployed as Deployments in Pods as well as how deployments can be easily scaled the number of replicas

With our deployment running we can now use kubectl to scale the number of replicas.

Scaling the deployment will request Kubernetes to launch additional Pods. These Pods will then automatically be load balanced using the exposed Service.

