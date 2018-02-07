FROM ubuntu:16.04

ENV TERM xterm

# Install SSH server, Node.JS, MongoDB
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update --fix-missing
RUN apt-get install -y openssh-server build-essential curl software-properties-common apt-utils python-software-properties language-pack-en-base
RUN locale-gen en_US.UTF-8
RUN export LANG=en_US.UTF-8
RUN export LC_ALL=en_US.UTF-8
RUN cd ~
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
RUN /bin/bash nodesource_setup.sh
RUN apt-get update
RUN apt-get install -y git nodejs mongodb
RUN mkdir /var/run/sshd

# Install modified-tripplanner
RUN mkdir /srv/tripplanner/
RUN cd /srv/tripplanner/
#RUN git clone https://github.com/amigocloud/modified-tripplanner.git /opt/modified-tripplanner
RUN git clone https://github.com/vta/modeify.git /srv/tripplanner/modeify
RUN cd /srv/tripplanner/modeify && git checkout -b deployment tags/2.2
ADD config.yaml /srv/tripplanner/modeify/deployment/config.yaml

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-mark hold php7.2*
RUN apt-get install -y php7.1-fpm php7.1-cgi php7.1-cli php7.1-curl php-pear
RUN apt-get install -y php-imagick
RUN pear install Mail_Mime Mail

EXPOSE 22

ADD docker-startup.sh /
CMD ["/docker-startup.sh"]
