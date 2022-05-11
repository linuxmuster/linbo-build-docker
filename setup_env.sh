#!/bin/bash
#
# creates linbo build directory
# clones the linbo git repo
# builds the docker image
#
# thomas@linuxmuster.net
# 20220511
#

MY_PKG="linuxmuster-linbo7"
MY_REPO="https://github.com/linuxmuster/$MY_PKG.git"

# check prerequisites
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

# switch to branch 18.04
git checkout 18.04 || exit 1

# create linbo build directory
mkdir -p linbo/.gnupg
chmod 700 linbo/.gnupg

# clone repo
cd linbo
if [ -d "$MY_PKG" ]; then
  cd "$MY_PKG"
  git pull || exit 1
  git checkout 4.0 || exit 1
  cd ..
else
  git clone "$MY_REPO" || exit 1
fi
cd ..

# build docker image
./create_dockerimage.sh || exit 1
