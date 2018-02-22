FROM ubuntu:16.04

ENV TERM xterm

# Install SSH server, curl
RUN apt-get update --fix-missing
RUN apt-get install -y openssh-server git curl python-pip time ntp supervisor inotify-tools telnet net-tools vim rsync logrotate && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir /var/run/sshd

# Install software-common-properties
RUN apt-get update && apt-get install -y software-properties-common && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Java8
RUN apt-get update && apt-get install -y software-properties-common && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN add-apt-repository -y ppa:webupd8team/java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update && apt-get install -y oracle-java8-installer && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Make directories
RUN mkdir -p /srv/tripplanner/logs
RUN mkdir -p /srv/tripplanner/data/graphs/default
RUN mkdir -p /srv/tripplanner/data_tmp
RUN mkdir -p /srv/tripplanner/otp/ned

# Install Open Trip Planner
RUN cd /srv/tripplanner/otp
RUN curl -L https://repo1.maven.org/maven2/org/opentripplanner/otp/1.2.0/otp-1.2.0-shaded.jar > /srv/tripplanner/otp/otp-1.2.0-shaded.jar
ADD otp/otp.sh /srv/tripplanner/otp/otp.sh
RUN chmod +x /srv/tripplanner/otp/otp.sh
ADD otp/monitor_log.sh /srv/tripplanner/monitor_log.sh
RUN chmod +x /srv/tripplanner/monitor_log.sh

# Install Pyhton environment
RUN pip install transitfeed

# Install GTFS manager
RUN git clone https://github.com/vta/gtfs-manager.git /srv/tripplanner/gtfs-manager
RUN cd /srv/tripplanner/gtfs-manager && git checkout http_errors-#1
RUN chmod +x /srv/tripplanner/gtfs-manager/gtfs-loader.sh

# Download VTA config.json
# @todo - make this private using Docker .env files and remove from repo
RUN curl -L https://devplanner.vta.org/notify.json > /srv/tripplanner/gtfs-manager/src/gtfs-manager/config.json

# Configure Supervisord
RUN rm /etc/supervisor/supervisord.conf
ADD etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD etc/supervisor/conf.d/opentripplanner.conf /etc/supervisor/conf.d/opentripplanner.conf

# Set directory perms
RUN chown www-data:www-data /srv/tripplanner -R

# Add cron job to update OSM and GTFS data
RUN echo "00 2    * * *   ubuntu	/bin/bash /srv/tripplanner/gtfs-manager/gtfs-loader.sh" >> /etc/crontab
#RUN echo "30 13   * * *   root    /srv/tripplanner/load_data.sh" >> /etc/crontab

EXPOSE 22 8888 8081

ADD docker-startup.sh /
CMD ["/docker-startup.sh"]
