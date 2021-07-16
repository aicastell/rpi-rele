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
sudo cp -Rfa src/* /

echo "Settings permissions"
sudo chmod +x /usr/bin/poweron-chan*.sh
sudo chmod +x /usr/bin/reset-chan*.sh
sudo chmod +x /usr/bin/rig-monit-chan*.sh
sudo chmod +x /etc/init.d/rigctl

echo "Add init service"
update-rc.d rigctl defaults

echo "Done"
