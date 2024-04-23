#!/bin/bash

# pwd u have to enter ExpenseApp@1
echo "Enter Password: "
read -s PASS

source ./common.sh

CHECK_ROOT

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "MYSQL Installation"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling Mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting Mysql server"

systemctl status mysqld &>>$LOGFILE
VALIDATE $? "Status of Mysql server"

# If u run this command second time it will fail, bcz already password set
# Error - Password already set, You cannot reset the password with mysql_secure_installation

#mysql_secure_installation --set-root-pass ExpenseApp@1  &>>$LOGFILE 
#VALIDATE $? "Setting up root pwd for Mysql server"

# below one is to check pwd already setup or not. If not then setup.
mysql -h mysql.projexpenses78.online -uroot -p$PASS -e 'show databases;'

if [ $? -ne 0 ]
    then    
        mysql_secure_installation --set-root-pass $PASS  &>>$LOGFILE 
        VALIDATE $? "Setting up root pwd for Mysql server"
       
    else 
        echo -e " $Y Password already setup for MYSQL...$N" 
fi 





