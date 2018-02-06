FROM ubuntu:16.04

ENV TERM xterm

# Install SSH server, Node.JS, MongoDB
RUN apt-get -q update
RUN apt-get install -y openssh-server build-essentials
RUN cd ~
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
RUN /bin/bash nodesource_setup.sh
RUN apt-get update
RUN apt-get install -y git nodejs mongodb
RUN mkdir /var/run/sshd

# Install modified-tripplanner
RUN mkdir /srv/tripplanner/
#RUN git clone https://github.com/amigocloud/modified-tripplanner.git /opt/modified-tripplanner
RUN git clone https://github.com/vta/modeify.git /srv/tripplanner/modeify
RUN cd /srv/tripplanner/modeify
RUN git checkout tags/2.2

ADD config.yaml /srv/tripplanner/modeify/deployment/config.yaml

EXPOSE 22

ADD docker-startup.sh /
CMD ["/docker-startup.sh"]
