#!/bin/bash

threshold=0.1
critical=0.05

# Read energy_full
full=($(cat /sys/class/power_supply/BAT*/energy_full))

# Read energy_now
now=($(cat /sys/class/power_supply/BAT*/energy_now))

let abs_now=0
let abs_full=0

for ((i = 0; i < ${#now[@]}; ++i)); do
    abs_now=$(echo "$abs_now + ${now[i]}" | bc -l)
    abs_full=$(echo "$abs_full + ${full[i]}" | bc -l)
done

level=$(echo "$abs_now / $abs_full" | bc -l)

if (( $(echo "$level <= $threshold" | bc -l) )); then
    if [ ! -f "/tmp/batterywatch_notification" ] || ( (( $(echo "$level <= $critical" | bc -l)  )) && (( ! $(cat /sys/class/power_supply/AC/online) )) ); then
        notify-send "Battery status" "Your battery is running low!!!" -u critical
        touch /tmp/batterywatch_notification
    fi
else
    rm /tmp/batterywatch_notification 2> /dev/null
    exit 0
fi

