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

echo "Checking apt dependencies"
check_apt_depends

echo "Installing rpi-rele software"
sudo cp -Rfa src/* /

echo "Settings permissions"
sudo chmod +x /usr/bin/poweron.sh
sudo chmod +x /usr/bin/reset.sh
sudo chmod +x /usr/bin/rig-monit.sh

echo "Done"
