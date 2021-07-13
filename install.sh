#! /bin/bash

echo "Installing rpi-rele software"
cp -Rfa src/* /

echo "Settings permissions"
chmod +x /usr/bin/poweron.sh
chmod +x /usr/bin/reset.sh
chmod +x /usr/bin/rig-monit.sh

echo "Done"
