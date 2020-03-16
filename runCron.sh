#!/usr/bin/env bash

#REF: https://www.digitalocean.com/community/tutorials/how-to-use-cron-to-automate-tasks-ubuntu-1804

sudo apt update

sudo apt install cron
sudo apt install acpi

sudo systemctl enable cron

# /var/spool/cron/crontabs/

echo "minute hour day_of_month month day_of_week command_to_run"
echo "30 17 * * 2 curl http://www.google.com"

crontab -e



