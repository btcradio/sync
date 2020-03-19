#!/usr/bin/env bash

#apt-get install upodder
#git clone https://github.com/btcradio/upodder.git

echo "Running as: " $(whoami)

echo $(pwd)

if [ -f ~/.upodder/subscriptions ]; then

    #if [ ! cmp /root/.upodder/subscriptions  ./subscription >/dev/null 2>&1 ]; then
    if  ! cmp ~/.upodder/subscriptions $(pwd)/subscriptions >/dev/null 2>&1 ; then

        echo
        echo "New subscriptions added!"
        mv ~/.upodder/subscriptions ~/.upodder/subscriptions.$(date +%s | cut -b1-13)
        cp $(pwd)/subscriptions ~/.upodder/subscriptions
        ls ~/.upodder/
        echo

    else

        echo
        echo "No new subscriptions added!"
        mkdir -p  ~/.upodder
        cp $(pwd)/subscriptions ~/.upodder/subscriptions
        echo

    fi

else

echo

fi

echo "Active subscriptions...."
cat  ~/.upodder/subscriptions

if [ -d  /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media  ]; then

    #REF: /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media
    MEDIA_DIRECTORY=/var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media
    echo "MEDIA_DIRECTORY=$MEDIA_DIRECTORY"

fi

#upodder --quiet
upodder -o 7

find $MEDIA_DIRECTORY -name "*.mp3" -type f -mtime +7 -exec rm -f {} \;

echo "Number of episodes in MEDIA_DIRECTORY" && ls -1 $MEDIA_DIRECTORY | wc -l

LOCAL_DOWNLOADS=~/Downloads/podcasts

mv $LOCAL_DOWNLOADS/* $MEDIA_DIRECTORY
#mv /$(whoami)/Downloads/podcasts/* /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/

echo "Number of episodes in MEDIA_DIRECTORY" && ls -1 $MEDIA_DIRECTORY | wc -l

echo "You may upload episodes manually with an ftp client."
ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'

# The following script parses podcast feeds and downloads all podcast episodes listed in
# the feed if they don't exist within the target path. The target directory will be created
# if it does not exist.

[ -x "$(command -v wget)" ] || (echo "wget is not installed" && exit 1)
[ -x "$(command -v sed)" ] || (echo "sed is not installed" && exit 1)
[ -x "$(command -v xargs)" ] || (echo "xargs is not installed" && exit 1)

function download_files_from_feed {

    [ -d $2 ] || mkdir -p $2
    cd $2
    wget -nc $(wget -q -O - $1 | sed -n 's/.*enclosure.*url="\([^"]*\)" .*/\1/p')
}

function echo_update_stats {

    PODCAST_UPDATE_LIST=$(find $MEDIA_DIRECTORY -name "*.mp3" -ctime -1 -type f)

    echo "All podcasts updated."

    if [ -n "$PODCAST_UPDATE_LIST" ]
    then
        echo -e "\nNew episodes within the last 24 hours:"
        echo $PODCAST_UPDATE_LIST | xargs basename | xargs printf "* %s\n"
    else
        echo "No new episodes are available."
    fi
}

#Brute force downloading of all episodes
read -p "Would you like to download ALL episodes of all pods on your subscription list? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then


input="subscriptions"
while IFS= read -r line
do

download_files_from_feed $line $LOCAL_DOWNLOADS

#find $MEDIA_DIRECTORY -name "*.mp3" -type f -mtime +7 -exec rm -f {} \;

echo "Nummber of episodes in MEDIA_DIRECTORY" && ls -1 $MEDIA_DIRECTORY | wc -l

mv  $LOCAL_DOWNLOADS/* $MEDIA_DIRECTORY
#docker location
#mv $(whoami)/Downloads/podcasts/* /var/lib/docker/volumes/azuracast_station_data/_data/btcradio.net/media/

echo "Number of episodes in MEDIA_DIRECTORY" && ls -1 $MEDIA_DIRECTORY | wc -l

echo "You may upload episodes manually with an ftp client."
ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'

# This one's sending notifications to my phone but might not be useful for you
#/root/send_notification.sh "$(echo_update_stats $PODCAST_DIR)"
echo_update_stats $PODCAST_DIR

done < "$input"
fi

