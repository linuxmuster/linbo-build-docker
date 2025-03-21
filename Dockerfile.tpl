# linbo-build-docker
# Dockerfile for creation of a linbo build environment docker image
#
# thomas@linuxmuster.net
# 20240313
#

FROM ubuntu:24.04

ENV MY_USER=linbo
ENV MY_UID=1000
ENV MY_GID=1000

COPY control /tmp/control
COPY ubuntu.sources /tmp/ubuntu.sources

RUN cat /tmp/ubuntu.sources >> /etc/apt/sources.list.d/ubuntu.sources

RUN apt-get update && apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -o "Dpkg::Options::=--force-confold" -y install bash bash-completion ccache curl dpkg-dev debdelta sudo vim
RUN DEBIAN_FRONTEND=noninteractive apt-get -o "Dpkg::Options::=--force-confold" -y install $(cat /tmp/control | sed -n '/Build-Depends:/,/Package:/p' | grep -v ^Package | sed -e 's|^Build-Depends: ||' | sed -e 's|,||g') && rm -rf /var/lib/apt/lists/* /tmp/control

RUN userdel -f ubuntu || true
RUN groupdel -f ubuntu || true
RUN groupadd -g ${MY_GID} ${MY_USER}
RUN useradd -s /bin/bash -c 'linbo build user' -d /home/${MY_USER} -M -u ${MY_UID} -g ${MY_USER} -G sudo ${MY_USER}
RUN echo "${MY_USER} ALL=NOPASSWD: ALL" > /etc/sudoers.d/${MY_USER}
RUN chmod 400 /etc/sudoers.d/${MY_USER}

ENTRYPOINT ["/bin/bash"]
