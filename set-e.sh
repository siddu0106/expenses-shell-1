#!/bin/bash

set -e

USER=$(id -u)

if [ $USER -ne 0 ]
then 
    echo "Be a root user to install any package..."
    exit 1 # manually stop without continue
else 
    echo "Root user"
fi

dnf install mysqll -y

dnf install git -y

