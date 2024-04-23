#!/bin/bash

source ./common.sh

CHECK_ROOT

dnf install nginx -y  &>>$LOGFILE
VALIDATE $? "Installing Nginx"

systemctl enable nginx &>>$LOGFILE
VALIDATE $? "Enable Nginx"

systemctl start nginx &>>$LOGFILE
VALIDATE $? "Start nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE $? "downloaded to tmp folder"

cd /usr/share/nginx/html &>>$LOGFILE

unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE $? "unzip to nginx/html folder"

cp /home/ec2-user/expenses-proj-shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Copied expense.conf to nginx folder"

systemctl restart nginx &>>$LOGFILE
VALIDATE $? "Restarting nginx"

systemctl status nginx &>>$LOGFILE
VALIDATE $? "status nginx"



