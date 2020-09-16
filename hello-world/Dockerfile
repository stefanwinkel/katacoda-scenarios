FROM ubuntu:latest
RUN apt-get -y update &&  apt-get install -y stress 
CMD /usr/bin/stress -c 1 --timeout 60s
