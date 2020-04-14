#!/bin/bash

# START SCRIPT
set -eo pipefail

error() {
	printf "Error: $1\n"
	printf "Usage: $0\n"
	exit 1
}


if [[ "$#" -ne 3 ]]; then 
	error "Requires 3 Args"
fi

if [[ ! -f "$3" ]]; then
	error "Arugment must contain normal file!"
fi

LINENUM="$(wc -l $3 | cut -d' ' -f1)"

if [[ $1 -ge $2 ]]; then 	
	error "Arg: $2 must be greater than Arg: $1"
elif [[ $LINENUM -lt $2 ]]; then
	error "Actual line_num less than Arg: $2"
else
	cat $3 | head -n$2 | tail -n$(($2-$1+1))
fi
# END SCRIPT
