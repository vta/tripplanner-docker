#!/bin/bash

set -exu

# Start OTP
service ntp start
service cron start
service supervisor start
# Load OSM and GTFS data and Supervisord will start when it's done building Graph.obj
/srv/tripplanner/gtfs-manager/gtfs-loader.sh

/usr/bin/supervisorctl restart vta:vta_otp_monitor


# start the ssh daemon
/usr/sbin/sshd -D
