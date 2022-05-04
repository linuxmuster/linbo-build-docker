#!/bin/sh
#
# create docker image
#
# thomas@linuxmuster.net
# 20220426
#

MY_NAME="linbo-build-docker-1804"
MY_UID="$(id -u)"
MY_GID="$(id -g)"

if [ "$MY_UID" = "O" ]; then
  echo "Run this script as an unprivileged user not as root! The user has to be member of the group \"docker\"."
  exit 1
fi

if ! id | grep -qw docker; then
  echo "User $USER has to be member of the group docker!"
  exit 1
fi

# sets uid/gid in Dockerfile
sed -e "s|^ENV MY_UID .*|ENV MY_UID $MY_UID|
        s|^ENV MY_GID .*|ENV MY_GID $MY_GID|" Dockerfile.tpl > Dockerfile

# provide control file from linbo src tree
cp ./linbo/linuxmuster-linbo7/debian/control . || exit 1

# start build
docker build -t "$MY_NAME" .

# remove control file again
rm -f control
