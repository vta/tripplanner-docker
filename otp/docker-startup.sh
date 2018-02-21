#!/bin/bash

set -exu

# start docker
#/etc/init.d/docker start

# Load OSM and GTFS data
/srv/tripplanner/gtfs-manager/gtfs-loader.sh

# Start OTP
#/srv/tripplanner/otp/otp.sh

# start the ssh daemon
/usr/sbin/sshd -D
