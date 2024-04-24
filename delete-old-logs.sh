#!/bin/bash

SOURCE_DIRECTORY=/tmp/app-logs

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#check whether directory exists or not

if [ -d $SOURCE_DIRECTORY ]
then
    echo -e "$G $SOURCE_DIRECTORY exixts... $N"
else 
    echo -e "$R $SOURCE_DIRECTORY doesn't exixts... $N"
fi