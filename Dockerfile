# ----------------------------------
# Thanks to Mason Rowe (mason@rowe.sh) for creating the base
# Environment: Ubuntu:20.04 + Wine + Xvfb
# Minimum Panel Version: 0.7.9
# ----------------------------------
FROM        ubuntu:20.04

LABEL       author="David Haßhoff" maintainer="d.hasshoff97@gmail.com"

ENV         DEBIAN_FRONTEND noninteractive

# Install Dependencies
RUN dpkg --add-architecture i386

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get update
RUN apt-get upgrade -y


RUN apt-get install -y ca-certificates wget gnupg2 software-properties-common winbind x11vnc

#WINE
RUN wget -O - https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
RUN add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
RUN apt-get update
RUN apt-get install -y --install-recommends winehq-stable

RUN apt-get install -y xvfb

RUN apt-get clean
RUN apt-get autoremove -y

RUN useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container WINEARCH=win32 WINEPREFIX=/home/container/.wine
WORKDIR     /home/container

EXPOSE 5920

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
