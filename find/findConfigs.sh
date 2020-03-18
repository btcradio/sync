#!/usr/bin/env bash

echo
echo "Docker Volumes:"
find / -iname "volumes" -print

echo
echo "Station Data:"
echo "ls /var/lib/docker/volumes/azuracast_station_data/_data/"
ls /var/lib/docker/volumes/azuracast_station_data/_data/

echo
echo "btcRadio.net logs and config files.:"
find /var/lib/docker/volumes/ -iname "*.liq" -print
find /var/lib/docker/volumes/ -iname "*.xml" -print
echo

echo Files will look simular to this within the containers.
echo
echo Liquidsoap Configuration
echo /var/azuracast/stations/btcradio.net/config/liquidsoap.liq
echo
echo Icecast Configuration
echo /var/azuracast/stations/btcradio.net/config/icecast.xml

