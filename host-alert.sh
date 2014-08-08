#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo "host-alert by Luis Hartmann 2014"
  echo "Keeps pinging a host every five seconds until it is reachable, then it stops. Uses xmessage for feedback."
  echo "This software is contributed under the terms of the MIT License."
  echo "Usage: $0 <hostname or ip>"
  exit 0
fi

function result-host-up
{
  echo "Successfully connected to $1. Host up and reachable."
  xmessage -title "host alert - success" -center -buttons "Got it":0 -default "Got it" -timeout 20 "Successfully connected to $1 - Host up and reachable."
  exit 0
}

function result-host-down
{
  echo "Host not reachable. Retrying in 5 seconds..."
  xmessage -title "host alert - not reachable" -buttons "Retry now":0,Abort -default "Retry now" -timeout 5 "Host $1 not reachable. Retrying in 5 seconds." && check-host $1 || exit 1
  #sleep 5
  #check-host $1
}

function check-host
{
  ping -c 1 $1 > /dev/null && result-host-up $1 || result-host-down $1
}

check-host $1
