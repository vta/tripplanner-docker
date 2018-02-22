# Open Trip Planner via Docker

A Docker container version of the Open Trip Planner suitable for use with an AWS EC2 medium instance.

## Installation

1. Create an AWS EC2 medium instance with Ubuntu 16.04 LTS, 4GB RAM, 2 VPUs and a 8GB swapfile.
2. Install docker-compose and docker
3. Execute the following command within the top level of the git clone

```/bin/bash
/usr/bin/time --verbose --output=build-time-`date +"%F-%T"`.log /bin/bash -x ./build-docker.sh
```

## Customization

Optionally you can edit the versions of OTP pre-built shaded jar to down, add your own organizations GTFS feeds using a similarly configured JSON config file.

By building a Docker container version we intend to enable other agencies to quickly spin up their own customized version of the Open Trip Planner with our GTFS Manager.

### Troubleshooting

If you run into problems, you can optional SSH into the container as root user and check log files, history, processes, etc.

```/bin/bash
docker exec -it tripplannerdocker_otp_1 /bin/bash
```

Additionally we've added standard Linux networking and file system utilities to the Docker containers to permit users to rsync, netstat, telnet, ping, etc... within the container itself or to a remote host or AWS S3 bit bucket to enable centralized logging.

