FROM ubuntu:16.04

ENV TERM xterm

# Install SSH server, curl
RUN apt-get update --fix-missing
RUN apt-get install -y openssh-server git curl python-pip time ntp supervisor inotify-tools
RUN mkdir /var/run/sshd

RUN apt-get -y install libapache2-mod-security2 libapache2-mod-geoip apache2-suexec-pristine apache2 apache2-bin apache2-data
RUN a2enmod proxy proxy_http alias rewrite suexec
RUN a2dissite default-ssl
ADD sites-available/opentripplanner.conf /etc/apache2/sites-available/opentripplanner.conf
RUN a2ensite opentripplanner
RUN rm /etc/apache2/sites-available/000-default.conf
ADD sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite opentripplanner

ADD ssl/vta-ssl.tar.gz /etc/apache2/vta-ssl.tar.gz
ADD robots.txt /srv/tripplanner/robots.txt

RUN cd /etc/apache2
RUN tar -xvzf vta-ssl.tar.gz
RUN chmod 600 ssl/*
RUN chown www-data:www-data /srv/tripplanner -R

EXPOSE 22

ADD docker-startup.sh /
CMD ["/docker-startup.sh"]
