#!/bin/bash 

IS_ROOT_USER=$(id -u)

# check root user or not
if [ $IS_ROOT_USER -ne 0 ]; then
    echo "Root user privilege is needed to run this script" | tee -a $LOG_FILE_NM
    exit 1
fi

# storing logs in log file by creating a folder
LOGS_FOLDER="/var/log/shell-script-logs"
SCRIPT_NM=$( echo $0 | cut -d "." -f1 )
LOG_FILE_NM="$LOGS_FOLDER/$SCRIPT_NM.log"

mkdir -p $LOGS_FOLDER

SOURCE_DIR="/home/ec2-user/logs"

if [ ! -d $SOURCE_DIR]; then
    echo "Source directory not exist" | tee -a $LOG_FILE_NM
    exit 1
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f -mtime +14)

while IFS= read -r filepath
do 
echo "Deleting the file: $filepath"  | tee -a $LOG_FILE_NM
rm -rf $filepath
echo "Deleted the file: $filepath"  | tee -a $LOG_FILE_NM
done <<< $FILES_TO_DELETE





