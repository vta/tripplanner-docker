FROM ubuntu:16.04

ENV TERM xterm

# Install SSH server, Node.JS, MongoDB
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update --fix-missing
RUN apt-get install --fix-missing -y openssh-server build-essential curl software-properties-common apt-utils python-software-properties language-pack-en-base
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
RUN mkdir /srv/tripplanner/modeify/deployment
ADD config.yaml /srv/tripplanner/modeify/deployment/config.yaml

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-mark hold php7.2*
RUN apt-get install -y apache2 apache2-suexec-pristine libapache2-mod-fastcgi libapache2-mod-security2 apache2-utils apache2-dev
ADD ssl.tgz /etc/apache2/ssl.tgz
RUN cd /etc/apache2 && tar -xvzf ssl.tgz && chmod 0600 /etc/apache2/ssl -R
RUN rm /etc/apache2/sites-available/000-defaults.conf
ADD modeify.conf /etc/apache2/sites-available/modeify.conf
ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2dissite default-ssl
RUN a2ensite modeify
RUN a2ensite 000-default
RUN a2dismod mpm_event mpm_worker
RUN a2enmod mpm_prefork proxy_fcgi proxy_http suexec alias vhost_alias
RUN apt-get install -y php7.1-fpm php7.1-cgi php7.1-cli php7.1-curl php-pear php7.1-xml
RUN apt-get install -y imagemagick php-imagick
RUN pear install Mail_Mime Mail

EXPOSE 22 80 443

ADD docker-startup.sh /
CMD ["/docker-startup.sh"]
