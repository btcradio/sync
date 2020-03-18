#!/usr/bin/env bash

input="subscriptions"
while IFS= read -r line
do
  echo "$line"
done < "$input"
