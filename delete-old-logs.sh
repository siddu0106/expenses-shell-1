#!/bin/bash

SOURCE_DIRECTORY=/tmp/app-logs

FILES_TO_DELETE=$(find $SOURCE_DIRECTORY -name "*.log" -mtime +14)

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

touch -d 20240402 two.log

touch -d 20240421 twentyone.log

touch -d 20240412 twelve.log

touch -d 20240421 twentyone.java

touch -d 20240412 twelve.py


# 3. find the logs with .log extension

find . -name "*.log"  # . -> current directory, -name -> means we need files with .log extension

# 4. I want only log files with more than 2 weeks

#echo "Files to delete : ${FILES_TO_DELETE[@]}"

# 5. Using loop to remove the files one by one and print which file u deleted

# first way with for loop

# second way with while loop
#IFR = internal field seperator. here we are reading every line from the input $FILES_TO_DELETE and sepearte by the line 
while IFS= read -r line
do
    echo -e "$G Deleting the file: $line $N"
    rm -rf $line
    echo -e "$Y Deleted file is: $line $N"
done <<< $FILES_TO_DELETE # <<< - input, >>> - output


