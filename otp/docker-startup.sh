#!/bin/bash

set -exu

# start docker
#/etc/init.d/docker start

# Load OSM and GTFS data
/srv/tripplanner/gtfs-manager/gtfs-loader.sh

# Start OTP
#/srv/tripplanner/otp/otp.sh
/usr/bin/supervisorctl restart vta:vta_otp

# start the ssh daemon
/usr/sbin/sshd -D
