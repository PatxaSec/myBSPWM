#!/bin/sh

if [ -n "$(ifconfig eth0 2>/dev/null | grep 'inet ')" ]; then
    echo "%{F#710193} %{F#ffffff}$(/usr/sbin/ifconfig eth0 | grep 'inet ' | awk '{print $2}')"
elif [ -n "$(ifconfig ens33 2>/dev/null | grep 'inet ')" ]; then
    echo "%{F#710193} %{F#ffffff}$(/usr/sbin/ifconfig ens33 | grep 'inet ' | awk '{print $2}')"
elif [ -n "$(ifconfig wlan0 2>/dev/null | grep 'inet ')" ]; then
    echo "%{F#710193} %{F#ffffff}$(/usr/sbin/ifconfig wlan0 | grep 'inet ' | awk '{print $2}')"
else
    echo "%{F#e51d0b}"
fi
