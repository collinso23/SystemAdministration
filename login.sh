#!/bin/bash

#START SCRIPT
NAME="$(cat /etc/passwd | grep $USERNAME | cut -d: -f5)"
printf "Welcome to $HOSTNAME, $NAME\n"
printf "You are logged in as $USERNAME and your current directory is $PWD\n"
printf "The current time is $(date +%l:%M%P)\n"
#END SCRIPT
