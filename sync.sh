#!/usr/bin/env bash

#apt-get install upodder
#git clone https://github.com/btcradio/upodder.git


echo $(whoami)

if [ -f /$(whoami)/.upodder/subscriptions ]; then

    #if [ ! cmp /root/.upodder/subscriptions  ./subscription >/dev/null 2>&1 ]; then
    if [ ! cmp /$(whoami)/.upodder/subscriptions  /subscriptions ]; then

        echo
        echo "different!!!!!!!!!!!!!"
        echo
      # restart service
    else

        echo
        echo "same!!!!!!!!!!!!!"
        echo

    fi

    mv /$(whoami)/.upodder/subscriptions /root/.upodder/subscriptions.$(date +%s | cut -b1-13)
    cp subscriptions /$(whoami)/.upodder/subscriptions
    ls /$(whoami)/.upodder/

else

    mkdir -p  /$(whoami)/.upodder
    cp subscriptions /$(whoami)/.upodder/subscriptions

fi

if [ -d  /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media  ]; then

    #REF: /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/
    MEDIA_DIRECTORY=/var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/
    echo "MEDIA_DIRECTORY=$MEDIA_DIRECTORY"

fi

upodder

mv $(whoami)/Downloads/podcasts/* $MEDIA_DIRECTORY
#mv $(whoami)/Downloads/podcasts/* /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/

