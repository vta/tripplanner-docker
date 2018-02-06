FROM ubuntu:16.04

ENV TERM xterm

# Install SSH server, curl
RUN apt-get -q update
RUN apt-get install -y openssh-server
RUN apt-get install -y git curl python-pip
RUN mkdir /var/run/sshd

# Install java8
RUN apt-get update && apt-get install -y software-properties-common && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN add-apt-repository -y ppa:webupd8team/java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update && apt-get install -y oracle-java8-installer && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Open Trip Planner
RUN mkdir /srv/vta.amigocloud.com/
RUN cd /srv/vta.amigocloud.com/
RUN mkdir /srv/vta.amigocloud.com/otp
RUN mkdir /srv/vta.amigocloud.com/otp/ned
RUN cd /srv/vta.amigocloud.com/otp
RUN curl -L https://repo1.maven.org/maven2/org/opentripplanner/otp/1.2.0/otp-1.2.0-shaded.jar > /srv/vta.amigocloud.com/otp/otp-1.2.0-shaded.jar
ADD otp/otp.sh /srv/vta.amigocloud.com/otp/otp.sh
RUN chmod +x /srv/vta.amigocloud.com/otp/otp.sh

# Install Pyhton environment
RUN apt-get -q update
RUN apt-get install -y python-pip
RUN pip install transitfeed

# Install GTFS manager
RUN cd /srv/vta.amigocloud.com/
RUN git clone https://github.com/vta/gtfs-manager.git /srv/vta.amigocloud.com/gtfs-manager
RUN cd /srv/vta.amigocloud.com/gtfs-manager
RUN "git checkout http_errors-#1"
#ADD load_data.sh /srv/vta.amigocloud.com/load_data.sh
#RUN chmod +x /srv/vta.amigocloud.com/load_data.sh
RUN chmod +x /srv/vta.amigocloud.com/gtfs-manager/gtfs-loader.sh
RUN mkdir /srv/vta.amigocloud.com/data
RUN mkdir /srv/vta.amigocloud.com/data_tmp

# Add cron job to update OSM and GTFS data
RUN echo "00 2    * * *   ubuntu	/bin/bash /srv/vta.amigocloud.com/gtfs-manager/gtfs-loader.sh" >> /etc/crontab
#RUN echo "30 13   * * *   root    /srv/vta.amigocloud.com/load_data.sh" >> /etc/crontab

EXPOSE 22 8888 8081

ADD docker-startup.sh /
CMD ["/docker-startup.sh"]
