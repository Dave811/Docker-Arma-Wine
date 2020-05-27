# ----------------------------------
# Thanks to Mason Rowe (mason@rowe.sh) for creating the base
# Environment: Ubuntu:18.04 + Wine + Xvfb
# Minimum Panel Version: 0.7.9
# ----------------------------------
FROM        ubuntu:18.04

LABEL       author="David Haßhoff" maintainer="d.hasshoff97@gmail.com"

ENV         DEBIAN_FRONTEND noninteractive

# Install Dependencies
RUN dpkg --add-architecture i386 \
 && apt update \
 && apt upgrade -y \
 && apt install -y ca-certificates
RUN apt install -y xvfb
RUN apt install -y lib32gcc1
RUN apt install -y libntlm0
RUN apt install -y winbind
RUN apt install -y wine64 --install-recommends
RUN apt clean \
RUN useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container WINEARCH=win32 WINEPREFIX=/home/container/.wine
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
