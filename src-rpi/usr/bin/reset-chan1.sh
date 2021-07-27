#! /bin/bash

source /etc/rpi-rele.conf
reset-chan.sh $CHAN1_GPIO

echo "[rpi-rig-ctl] RPI requests a reset of channel 1 at $(date)" >> /tmp/rpi-reles.log

