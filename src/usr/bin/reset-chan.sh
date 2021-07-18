#! /bin/bash

if [ $# -ne 1 ]; then
    echo "Syntax error: gpio expected"
    exit
fi

GPIO_RST=$1

source /etc/rpi-rele.conf
source /usr/bin/gpio-lib.sh

# Export GPIO and set direction
export_gpio_dir $GPIO_RST out

# Deactivate
off_gpio $GPIO_RST

# RESET
on_gpio $GPIO_RST
sleep 1
off_gpio $GPIO_RST

