#! /bin/bash

source /etc/rpi-rele.conf
source /usr/bin/gpio-lib.sh

# Export some GPIOS and set direction
export_gpio_dir $GPIO_RST3 out

# Deactivate all
off_gpio $GPIO_RST3

# RESET
on_gpio $GPIO_RST3
sleep 1
off_gpio $GPIO_RST3

