#! /bin/bash

source /etc/rpi-rele.conf
reset-chan.sh $CHAN4_GPIO

echo "[rpi-rig-ctl] RPI requests a reset of channel 4 at $(date)" >> /tmp/rpi-reles.log

