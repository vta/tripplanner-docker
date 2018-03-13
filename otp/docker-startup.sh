#!/bin/bash

set -exu

# Start OTP
service ntp start
service cron start
service supervisor start

/usr/bin/supervisorctl restart vta:vta_otp_monitor

# start the ssh daemon
/usr/sbin/sshd -D
