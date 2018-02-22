FROM ubuntu:16.04

ENV TERM xterm

# Install SSH server, curl
RUN apt-get update --fix-missing
RUN apt-get install -y openssh-server git curl python-pip time ntp supervisor inotify-tools telnet net-tools vim rsync logrotate && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir /var/run/sshd

# Install Apache with modules then clear apt source.lists
RUN apt-get update && apt-get install -y software-properties-common && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN apt-get update && apt-get install -y libapache2-mod-security2 libapache2-mod-geoip apache2-suexec-pristine apache2 apache2-bin apache2-data && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add certs
# @todo - make this private and remove from cached git repo
ADD ssl/AddTrustExternalCARoot.crt /etc/apache2/ssl/AddTrustExternalCARoot.crt
ADD ssl/chained_star.vta.org.crt /etc/apache2/ssl/chained_star.vta.org.crt
ADD ssl/key.pem /etc/apache2/ssl/key.pem
ADD ssl/NetworkSolutions_CA.crt /etc/apache2/ssl/NetworkSolutions_CA.crt
ADD ssl/server.key /etc/apache2/ssl/server.key
ADD ssl/STAR.VTA.ORG.crt /etc/apache2/ssl/STAR.VTA.ORG.crt
ADD ssl/UTNAddTrustServer_CA.crt /etc/apache2/ssl/UTNAddTrustServer_CA.crt
RUN chmod 0600 /etc/apache2/ssl/*

# Enable Apache modules
RUN a2enmod proxy proxy_http alias rewrite suexec ssl

# Enable and Disable desired site confs
RUN a2dissite default-ssl
ADD sites-available/opentripplanner.conf /etc/apache2/sites-available/opentripplanner.conf
RUN a2ensite opentripplanner
RUN rm /etc/apache2/sites-available/000-default.conf
ADD sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

# Add robots.txt
ADD robots.txt /var/www/html/robots.txt

# Set directory permissions to non-priviledged for SuExecUserGroup directive
RUN chown www-data:www-data /var/www/html -R

EXPOSE 22

ADD docker-startup.sh /
CMD ["/docker-startup.sh"]
