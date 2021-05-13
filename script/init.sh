#!/bin/bash
 
if [ $# -ne 1 ]; then
  echo "Requires an argument of environmet" 1>&2
  exit 1
fi

if [ $1 = local ]; then
  DIR="./content"
  if [ -d $DIR ];then
    echo "Content directory exists."
    exit 1
  else
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1-1ltDoEYlNzwRF84HMIcKbDucgmId3cP' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1-1ltDoEYlNzwRF84HMIcKbDucgmId3cP" -O /tmp/dataset.zip
    rm -rf /tmp/cookies.txt
    unzip -q /tmp/dataset.zip -d ./content
  fi
elif [ $1 = colab ]; then
  DIR="/content"
  if [ -d $DIR ];then
    echo "Content directory exists."
    exit 1
  else
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1-1ltDoEYlNzwRF84HMIcKbDucgmId3cP' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1-1ltDoEYlNzwRF84HMIcKbDucgmId3cP" -O /content/dataset.zip && rm -rf /tmp/cookies.txt && unzip -q /content/dataset.zip -d /content
  fi
  pip install pytorch_lightning neptune-client > /dev/null
else
  echo "Get Invalid ENV.(local or colab)"
fi