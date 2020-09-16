<img align="right" src="./assets/docker_defense_pic_v1.jpg" width="300">

Processing time is just as scarce as memory, but the effect of starvation is performance degradation instead of failure. A paused process that is waiting for time on the CPU is still working correctly. But a slow process may be worse than a failing one if it’s running an important latency-sensitive data-processing program, a revenue-generating web application, or a backend service for your app. Docker lets you limit a container’s CPU resources in two ways.

## Attack use case
Without these limits, an adversary could use performance degradation for CryptoCurrency mining, your containers would still be able to run, but the attacker is using all/most of CPU time for example for Bitcoin mining through a rogue container.

## Slice vs Quota CPU limits
1) The cpu-shares option allows you to specify the relative share of cpu a container will receive when there is contention for cpu.
2) You can also configure absolute cpu quotas by using the --cpus option. This cpu quota specifies the fixed share of cpu that the container is entitled may use before it is throttled.

Below is an example of starting a container with different shares. The --cpu-shares parameter defines a share between 0-768.
Assuming the total amount of memory is 1 Gb we can split it up 75 vs 25 % by specifing shares of resp 768 and 256 (sum=1024)

If a container defines a share of 768, while another defines a share  of 256, the first container will have 75% share with the other having  25% of the available share total. These numbers are due to the weighting  approach for CPU sharing instead of a fixed capacity.
Below the first container will be allowed to have 75% of the share. The second container will be limited to 25%.

`docker run -d --name c768 --cpuset-cpus 0 --cpu-shares 768 benhall/stress`{{command}}
`docker run -d --name c256 --cpuset-cpus 0 --cpu-shares 256 benhall/stress`{{command}}

We can verify the memory limits allocation with the docker stats command:

`docker stats --no-stream`{{command}}

## Important
It's important to note that a process can have 100% of the share, no matter defined weight, if no other processes is running.

## Consideration
One of the places CPU shares breaks down is when you don’t want  a container to be able to burst above its share when there is no contention on the host
