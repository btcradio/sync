#!/usr/bin/env bash

if [ -f /root/.upodder/subscriptions ]; then
   mv /root/.upodder/subscriptions /root/.upodder/subscriptions.$(date +%s | cut -b1-13)
else
mkdir -p  /root/.upodder
fi

cp subscriptions /root/.upodder/subscriptions

git clone https://github.com/btcradio/upodder.git

upodder

mv ~/Downloads/podcasts/*.mp3 /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/

