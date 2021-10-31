#! /bin/bash

echo "Activating GPIOS..."
echo 4 > /sys/class/gpio/export
sleep 1
echo 27 > /sys/class/gpio/export
sleep 1
echo 22 > /sys/class/gpio/export
sleep 1
echo 23 > /sys/class/gpio/export
sleep 1
echo 24 > /sys/class/gpio/export
sleep 1
echo 25 > /sys/class/gpio/export
sleep 1
echo 5 > /sys/class/gpio/export
sleep 1
echo 6 > /sys/class/gpio/export
sleep 1

echo "Setting directions..."
echo out > /sys/class/gpio/gpio4/direction
sleep 1
echo out > /sys/class/gpio/gpio27/direction
sleep 1
echo out > /sys/class/gpio/gpio22/direction
sleep 1
echo out > /sys/class/gpio/gpio23/direction
sleep 1
echo out > /sys/class/gpio/gpio24/direction
sleep 1
echo out > /sys/class/gpio/gpio25/direction
sleep 1
echo out > /sys/class/gpio/gpio5/direction
sleep 1
echo out > /sys/class/gpio/gpio6/direction
sleep 1

echo "Starting test..."
while [ 1 ]
do
    # Apagados
    echo 1 > /sys/class/gpio/gpio4/value
    sleep 1
    echo 1 > /sys/class/gpio/gpio27/value
    sleep 1
    echo 1 > /sys/class/gpio/gpio22/value
    sleep 1
    echo 1 > /sys/class/gpio/gpio23/value
    sleep 1
    echo 1 > /sys/class/gpio/gpio24/value
    sleep 1
    echo 1 > /sys/class/gpio/gpio25/value
    sleep 1
    echo 1 > /sys/class/gpio/gpio5/value
    sleep 1
    echo 1 > /sys/class/gpio/gpio6/value
    sleep 1

    # Encendidos
    echo 0 > /sys/class/gpio/gpio4/value
    sleep 1
    echo 0 > /sys/class/gpio/gpio27/value
    sleep 1
    echo 0 > /sys/class/gpio/gpio22/value
    sleep 1
    echo 0 > /sys/class/gpio/gpio23/value
    sleep 1
    echo 0 > /sys/class/gpio/gpio24/value
    sleep 1
    echo 0 > /sys/class/gpio/gpio25/value
    sleep 1
    echo 0 > /sys/class/gpio/gpio5/value
    sleep 1
    echo 0 > /sys/class/gpio/gpio6/value
    sleep 1
done

