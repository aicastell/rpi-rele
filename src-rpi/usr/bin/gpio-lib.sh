#! /bin/bash

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

