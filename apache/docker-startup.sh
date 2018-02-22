#!/bin/bash

set -exu

service apache2 start
service ntp start
service cron start

# start the ssh daemon
/usr/sbin/sshd -D
