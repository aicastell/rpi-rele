#! /bin/bash

APT_DEPENDS="git vim htop"

check_apt_depends()
{
    echo "Checking package dependencies..."
    for DEPEND in ${APT_DEPENDS}
    do  
        dpkg -s ${DEPEND} &> /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "Package depend ${DEPEND} is installed" &> /dev/null 2>&1
        else
            sudo apt install ${DEPEND}
        fi
    done
}

##### MAIN

echo "Checking and install APT depends"
check_apt_depends

echo "Install rpi-rele software"
sudo cp -Rfa src/usr/bin/* /usr/bin/
sudo cp -Rfa src/etc/init.d/* /etc/init.d/
if [ ! -f /etc/network/interfaces.d/eth0 ]; then
    sudo cp -Rfa src/etc/network/interfaces.d/eth0 /etc/network/interfaces.d/
fi
if [ ! -f /etc/rpi-rele.conf ]; then
    sudo cp src/etc/rpi-rele.conf /etc/
fi

echo "Settings permissions"
sudo chmod 755 /usr/bin/activate-1sec.sh
sudo chmod 755 /usr/bin/rig-monit-chan*.sh
sudo chmod 755 /etc/init.d/rigctl
sudo chmod 644 /etc/rpi-rele.conf

echo "Add init service"
update-rc.d rigctl defaults

echo "Done"
