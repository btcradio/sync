#!/usr/bin/env bash

if [ -f /root/.upodder/subscriptions ]; then
   mv /root/.upodder/subscriptions /root/.upodder/subscriptions.bak
fi

mkdir -p  /root/.upodder
ln -s subscriptions /root/.upodder/

git clone https://github.com/btcradio/upodder.git

cd upodder




upodder
mv ~/Downloads/podcasts/*.mp3 /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/
