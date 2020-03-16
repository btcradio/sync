#!/usr/bin/env bash

#REF: https://www.cyberciti.biz/tips/howto-linux-unix-find-move-all-mp3-file.html

echo
echo

find / -iname "volumes" -print

echo
echo

find /var/lib/docker/volumes/ -iname "btcradio.net" -print

echo
echo

find /var/lib/docker/volumes/ -iname "*.html" -print

echo
echo

find /var/lib/docker/volumes/ -iname "*.mp3" -print
