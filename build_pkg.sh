#!/bin/bash
#
# starts container and builds package
#
# thomas@linuxmuster.net
# 20220504
#

MY_DIR="$(pwd)"
MY_NAME="linbo-build-docker-2204"
MY_PKG="linuxmuster-linbo7"
MY_UID="$(id -u)"
MY_GID="$(id -g)"
MY_USER="linbo"

docker run -it --rm --name "$MY_NAME" \
  -h "$MY_NAME" \
  -u "$MY_UID":"$MY_GID" \
  -v /etc/localtime:/etc/localtime:ro \
  -v "$MY_DIR"/"$MY_USER":/home/"$MY_USER" \
  -w /home/"$MY_USER" \
  "$MY_NAME" /home/"$MY_USER"/"$MY_PKG"/buildpackage.sh
