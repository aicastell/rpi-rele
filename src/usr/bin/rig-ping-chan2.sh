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
        check_ping $CHAN_IP2
        RET=$?

        if [ $RET -ne 0 ]; then
            FAIL_NR=$(expr $FAIL_NR + 1)
        else
            break	
        fi

        if [ $FAIL_NR -eq $FAILS_TOTAL ]; then
            if [[ $CHAN2_GPIO ]]; then
                if [ $CHAN2_FUNC == "RST" ]; then
                    activate-1sec.sh $CHAN2_GPIO
                else
                    activate-1sec.sh $CHAN2_GPIO
                fi
            fi
            break
        fi
    done
}

while [ 1 ]
do
    check_ping $CHAN_IP2
    RET=$?

    if [ $RET -ne 0 ]; then
        error_state
    fi

    sleep $TIMEOUT
done


