#!/bin/sh
#
# create docker image
#
# thomas@linuxmuster.net
# 20210511
#

MY_NAME="linbo-build-docker"
MY_UID="$(id -u)"

# sets uid in Dockerfile
sed -i "s|^ENV MY_UID .*|ENV MY_UID $MY_UID|" Dockerfile

# start build
docker build -t "$MY_NAME" .
