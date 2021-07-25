#! /bin/bash

HOSTNAME=$(cat /etc/hostname)
IPADDR=$(hostname -I | cut -d" " -f 1)
MAX_ERRORS=10
TIMEOUT=60

check_test1()
{
    ping -c 1 -W 10 8.8.8.8 
    RET=$?
    return $RET
}

check_test2()
{
    ERRORS=$(dmesg | grep ERROR | wc -l)
    RET=0
    if [ $ERRORS -gt $MAX_ERRORS ]; then
        RET=1
    fi
    return $RET
}

while [ 1 ]
do
    STATUS=0

    check_test1
    RET=$?
    if [ $RET -ne 0 ]; then
        STATUS=1
    fi

    check_test2
    RET=$?
    if [ $RET -ne 0 ]; then
        STATUS=2
    fi

    mosquitto_pub -t "rpi/status/${HOSTNAME}" -h pi-rele -m "{ \"rigname\": \"${HOSTNAME}\", \"ipaddr\": \"${IPADDR}\", \"status\": ${STATUS} }"
    sleep $TIMEOUT
done
