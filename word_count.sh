#!/bin/bash
# START SCRIPT

NUMLINES=1
TOTAL=0

while read LINE
do
	NUMCHAR=$(echo $LINE | wc -w)
	echo "Line $NUMLINES: $NUMCHAR"
	((NUMLINES++))
	TOTAL=$(($TOTAL+$NUMCHAR))
done
printf "Total: $TOTAL\n"

# END SCRIPT
