#!/usr/bin/env bash

pathadd() {
    newelement=${1%/}
    if [ -d "$1" ] && ! echo $PATH | grep -E -q "(^|:)$newelement($|:)" ; then
        if [ "$2" = "after" ] ; then
            PATH="$PATH:$newelement"
        else
            PATH="$newelement:$PATH"
        fi
    fi
}

pathrm() {
    PATH="$(echo $PATH | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}

#example usage above
#pathadd "/foo/bar"
#pathadd "/baz/bat" after
#export PATH

#REF: https://www.digitalocean.com/community/tutorials/how-to-use-cron-to-automate-tasks-ubuntu-1804

sudo apt update

sudo apt install wget

sudo apt install espeak #for saying block height in broadcast


    read -p "Would you like to build libbitcoin-explorer from source? NOTE: This takes a while and uses alot of resources on the droplet. If n we will download a binary and link to it. (y/n) " -n 1;

    if [[ $REPLY =~ ^[Yy]$ ]]; then

    #Build libbitcoin-explorer from source # Alot of work

    sudo apt-get install g++-4.8
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
    sudo update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-4.8 50
    sudo apt-get install build-essential autoconf automake libtool pkg-config git
    #
    wget https://raw.githubusercontent.com/libbitcoin/libbitcoin-explorer/version3/install.sh
    chmod +x install.sh
    ./install.sh --prefix=/root/bx --build-boost --build-zmq --disable-shared

    else

    rm -f bx-linux-x64-qrcode*
    wget https://github.com/libbitcoin/libbitcoin-explorer/releases/download/v3.2.0/bx-linux-x64-qrcode
    ln -s bx-linux-x64-qrcode bx

    fi;


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
