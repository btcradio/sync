#!/usr/bin/env bash

sudo apt update

sudo apt install wget

apt install speech-dispatcher

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
    chmod +x bx-linux-x64-qrcode
    ln -s bx-linux-x64-qrcode bx

fi;

