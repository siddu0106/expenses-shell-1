#!/bin/bash

set -e

failure() {
  echo "Failed at $1: $2"
}

trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

USER=$(id -u) #ERR - it's a signal

if [ $USER -ne 0 ]
then 
    echo "Be a root user to install any package..."
    exit 1 # manually stop without continue
else 
    echo "Root user"
fi

dnf install mysqll -y

dnf install git -y

