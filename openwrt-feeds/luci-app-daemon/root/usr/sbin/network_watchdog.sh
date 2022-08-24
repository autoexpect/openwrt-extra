#!/bin/sh

dns1="114.114.114.114"
dns2="8.8.8.8"

sleep 300
while true; do
    ping -s 1 -c 3 $dns1
    if [ "$?" != "0" ]; then
        ping -s 1 -c 5 $dns2
        if [ "$?" != "0" ]; then
            reboot
        else
            sleep 20
        fi
    else
        sleep 300
    fi
done
