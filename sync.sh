#!/usr/bin/env bash

#apt-get install upodder
#git clone https://github.com/btcradio/upodder.git

if [ -f /root/.upodder/subscriptions ]; then

    sleep 5

    mv /root/.upodder/subscriptions /root/.upodder/subscriptions.$(date +%s | cut -b1-13)
    cp subscriptions /root/.upodder/subscriptions

else

    sleep 5

    mkdir -p  /root/.upodder
    cp subscriptions /root/.upodder/subscriptions

fi

#REF: /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/
set MEDIA_DIRECTORY = /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/

    sleep 5

upodder

    sleep 5

#mv ~/Downloads/podcasts/*.mp3 $MEDIA_DIRECTORY
mv ~/Downloads/podcasts/*.mp3 /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/

