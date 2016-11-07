#!/bin/bash

NEW_IP=new-ip.txt
CURRENT_IP=ip.txt
DIR=/home/pi/Workspace/RPi

cd $DIR

echo `hostname -I` > $NEW_IP
#echo `ifconfig` > $NEW_IP
#sed -i 's/lo:/\n\nlo:/g' $NEW_IP
#sed -i 's/wlan0:/\n\nwlan0:/g' $NEW_IP

if [ -f $CURRENT_IP ]; then
    DIFF=`diff -q $CURRENT_IP $NEW_IP`
    #echo 'same'
    #echo $DIFF
else
    DIFF='differ'
fi

if [ "$DIFF" != "" ]; then
    mv $NEW_IP $CURRENT_IP
    git add $CURRENT_IP
    DATE=`date`
    git commit -m "Last update: $DATE"
    git push -f origin master
fi
