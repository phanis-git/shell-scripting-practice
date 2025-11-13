#!/bin/bash
red="\e[31m"
green="\e[32m"
normal="\e[0m"
# echo -e "$red RED $normal"
# echo -e "$green Green $normal"



validate (){
    if [ $1 -ne 0 ]; then
    # echo "Error :: installing $2 is $red Failed $normal" 
    echo -e "$(date +'%F %T') | Error :: installing $2 is ${red}Failed${normal}" | tee -a "$log_file"
    exit 1
    else 
    # echo "$2 $green Installing successfully $normal"
     echo -e "$(date +'%F %T') | $2 ${green}Installed successfully${normal}" | tee -a "$log_file"
    fi
}

# check user is root are not
is_root_user=$(id -u)
if [ $is_root_user -ne 0 ]; then
# echo "Need root privilege" 
 echo -e "$(date +'%F %T') | ${red}Need root privilege${normal}" | tee -a "$log_file"
exit 1
fi

mkdir -p /var/log/shell-script-practice
log_file="/var/log/shell-script-practice/$(basename "$0").log"
if [ ! -f "$log_file" ]; then
touch  "$log_file"
fi

# Add start time in log
echo "------------------------------" | tee -a "$log_file"
echo "$(date +'%F %T') | Script started" | tee -a "$log_file"

dnf list installed mysql 
if [ $? -ne 0 ]; then
dnf install mysql -y &>> "$log_file"
validate $? "Mysql-server"
else 
# echo "Mysql server is already installed" | tee -a "$log_file"
echo "$(date +'%F %T') | MySQL server is already installed" | tee -a "$log_file"

fi 

# Add end time in log
echo "$(date +'%F %T') | Script completed" | tee -a "$log_file"