#!/bin/bash
# START SCRIPT
set -eo pipefail
error() {
	printf "Error: $1\n"
	printf "Usage: $0\n"
	exit 1
}
read -p "Enter an int: " INT1
read -p "Enter another int: " INT2
read -p "Enter an operation (add,sub,mul,div,exp): " OPPER

OPPERERATION=$(printf "%s" $OPPER | tr [:upper:] [:lower:])
case "$OPPERERATION" in 
	"add") echo "$INT1+$INT2=$(($INT1+$INT2))"
	;;
	"mul") echo "$INT1*$INT2=$(($INT1*$INT2))"
	;;
	"sub") echo "$INT1-$INT2=$(($INT1-$INT2))"
	;;
	"div") echo "$INT1/$INT2=$(($INT1/$INT2))"
	;;
	"exp") echo "$INT1^$INT2=$(($INT1**$INT2))"
	;;
	*) error "Unable to find OPPEReration"
	;;
esac

# END SCRIPT
