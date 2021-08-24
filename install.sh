#! /bin/bash

APT_DEPENDS="git vim htop mosquitto mosquitto-clients jq"
APT_RM_DEPENDS="dhcpcd5 isc-dhcp-client isc-dhcp-common"

check_apt_depends()
{
    echo "Checking package dependencies to add..."
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

check_apt_rm_depends()
{
    echo "Checking package dependencies to remove..."
    for DEPEND in ${APT_RM_DEPENDS}
    do  
        dpkg -s ${DEPEND} &> /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "Package depend ${DEPEND} is installed" &> /dev/null 2>&1
        else
            sudo apt remove ${DEPEND}
        fi
    done
}


##### MAIN

echo "Initial customizations"
raspi-config nonint do_change_locale es_ES.UTF-8
raspi-config nonint do_wifi_country ES
raspi-config nonint do_configure_keyboard es
systemctl enable ssh.service

echo "Checking and install APT depends"
check_apt_depends
check_apt_rm_depends

echo "Install rpi-rele software"
sudo cp -Rfa src-rpi/usr/bin/* /usr/bin/
sudo cp -Rfa src-rpi/etc/init.d/* /etc/init.d/
if [ ! -f /etc/network/interfaces.d/eth0 ]; then
    sudo cp -Rfa src-rpi/etc/network/interfaces.d/eth0 /etc/network/interfaces.d/
fi
if [ ! -f /etc/rpi-rele.conf ]; then
    sudo cp src-rpi/etc/rpi-rele.conf /etc/
fi

echo "Settings permissions"
sudo chmod 766 /usr/bin/reset-chan.sh
sudo chmod 755 /usr/bin/rig-ping-chan*.sh
sudo chmod 755 /usr/bin/rig-listen-chan*.sh
sudo chmod 755 /etc/init.d/rigpingctl
sudo chmod 644 /etc/rpi-rele.conf

echo "Add init service"
update-rc.d rigpingctl defaults
update-rc.d riglistenctl defaults

echo "Done"
