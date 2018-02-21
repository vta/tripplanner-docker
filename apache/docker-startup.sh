#!/bin/bash

set -exu

service apache2 start

# start the ssh daemon
/usr/sbin/sshd -D
