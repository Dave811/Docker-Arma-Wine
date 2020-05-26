#!/bin/bash
cd /home/container

WINEPREFIX=~/.wine wineboot
WINEPREFIX=~/.wine32 WINEARCH=win32 wineboot

WINEPREFIX=~/.wine32 WINEARCH=win32 arma3server.exe

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}