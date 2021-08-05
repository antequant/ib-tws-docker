#!/bin/bash

set -e
set -o errexit

rm -f /tmp/.X0-lock

Xvfb :0 &
sleep 1

x11vnc -rfbport $VNC_PORT -display :0 -usepw -forever &

# Start this last and directly, so that if TWS terminates for any reason, the container will stop as well.
/opt/ibc/scripts/ibcstart.sh $(ls ~/Jts)
