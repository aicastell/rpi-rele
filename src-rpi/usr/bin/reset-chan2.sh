#! /bin/bash

source /etc/rpi-rele.conf
reset-chan.sh $CHAN2_GPIO

echo "[rpi-rig-ctl] RPI requests a reset of channel 2 at $(date)" >> /tmp/rpi-reles.log

