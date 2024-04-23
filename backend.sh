#!/bin/bash

# pwd u have to enter ExpenseApp@1
echo "Enter Password: "
read -s PASS

source ./common.sh

CHECK_ROOT


dnf module list &>>$LOGFILE
VALIDATE $? "Listing all Available modules"

dnf module disable nodejs -y &>>$LOGFILE
VALIDATE $? "Disabling Node.js 18 version"

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "Enable Node.js 20 version"

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "Install Node.js 20 version"

# check whether user exists or not. If not exist add the user. 
# If user exists then it will return 0, if not 1.
id expense 

if [ $? -ne 0 ]
then    
    useradd expense &>>$LOGFILE
    VALIDATE $? "Adding expense user"
else    
    echo -e "$Y expense user already exists... $N"
fi

# we have to check whether folder exists or not.. if not then create.. otherwise skip it
#In linux for folder we have '-p' - It will check folder exists or not. If not it will create otherwise didn't give anything
mkdir -p /app

# check for file exixts or not
if [ -e /tmp/backend.zip ]
then
    echo -e "$Y backend.zip file already exist in tmp directory...$N"
else
    #Actually no need to check for .zip file bcz we can run this multiple times also, it won't throw any error. But am checking simply
    curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
    VALIDATE $? "Downloading backend code to tmp folder"
fi


cd /app
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "Unzipping backend code to app folder"

npm install &>>$LOGFILE
VALIDATE $? "Installing node.js dependencies"

cp /home/ec2-user/expenses-proj-shell/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "Copied backend service to systemd/system folder"

systemctl daemon-reload &>>$LOGFILE
systemctl start backend &>>$LOGFILE
systemctl enable backend &>>$LOGFILE
VALIDATE $? "Checking start, enable & status for backend service with systemctl commands"

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "installing mysql client"

# eventhough we load schema multiple time no pblm bcz they mentioned in backend.sql file if exists then only create otherwise no need
mysql -h mysql.projexpenses78.online -uroot -p$PASS < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "Loading schema to MYSQL"

systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restarting backend service"

systemctl status backend &>>$LOGFILE
VALIDATE $? "checking backend service status"
