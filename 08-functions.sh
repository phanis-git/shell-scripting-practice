#!/bin/bash

validate (){
    if [ $1 -ne 0 ]; then
    echo "Error :: installing $2 is Failed"
    exit 1
    else 
    echo "$2 Installing successfully"
    fi
}