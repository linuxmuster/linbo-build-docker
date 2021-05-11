#!/bin/bash
#
# starts container in interactive mode
#
# thomas@linuxmuster.net
# 20210511
#

MY_DIR="$(pwd)"
MY_NAME="linbo-build-docker"
MY_UID="$(id -u)"
MY_GID="$(id -g)"
MY_USER="linbo"

docker run -it --rm --name "$MY_NAME" \
  -h "$MY_NAME" \
  -u "$MY_UID":"$MY_GID" \
  -v /etc/localtime:/etc/localtime:ro \
  -v "$MY_DIR"/"$MY_USER":/home/"$MY_USER" \
  -w /home/"$MY_USER" \
  "$MY_NAME"
