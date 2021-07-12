#! /bin/bash

source /etc/rpi-rele.conf

export_gpio_dir()
{
	GPIO_NR=$1
	GPIO_DIR=$2
	if [ ! -d /sys/class/gpio/gpio${GPIO_NR} ]
	then
		echo $GPIO_NR > /sys/class/gpio/export
		echo $GPIO_DIR > /sys/class/gpio/gpio${GPIO_NR}/direction
	fi
}

off_gpio()
{
	GPIO_NR=$1
	echo 1 > /sys/class/gpio/gpio${GPIO_NR}/value
}

on_gpio()
{
	GPIO_NR=$1
	echo 0 > /sys/class/gpio/gpio${GPIO_NR}/value
}

# Export some GPIOS and set direction
export_gpio_dir $GPIO_RST1 out

# Deactivate all
off_gpio $GPIO_RST1

# RESET
on_gpio $GPIO_RST1
sleep 1
off_gpio $GPIO_RST1


