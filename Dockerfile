# linbo-build-docker
# Dockerfile for creation of a linbo build environment docker image
#
# thomas@linuxmuster.net
# 20210511
#

FROM ubuntu:18.04
MAINTAINER thomas@linuxmuster.net

ENV CONTROL_URL https://raw.githubusercontent.com/linuxmuster/linuxmuster-linbo7/main/debian/control
ENV MY_USER linbo
ENV MY_UID 1000

RUN apt-get update
RUN apt-get -y install bash bash-completion ccache curl dpkg-dev sudo
RUN apt-get -y install $(curl -s ${CONTROL_URL} | sed -n '/Build-Depends:/,/Package:/p' | grep -v ^Package | sed -e 's|^Build-Depends: ||' | sed -e 's|,||g') && rm -rf /var/lib/apt/lists/*

RUN useradd -s /bin/bash -c 'linbo build user' -d /home/${MY_USER} -M -u ${MY_UID} -G sudo ${MY_USER}
RUN echo "${MY_USER} ALL=NOPASSWD: ALL" > /etc/sudoers.d/${MY_USER}
RUN chmod 400 /etc/sudoers.d/${MY_USER}

VOLUME ["/home/${MY_USER}"]

ENTRYPOINT ["/bin/bash"]