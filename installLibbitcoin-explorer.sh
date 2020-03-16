#!/usr/bin/env bash

#REF: https://www.digitalocean.com/community/tutorials/how-to-use-cron-to-automate-tasks-ubuntu-1804

sudo apt update

sudo apt install espeak #for saying block height in broadcast
sudo apt-get install g++-4.8
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
sudo update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-4.8 50
sudo apt-get install build-essential autoconf automake libtool pkg-config git

./install.sh --prefix=/home/me/myprefix --build-boost --build-zmq --disable-shared





#sudo systemctl enable cron
#
## /var/spool/cron/crontabs/
#
#echo "minute hour day_of_month month day_of_week command_to_run"
#echo "30 17 * * 2 curl http://www.google.com"
#
#crontab -e
#
#
#
