#!/bin/bash

validate (){
    if [ $1 -ne 0 ]; then
    echo "Error :: installing $2 is Failed"
    exit 1
    else 
    echo "$2 Installing successfully"
    fi
}

# check user is root are not
is_root_user=$(id -u)
if [ $is_root_user -ne 0 ]; then
echo "Need root privilege"
exit 1
fi

dnf install mysql -y
validate $? "Mysql-server"
if [ $is_mysql_installed -eq 0 ]; then
    echo "Mysql installed successfully"
else 
    echo "Mysql installation failure"
fi