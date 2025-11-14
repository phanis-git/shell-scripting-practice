#!/bin/bash

IS_ROOT_USER=$(id -u)

if [ $IS_ROOT_USER -ne 0 ]; then
    echo "Root user privilege is needed to run this script" | tee -a $LOG_FILE_NM
    exit 1
fi

# SOURCE_DIR="/home/ec2-user/source_directory"
# DESTINATION_DIR="/home/ec2-user/source_directory"
SOURCE_DIR=$1       #mandatory
DESTINATION_DIR=$2  #mandatory
DAYS=${3:-14}              #optional  here $3 means special variable , if user pass days it will consider , otherwise 14 days

if [ $# -lt 2 ]; then
    echo "Error :: sudo sh <file_name>.sh <source_directory_mandatory> <destination_directory_mandatory> <no_of_days_optional(default 14 days)>"
    exit 1
fi

LOGS_FOLDER="/var/log/shell-script-logs"
SCRIPT_NM=$(echo $0 | cut -d "." -f1)
mkdir -p "$LOGS_FOLDER"
LOG_FILE_NM="$LOGS_FOLDER/$SCRIPT_NM.log"


# find the files
# zip them
# move to destination
# then delete in the source directory

# check source and destination directory exist ot not

if [ ! -d $SOURCE_DIR ]; then
    echo "Source directory $SOURCE_DIR not exist" | tee -a $LOG_FILE_NM
    exit 1
fi 
if [ ! -d $DESTINATION_DIR ]; then
    echo "Destination directory $DESTINATION_DIR not exist" | tee -a $LOG_FILE_NM
    exit 1
fi 

dnf list installed zip
if [ $? -ne 0 ]; then
    dnf install zip -y
fi

FILES_TO_ZIP=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS )

# checking file is empty or doesnot have content inside
if [ ! -z "${FILES_TO_ZIP}" ]; then
# zip them
    TIMESTAMP=$(date +%F-%H:%M)
    ZIP_FILE_NM="$DESTINATION_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NM"

# check file is zipped or not
if [ -f $ZIP_FILE_NM ]; then
    echo "Successfully archieved $ZIP_FILE_NM" | tee -a $LOG_FILE_NM
    while IFS= read -r filepath
    do
    rm -rf "$filepath"
    done <<< "$FILES_TO_ZIP"
else
    echo "Issue while archieve"  | tee -a $LOG_FILE_NM
    exit 1
fi   
# move to destination directory

else
    echo "No files to archieve" | tee -a $LOG_FILE_NM
# No files to archieve
fi


