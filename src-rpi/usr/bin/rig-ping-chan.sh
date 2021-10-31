#! /bin/bash

source /etc/rpi-rele.conf

if [ $# -ne 1 ]; then
    echo "Missing channel number"
    exit
fi

NUM=$1

if [ $NUM -lt 1 ] || [ $NUM -gt 8 ]; then
    echo "Invalid channel number. Valid range is [1-8]"
    exit
fi

eval CHAN_GPIO="\$CHAN${NUM}_GPIO"
eval CHAN_FUNC="\$CHAN${NUM}_FUNC"
eval CHAN_IP="\$CHAN${NUM}_IP"
eval CHAN_HOSTNAME="\$CHAN${NUM}_HOSTNAME"

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
        check_ping $CHAN_IP
        RET=$?

        if [ $RET -ne 0 ]; then
            FAIL_NR=$(expr $FAIL_NR + 1)
        else
            break	
        fi

        if [ $FAIL_NR -eq $FAILS_TOTAL ]; then
            if [[ $CHAN_GPIO ]]; then
                if [ $CHAN_FUNC == "RST" ]; then
                    echo "[rpi-rig-ping-chan] RPI requests a reset because FAIL_NR = $FAIL_NR at $(date)" >> ${LOGFILE}
                    reset-chan.sh $CHAN_GPIO
                fi
            fi
            break
        fi
    done
}

while [ 1 ]
do
    check_ping $CHAN_IP
    RET=$?

    if [ $RET -ne 0 ]; then
        error_state
    fi

    sleep $TIMEOUT
done


