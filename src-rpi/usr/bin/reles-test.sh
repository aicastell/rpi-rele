#! /bin/bash

echo 4 > /sys/class/gpio/export
sleep 1
echo 22 > /sys/class/gpio/export
sleep 1
echo 23 > /sys/class/gpio/export
sleep 1
echo 27 > /sys/class/gpio/export
sleep 1

echo out > /sys/class/gpio/gpio4/direction
sleep 1
echo out > /sys/class/gpio/gpio22/direction
sleep 1
echo out > /sys/class/gpio/gpio23/direction
sleep 1
echo out > /sys/class/gpio/gpio27/direction
sleep 1


while [ 1 ]
do
    # Apagados
    echo 1 > /sys/class/gpio/gpio4/value
    sleep 1
    echo 1 > /sys/class/gpio/gpio22/value
    sleep 1
    echo 1 > /sys/class/gpio/gpio23/value
    sleep 1
    echo 1 > /sys/class/gpio/gpio27/value
    sleep 1

    # Encendidos
    echo 0 > /sys/class/gpio/gpio4/value
    sleep 1
    echo 0 > /sys/class/gpio/gpio22/value
    sleep 1
    echo 0 > /sys/class/gpio/gpio23/value
    sleep 1
    echo 0 > /sys/class/gpio/gpio27/value
    sleep 1
done



