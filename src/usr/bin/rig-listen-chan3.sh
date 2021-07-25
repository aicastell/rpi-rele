#! /bin/bash

while [ 1 ]
do
    TIME_INI=$(date +%s)
    RSP=$(mosquitto_sub -t "rpi/status/${CHAN3_HOSTNAME}" -C 1 -W 600)
    TIME_END=$(date +%s)

    ELAPSED_TIME=$(($TIME_END - $TIME_INI))

    if [ $ELAPSED_TIME -ge 600 ]; then
        reset-chan3.sh
        continue
    fi

    STATUS=$(echo $RSP | jq .status)
    IPADDR=$(echo $RSP | jq .ipaddr)
    RIGNAME=$(echo $RSP | jq .rigname)

    if [ $STATUS -ne 0 ]; then
        reset-chan3.sh
        continue
    fi
done


