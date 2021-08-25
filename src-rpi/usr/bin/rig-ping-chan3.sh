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
        check_ping $CHAN_IP3
        RET=$?

        if [ $RET -ne 0 ]; then
            FAIL_NR=$(expr $FAIL_NR + 1)
        else
            break	
        fi

        if [ $FAIL_NR -eq $FAILS_TOTAL ]; then
            if [[ $CHAN3_GPIO ]]; then
                if [ $CHAN3_FUNC == "RST" ]; then
                    echo "[rpi-rig-ping-chan] RPI requests a reset because FAIL_NR = $FAIL_NR at $(date)" >> ${LOGFILE}
                    reset-chan.sh $CHAN3_GPIO
                fi
            fi
            break
        fi
    done
}

while [ 1 ]
do
    check_ping $CHAN_IP3
    RET=$?

    if [ $RET -ne 0 ]; then
        error_state
    fi

    sleep $TIMEOUT
done


