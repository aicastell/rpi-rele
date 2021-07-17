#! /bin/bash

GPIO_PWR=$1

source /etc/rpi-rele.conf
source /usr/bin/gpio-lib.sh

# Export GPIO and set direction
export_gpio_dir $GPIO_PWR out

# Deactivate
off_gpio $GPIO_PWR

# Poweron
on_gpio $GPIO_PWR
sleep 1
off_gpio $GPIO_PWR


