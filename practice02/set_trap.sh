#!/bin/bash

set -euo pipeline

trap 'echo "Error occured in $LINENO" | tee -a $FINAL_PATH' ERR

LOGS_FOLDER_NAME="/var/log/shell-script-logs"
mkdir -p $LOGS_FOLDER_NAME
LOG_FILE_NAME=$(echo $0 | cut -d "." -f1)
FINAL_PATH="$LOGS_FOLDER_NAME/$LOG_FILE_NAME.log"

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
	echo "Root user privilege is need to run this script"  | tee -a $FINAL_PATH
	exit 1
fi
asbfhil
apt update &>>$FINAL_PATH
if [ $? -ne 0 ]; then
	echo "Latest package update - failed"  | tee -a $FINAL_PATH
else
	echo "Latest packages update - success"  | tee -a $FINAL_PATH
fi

apt install nginx -y &>>$FINAL_PATH
if [ $? -ne 0 ]; then
	echo "Nginx not installed - failed"  | tee -a $FINAL_PATH
	exit 1
else 
	echo "Nginx installed - success" | tee -a $FINAL_PATH
fi
