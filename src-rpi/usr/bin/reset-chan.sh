#! /bin/bash

if [ $# -ne 1 ]; then
    echo "Syntax error: gpio expected"
    exit
fi

GPIO=$1

source /etc/rpi-rele.conf
source /usr/bin/gpio-lib.sh

echo "[rpi-rig-ctl] RPI requests a reset of gpio $GPIO at $(date)" >> ${LOGFILE}

# Export GPIO and set direction
export_gpio_dir $GPIO out

# Deactivate
off_gpio $GPIO

# Activate for 1 second
on_gpio $GPIO
sleep 1
off_gpio $GPIO

