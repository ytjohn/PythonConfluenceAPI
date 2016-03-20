#!/bin/bash

LS_COLORS="string"
PORT=1990
PRODUCT=confluence
WAIT1=100
WAIT2=20

sudo apt-get install -y screen

# First, we are just going to check without doing anything.
(: </dev/tcp/127.0.0.1/${PORT}) &>/dev/null && READY=1 || READY=0

if [ "$READY" -eq "1" ]; then
  echo "Port ${PORT} is already listening, not proceeding."
  exit 0
fi

echo "Agreeing to Oracle License"
cd /home/vagrant/scripts
echo yes | sudo node oracle-license.js
cd /home/vagrant

echo "Starting ${PRODUCT} in screen ${PRODUCT}"
sudo screen -d -m -L -S ${PRODUCT} atlas-run-connect --product ${PRODUCT}

echo "Will wait ${WAIT1} seconds for port ${PORT} to open. A fresh VM could take around 5 minutes (600 seconds)."
echo "A previously configured instance will still take around 2 minutes (120 seconds)."
sleep ${WAIT1}

while true; do
  (: </dev/tcp/127.0.0.1/${PORT}) &>/dev/null && READY=1 || READY=0

  now=`date +"%T"`

  if [ "$READY" == "1" ]; then
    echo "{$now}: Port ${PORT} is listening."
    exit 0
  fi

  echo "${now} Waiting ${WAIT2} seconds for ${PORT} to open".
  sleep ${WAIT2}
done

