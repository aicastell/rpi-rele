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

while [ 1 ]
do
    TIME_INI=$(date +%s)
    RSP=$(mosquitto_sub -t "rpi/status/${CHAN_HOSTNAME}" -C 1 -W 600)
    TIME_END=$(date +%s)

    ELAPSED_TIME=$(($TIME_END - $TIME_INI))

    if [ $ELAPSED_TIME -ge 600 ]; then
        echo "[rpi-rig-listen-chan] RPI requests a reset because ELAPSE_TIME>600 at $(date)" >> ${LOGFILE}
        reset-chan.sh $CHAN_GPIO
        continue
    fi

    STATUS=$(echo $RSP | jq .status)
    IPADDR=$(echo $RSP | jq .ipaddr)
    RIGNAME=$(echo $RSP | jq .rigname)

    if [ $STATUS -ne 0 ]; then
        echo "[rpi-rig-listen-chan] RPI requests a reset because STATUS ne 0 at $(date)" >> ${LOGFILE}
        reset-chan.sh $CHAN_GPIO
        continue
    fi
done

