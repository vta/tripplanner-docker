FROM ubuntu:16.04

ENV TERM xterm

# Install SSH server, Node.JS, MongoDB
RUN apt-get update --fix-missing
RUN apt-get install -y openssh-server build-essential curl
RUN cd ~
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
RUN /bin/bash nodesource_setup.sh
RUN apt-get update
RUN apt-get install -y git nodejs mongodb
RUN mkdir /var/run/sshd

# Install modified-tripplanner
RUN mkdir /srv/vta.amigocloud.com/
RUN cd /srv/vta.amigocloud.com/
#RUN git clone https://github.com/amigocloud/modified-tripplanner.git /opt/modified-tripplanner
RUN git clone https://github.com/vta/modeify.git /srv/vta.amigocloud.com/modeify
RUN cd /srv/vta.amigocloud.com/modeify && git checkout -b deployment tags/2.2
ADD config.yaml /srv/vta.amigocloud.com/modeify/deployment/config.yaml

EXPOSE 22

ADD docker-startup.sh /
CMD ["/docker-startup.sh"]
