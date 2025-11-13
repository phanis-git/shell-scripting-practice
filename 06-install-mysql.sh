#!/bin/bash

# check user is root are not
is_root_user=$(id -u)
if [ $is_root_user -ne 0 ]; then
echo "Need root privilege"
exit 1
fi

dnf install mysql -y
is_mysql_installed=$?
if [ $is_mysql_installed -eq 0 ]; then
    echo "Mysql installed successfully"
else 
    echo "Mysql installation failure"
fi