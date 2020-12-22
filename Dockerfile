# base image
FROM ubuntu:16.04

MAINTAINER Maksim Perov

ARG HASH=1qUSJKHiH5JVJAW7r2VbtKM4ispbQRLk-

# installing
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y sudo libfdt1 openjdk-8-jdk && \
  apt-get install -y wget && \
  rm -rf /var/lib/apt/lists/* && \
  export CONFIRM=`wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$HASH" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p'` && \
  wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$CONFIRM&id=$HASH" -O /root/risc-v_toolchain_installer.sh && \ 
  rm -rf /tmp/cookies.txt && \
  chmod +x /root/risc-v_toolchain_installer.sh && \
  /root/risc-v_toolchain_installer.sh

# environment variables
ENV HOME /root

# working directory
WORKDIR /root

# default command
CMD ["bash"]
