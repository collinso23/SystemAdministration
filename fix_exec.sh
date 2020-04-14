#!/bin/bash
# START SCRIPT

error() {
    printf "Error: $1\n"
    exit 0
}

if [[ $# -ne 1 ]]; then
    error "Requires exactly one argument"
fi

if [[ ! -f $1 ]]; then 
    error "Must be a file"
fi

permissions=$(ls -l $1)
if  file -b $1 | grep -ioq "executable"; then
  if ! echo ${permissions:1:9} | grep -iq 'x'; then
        read -n1 -p "Make $1 executable? [y/N] " makexe
        echo ""
        case $makexe in
            y|Y) chmod +x $1;;
            n|N) continue ;;
        esac
    elif echo ${permissions:1:9} | grep -iq 'x'; then
        read -n1 -p "Remove executable permissions from $1? [y/N] " removexe
        echo ""
        case $removexe in
            y|Y) chmod -x $1;;
            n|N) continue ;;
        esac
    fi
    echo $(ls -l $1)
else
  chmod -x $1
  error "Must be an executable file"
fi
