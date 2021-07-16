#! /bin/bash

source /etc/rpi-rele.conf
source /usr/bin/gpio-lib.sh

# Export some GPIOS and set direction
export_gpio_dir $GPIO_RST1 out

# Deactivate all
off_gpio $GPIO_RST1

# RESET
on_gpio $GPIO_RST1
sleep 1
off_gpio $GPIO_RST1

