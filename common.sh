#!/bin/bash

set -e

handle_error() {
  echo "Failed at $1, Error Command is: $2"
}

trap 'handle_error ${LINENO} "$BASH_COMMAND"' ERR

DATE=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f 1) # removing .sh in file name
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER=$(id -u)

CHECK_ROOT()
{
    if [ $USER -ne 0 ]
    then 
        echo -e " $R Be a root user to install any package... $N"
        exit 1 # manually stop without continue
    else 
        echo "Root user"
    fi
}


VALIDATE()
{
    if [ $1 -ne 0 ]
    then    
        echo -e "$2 is $R failed...$N" 
        exit 1
    else 
        echo -e "$2 is $G Success...$N"
    fi
}