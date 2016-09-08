FROM ubuntu:14.04

ENV TERM xterm

# Install SSH server, Node.JS, MongoDB
RUN apt-get -q update
RUN apt-get install -y openssh-server
RUN apt-get install -y git nodejs nodejs-legacy npm mongodb
RUN mkdir /var/run/sshd

# Install modified-tripplanner
RUN mkdir /srv/tripplanner/
RUN git clone https://github.com/amigocloud/modified-tripplanner.git /opt/modified-tripplanner

ADD config.yaml /srv/tripplanner/modified-tripplanner/deployment/config.yaml

EXPOSE 22

ADD docker-startup.sh /
CMD ["/docker-startup.sh"]
