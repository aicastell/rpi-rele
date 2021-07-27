#! /bin/bash

source /etc/rpi-rele.conf
reset-chan.sh $CHAN3_GPIO

echo "[rpi-rig-ctl] RPI requests a reset of channel 3 at $(date)" >> /tmp/rpi-reles.log

