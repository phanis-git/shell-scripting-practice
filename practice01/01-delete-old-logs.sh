#!/bin/bash

IS_ROOT_USER=$(id -u)

if [ $IS_ROOT_USER -ne 0 ]; then 
    echo "Root user privilege is need to run this script"
    exit 1
fi 

SOURCE_DIRECTORY="/home/ec2-user/app-logs"

if [ ! -d $SOURCE_DIRECTORY ]; then
    echo "Error :: $SOURCE_DIRECTORY doesnot exist"
    exit 1
fi 

FILES_TO_DELETE=$(find $SOURCE_DIRECTORY -name "*.log" -type f -mtime +14)

while IFS= read -r file
do 
echo "Files to delete:: $file"

done <<< $FILES_TO_DELETE
    