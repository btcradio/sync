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



upodder --quiet



find $MEDIA_DIRECTORY -name "*.mp3" -type f -mtime +30
#find $MEDIA_DIRECTORY -name "*.mp3" -type f -mtime +30 -exec rm -f {} \;


echo "Nummber of episodes in MEDIA_DIRECTORY" && ls -1 $MEDIA_DIRECTORY | wc -l


if [ -f /$(whoami)/Downloads/podcasts/* ]; then

    mv $(whoami)/Downloads/podcasts/* $MEDIA_DIRECTORY
    #mv $(whoami)/Downloads/podcasts/* /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/

else

    echo "No new podcasts to sync..."

fi


echo "Nummber of episodes in MEDIA_DIRECTORY" && ls -1 $MEDIA_DIRECTORY | wc -l


# upodder --help
#usage: upodder [-h] [--no-download] [--podcastdir PODCASTDIR]
#               [--basedir BASEDIR] [--oldness OLDNESS] [--mark-seen]
#               [--import-opml OPMLPATH] [--quiet]
#
#Download podcasts via the command line.
#
#optional arguments:
#  -h, --help            show this help message and exit
#  --no-download         Don't download any files. Just mark as read.
#  --podcastdir PODCASTDIR, -p PODCASTDIR
#                        Folder to download podcast files to.
#  --basedir BASEDIR, -b BASEDIR
#                        Folder to store subscriptions and seen database.
#  --oldness OLDNESS, -o OLDNESS
#                        Skip entries older than X days.
#  --mark-seen           Just mark all entries as seen and exit.
#  --import-opml OPMLPATH, -i OPMLPATH
#                        Import feeds from an OPML file.
#  --quiet               Only output errors.
