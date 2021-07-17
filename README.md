# RELE CONTROLLER

Software is used to control the PWR and RST signals of a mining rig.

## Configuration

Edit /etc/rpi-rele.conf file and enable the channels you need. For each channel
you must setup:

a) The GPIO number connected
b) The function reset (RST) or poweron (PWR)
c) The IP address monitorized
d) The time to be monitorizing
e) The number of ping fails in that time

## Work

The system will be monitorizing the GPIO channels configured, and in case the
number of ping fails raises the maximum value expected, the monitorized signal
will be activated

## Contact

In case on suggestions, bugs, please contact with us sending an email to contacto@criptobadia.es
