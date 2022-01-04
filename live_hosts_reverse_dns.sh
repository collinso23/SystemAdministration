#!/bin/bash
# Script takes a prefix followed by number of addresses to check. 
# It will then ping each of the IPS in the prefix and write the successes to Live_ips.txt
if [[ $# < "2" ]]; then
  echo "example usage: $(basename $0) 192.168.0 254"
  exit 1
fi

PREFIX=$1
HOST_RANGE=$2
DIR=$(pwd)
FILE="Live_ips.txt"

# Ping each address and if its up write result to $FILE
for addr in $(seq $HOST_RANGE); do 
  ping -q -c1 $PREFIX.$addr > /dev/null && echo $PREFIX.$addr up &
done > $DIR/$FILE

# Since jobs run in the background wait for $FILE to populate with IPs
timeout 20 bash << EOF
while [[ ! -s $DIR/$FILE ]]; do
  sleep 3
  echo Waiting for $FILE
done
EOF

# Run reverse DNS lookup and IPS to see their hostnames
for ip in $(awk '{print $1}'  $DIR/$FILE ); do
  echo "LIVE:$ip | DNS:$(dig +short -x $ip 2>&-)"; #Note '2>&-' close the stderr file descriptor. Supresses error messages output, and functions the same as 2>/dev/null
done
