#!/bin/bash

set -exu

# start docker
#/etc/init.d/docker start

# Run modified-tripplanner node.js
#cp -rf /opt/modified-tripplanner /srv/tripplanner/
cd /srv/tripplanner/modeify
npm cache clean
npm install
make install
make build-client
npm start

# start the ssh daemon
/usr/sbin/sshd -D
