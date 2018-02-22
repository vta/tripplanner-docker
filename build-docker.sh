#!/bin/bash
docker system prune -a -f
docker-compose up --build | tee otp-docker-`date +"%F-%T"`.log
