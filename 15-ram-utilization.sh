#!/bin/bash

# check user is root or not
# use free command for checking ram 
# process the output
# put some threshold value for condition check
# If value exceeds need to trigger mail

# Mail sending we can install it first 
# make content prepared to send a perfect mail
# prepare script as a command so that we can place it in cron tab also

# check user is root or not

IS_ROOT_USER=$(id -u)
if [ $IS_ROOT_USER -ne 0 ]; then
    echo "Root privilege is need to run this script"
    exit 1
fi

# INSTALL mail 
dnf list installed msmtp
if [ $? -ne 0 ]; then
    dnf install msmtp -y
fi

AVAILABLE_RAM=$(free | grep -v available |  grep  Mem: | awk '{print $7}')
FREE_RAM=$(free | grep -v available |  grep  Mem: | awk '{print $4}')
THRESHOLD_RAM=10 # percentage
USED_RAM=$(free | grep -v available | grep  Mem: | awk '{print $3}')
TOTAL_RAM=$(free | grep -v available | grep  Mem: | awk '{print $2}')
MESSAGE=""
# calculation usedram * 100 / total ram = used percentage in ram
FORMATTED_RAM=$(($USED_RAM*100 / $TOTAL_RAM))
if [ $FORMATTED_RAM -gt $THRESHOLD_RAM ]; then
    echo "More ram consumed :: $FORMATTED_RAM %"
    MESSAGE="More Ram Consuming :: $FORMATTED_RAM %"
sh ram-mail.sh "phanipspkmec@gmail.com" "High Ram Alert" "$MESSAGE"
fi



