#!/bin/bash

SOURCE_DIRECTORY=/tmp/app-logs

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# 1. check whether directory exists or not

if [ -d $SOURCE_DIRECTORY ]
then
    echo -e "$G $SOURCE_DIRECTORY exixts... $N"
else 
    echo -e "$R $SOURCE_DIRECTORY doesn't exixts... $N"
fi

cd /tmp/app-logs

# 2. create few empty files for past date and current date 

touch sample

touch -d 20240401 first.log

touch -d 20240421 twentyone.log

touch -d 20240412 twelve.log

touch -d 20240421 twentyone.java

touch -d 20240412 twelve.py


# 3. find the logs with .log extension

find . -name "*.log"  # . -> current directory, -name -> means we need files with .log extension
