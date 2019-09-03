#!/bin/bash
HOME=/home/pi/bin
LOG="${HOME}/reconnect.log"
PID="${HOME}/reconnect.pid"
echo "[$(date)][Output] entry begin" >> $LOG
if [ -f "$PID" ]
then
   echo "[$(date)][Success] created pid file." >> $LOG
   exit 1
fi
if ping -c 1 www.google.com &> /dev/null
then
   echo "Network connectivity detected. No action required." >> $LOG
   exit 1
else
   echo "Network detected as down" >> $LOG
fi
touch $PID
echo "[$(date)][Success] created pid file." >> $LOG
echo "[$(date)][Success] cron job started..." >>$LOG
echo "[$(date)][Output]" >> $LOG
date >> $LOG
echo "" >> $LOG
sudo ifconfig eth0 down
sudo ifconfig eth0 up
rm $PID
echo "[$(date)][Success] removed pid file." >> $LOG
echo "[$(date)][Success] cron job finished." >> $LOG

exit 0

