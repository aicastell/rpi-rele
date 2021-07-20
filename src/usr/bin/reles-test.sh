#! /bin/bash

echo 4 > /sys/class/gpio/export
echo 22 > /sys/class/gpio/export
echo 23 > /sys/class/gpio/export
echo 27 > /sys/class/gpio/export

echo out > /sys/class/gpio/gpio4/direction
echo out > /sys/class/gpio/gpio22/direction
echo out > /sys/class/gpio/gpio23/direction
echo out > /sys/class/gpio/gpio27/direction


while [ 1 ]
do

# Apagados
echo 1 > /sys/class/gpio/gpio4/value
echo 1 > /sys/class/gpio/gpio22/value
echo 1 > /sys/class/gpio/gpio23/value
echo 1 > /sys/class/gpio/gpio27/value

sleep 2


# Encendidos

echo 0 > /sys/class/gpio/gpio4/value
echo 0 > /sys/class/gpio/gpio22/value
echo 0 > /sys/class/gpio/gpio23/value
echo 0 > /sys/class/gpio/gpio27/value

done



