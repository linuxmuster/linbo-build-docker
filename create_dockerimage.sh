#!/bin/sh
#
# create docker image
#
# thomas@linuxmuster.net
# 20210511
#

MY_NAME="linbo-build-docker"
MY_UID="$(id -u)"
MY_GID="$(id -g)"

# sets uid/gid in Dockerfile
sed -i "s|^ENV MY_UID .*|ENV MY_UID $MY_UID|" Dockerfile
sed -i "s|^ENV MY_GID .*|ENV MY_GID $MY_GID|" Dockerfile

# start build
docker build -t "$MY_NAME" .
