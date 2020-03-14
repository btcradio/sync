#!/usr/bin/env bash

git clone https://github.com/btcradio/upodder.git

cd upodder




upodder
mv ~/Downloads/podcasts/*.mp3 /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/
