#!/bin/bash
red="\e[31m"
green="\e[32m"
normal="\e[0m"
# echo -e "$red RED $normal"
# echo -e "$green Green $normal"



validate (){
    if [ $1 -ne 0 ]; then
    echo "Error :: installing $2 is $red Failed $normal" 
    exit 1
    else 
    echo "$2 $green Installing successfully $normal"
    fi
}

# check user is root are not
is_root_user=$(id -u)
if [ $is_root_user -ne 0 ]; then
echo "Need root privilege"
exit 1
fi

mkdir -p /var/log/shell-script-practice
log_file="$0.log"
if [ !$log_file ]; then
touch  $log_file
fi

dnf list installed mysql 
if [ $? -ne 0 ]; then
dnf install mysql -y &>> $log_file
validate $? "Mysql-server"
else 
echo "Mysql server is already installed" | tee -a $log_file
fi 

echo "$$"