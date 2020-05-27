# ----------------------------------
# Thanks to Mason Rowe (mason@rowe.sh) for creating the base
# Environment: Ubuntu:18.04 + Wine + Xvfb
# Minimum Panel Version: 0.7.9
# ----------------------------------
FROM        ubuntu:18.04

LABEL       author="David Haßhoff" maintainer="d.hasshoff97@gmail.com"

ENV         DEBIAN_FRONTEND noninteractive

# Install Dependencies
RUN dpkg --add-architecture i386

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y apt-utils

RUN apt-get install -y ca-certificates
RUN apt-get install -y xvfb
RUN apt-get install -y lib32gcc1
RUN apt-get install -y libntlm0
RUN apt-get install -y winbind
RUN apt-get install -y --no-install-recommends wine32 # wine64

RUN apt-get clean
RUN apt-get autoremove -y

RUN useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container WINEARCH=win32 WINEPREFIX=/home/container/.wine
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
