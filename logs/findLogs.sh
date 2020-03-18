#!/usr/bin/env bash

#REF: https://www.cyberciti.biz/tips/howto-linux-unix-find-move-all-mp3-file.html

echo
echo "Docker Volumes:"
find / -iname "volumes" -print

echo
echo "Station Data:"
echo "ls /var/lib/docker/volumes/azuracast_station_data/_data/"
ls /var/lib/docker/volumes/azuracast_station_data/_data/

echo
echo "btcRadio.net logs and config files.:"
find /var/lib/docker/volumes/ -iname "btcradio.net" -print

