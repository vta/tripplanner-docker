# Open Trip Planner via Docker

A Docker container version of the Open Trip Planner suitable for use with an AWS EC2 medium instance.

# Docker-Compose
We built OTP using docker, but most importantly docker-compose. This allows us to set our predefined
environment, and allows us to connect multiple containers together rather than stacking everything in the same container.

## Building each service separately and pushing to Docker hub
In order to get your own images which are ready to be pulled via Docker Hub, You must first build each service
within the docker-compose.yml file and push each one separately. This will allow you to pull the built images from
your server rather than having to build it every time you want to deploy it to another server.
In doing this, it also allows you to build images on your localhost where the hardware may be better and the build times will be less.

### Clone this repo
First things first, We have to clone this repo and than CD into it; You want to be in the home directory which is where the `docker-compose.yml` file is located.

You might want to checkout the customization section before this step as you will most certainly have to insert your own config files and SSL certificates.
Using this repo as an example; as of this moment, we have two containers which are to be built to deploy OTP:

1. OTP
2. Apache

First we will build otp, To do this we will enter the command: 

`docker-compose build --no-cache otp`

Once otp is fully built, we can push it to our docker hub for pulling later, To do this using scvta as an example, enter the following command:

`docker-compose push scvta/otp`

Now we repeat the same for apache:

```
    docker-compose build --no-cache apache
    docker-compose push scvta/otp-apache
```

Now that both the OTP and Apache service are built and pushed to the hub, We can move onto the next step which is deploying to our live server.

## Installation via docker-compose pull (Recommended)
Building OTP every time you plan on deploying it is a very bad idea. Not only does it take up your resources; It takes up your time.
The purpose of docker-compose pull is that it reads your docker-compose.yml file and pulls the images that are already built. This is extremely recommended when in production environments.
The only time you should ever be building an image or container is during development or right before you push it to the docker hub.

Example of a docker-compose.yml file which pulls images from a docker repo:

   ```
        otp:
            build: ./otp
            image: scvta/otp <-- The image should be a duplicate of your repo such as username/repo_name
            restart: always
        apache:
            build: ./apache
            image: scvta/otp-apache <-- searches docker hub for the scvta/otp-apache repository 
   
   ```
   
When using `docker-compose build`, It should also tag the built container with the name of the image parameter defined to the service in the `docker-compose.yml` file.

So in order to deploy the OTP and Apache containers composed together, first connect to the instance you wish to deploy; Also make sure you are authorized to pull from the targeted Docker repo, and enter the following commands:

```
    1. git clone this repo and cd into the root of it (docker-compose.yml should be visible & custom config files added)
    2. docker-compose pull  < - - this will download the built images from Docker hub
    3. docker-compose up    < - - this will deploy the built containers to the ports specified in the docker-compose.yml file.
```
After some time of downloading the shaded JAR files OTP should launch and be hosted on the instance.

## Deployment via docker-compose build
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

