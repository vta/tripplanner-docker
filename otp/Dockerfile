FROM ubuntu:14.04

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
RUN mkdir /srv/tripplanner/
RUN cd /srv/tripplanner/
RUN mkdir /srv/tripplanner/otp
RUN mkdir /srv/tripplanner/otp/ned
RUN cd /srv/tripplanner/otp
RUN curl -L http://maven.conveyal.com.s3.amazonaws.com/org/opentripplanner/otp/0.20.0/otp-0.20.0-shaded.jar > /srv/tripplanner/otp/otp-0.20.0-shaded.jar
ADD otp/otp.sh /srv/tripplanner/otp/otp.sh
RUN chmod +x /srv/tripplanner/otp/otp.sh

# Install Pyhton environment
RUN apt-get -q update
RUN apt-get install -y python-pip
RUN pip install transitfeed

# Install GTFS manager
RUN cd /srv/tripplanner/
RUN git clone https://github.com/amigocloud/gtfs-manager.git /srv/tripplanner/gtfs-manager
ADD load_data.sh /srv/tripplanner/load_data.sh
RUN chmod +x /srv/tripplanner/load_data.sh
RUN mkdir /srv/tripplanner/data
RUN mkdir /srv/tripplanner/data_tmp

# Add cron job to update OSM and GTFS data
RUN echo "30 13   * * *   root    /srv/tripplanner/load_data.sh" >> /etc/crontab

EXPOSE 22

ADD docker-startup.sh /
CMD ["/docker-startup.sh"]
