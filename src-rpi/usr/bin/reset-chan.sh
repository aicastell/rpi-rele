#! /bin/bash

GPIO_RST=$1

source /etc/rpi-rele.conf
source /usr/bin/gpio-lib.sh

# Export some GPIOS and set direction
export_gpio_dir $GPIO_RST out

# Deactivate all
off_gpio $GPIO_RST

# RESET
on_gpio $GPIO_RST
sleep 1
off_gpio $GPIO_RST

