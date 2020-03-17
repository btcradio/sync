#!/usr/bin/env bash

#apt-get install upodder
#git clone https://github.com/btcradio/upodder.git

echo "Running as: " $(whoami)

if [ -f /$(whoami)/.upodder/subscriptions ]; then

    #if [ ! cmp /root/.upodder/subscriptions  ./subscription >/dev/null 2>&1 ]; then
    if [ ! cmp /$(whoami)/.upodder/subscriptions  /subscriptions ]; then

        echo
        echo "New subscriptions added!"
        mv /$(whoami)/.upodder/subscriptions /root/.upodder/subscriptions.$(date +%s | cut -b1-13)
        cp subscriptions /$(whoami)/.upodder/subscriptions
        ls /$(whoami)/.upodder/
        echo

    else

        echo
        echo "No new subscriptions added!"
        mkdir -p  /$(whoami)/.upodder
        cp subscriptions /$(whoami)/.upodder/subscriptions
        echo

    fi

else

echo

fi

echo "Active subscriptions...."
cat  /$(whoami)/.upodder/subscriptions

if [ -d  /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media  ]; then

    #REF: /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/
    MEDIA_DIRECTORY=/var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/
    echo "MEDIA_DIRECTORY=$MEDIA_DIRECTORY"

fi

#upodder --quiet
upodder

find $MEDIA_DIRECTORY -name "*.mp3" -type f -mtime +7 -exec rm -f {} \;

echo "Nummber of episodes in MEDIA_DIRECTORY" && ls -1 $MEDIA_DIRECTORY | wc -l

mv $(whoami)/Downloads/podcasts/* $MEDIA_DIRECTORY
#mv $(whoami)/Downloads/podcasts/* /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/

echo "Nummber of episodes in MEDIA_DIRECTORY" && ls -1 $MEDIA_DIRECTORY | wc -l

echo "You may upload episodes manually with an ftp client."
ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'

