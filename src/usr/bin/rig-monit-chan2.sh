#! /bin/bash

source /etc/rpi-rele.conf

TIMEOUT=$(expr ${INTERVAL_SECS} / ${FAILS_TOTAL})

check_ping()
{
    MONIT_IP=$1
    ping -c 1 $MONIT_IP
    return $?
}	
	
error_state()
{
    FAIL_NR=1
    while [ 1 ]
    do
        sleep $TIMEOUT
        check_ping
        RET=$?

        if [ $RET -ne 0 ]; then
            FAIL_NR=$(expr $FAIL_NR + 1)
        else
            break	
        fi

        if [ $FAIL_NR -eq $FAILS_TOTAL ]; then
            if [[ $GPIO_PWR2 ]]; then
                poweron-chan.sh $GPIO_PWR2
            else
                if [[ $GPIO_RST2 ]]; then
                    reset-chan.sh $GPIO_RST2
                fi
            fi
            break
        fi
    done
}

while [ 1 ]
do
    check_ping $MONIT_IP2
    RET=$?

    if [ $RET -ne 0 ]; then
        error_state
    fi

    sleep $TIMEOUT
done


