#!/bin/bash
#
# creates linbo build directory
# clones the linbo git repo
# builds the docker image
#
# thomas@linuxmuster.net
# 20210511
#

MY_PKG="linuxmuster-linbo7"
MY_REPO="https://github.com/linuxmuster/$MY_PKG.git"
MY_UID="$(id -u)"
MY_GID="$(id -g)"

# check prerequisites
if ! grep -q "$" Dockerfile; then
  echo "Dockerfile not found! "
  exit 1
fi
DOCKER="$(which docker)"
if [ -z "$DOCKER" ]; then
  echo "Docker is not installed!"
  exit 1
fi
GIT="$(which git)"
if [ -z "$GIT" ]; then
  echo "Git is not installed!"
  exit 1
fi

# create linbo build directory
mkdir -p linbo

# clone repo
cd linbo
if [ -d "$MY_PKG/debian" ]; then
  echo "Repo is already cloned."
elif [ -d "$MY_PKG" ];then
  echo "There is already a directory $MY_PKG!"
  exit 1
else
  git clone "$MY_REPO" || exit 1
fi
cd ..

# build docker image
./create_dockerimage.sh || exit 1
