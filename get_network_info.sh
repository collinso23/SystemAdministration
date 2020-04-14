#!/bin/bash
#START SCRIPT
bkupIFS="$IFS"

ipaddr=$(ip a show dev ens33 | grep -i "\inet\b" | awk '{print $2}')
dhcpen=$(ip a show dev ens33 | grep -i "\inet\b" | grep -io "dynamic")
echo "$dhcpen IPv4 address: $ipaddr"

ethaddr=$(ip a show dev ens33 | grep -i "\ether\b" | awk '{print $2}')
echo "MAC address: $ethaddr"

defaultgateway=$(ip r | grep -i "\default\b" | awk '{print $3}')
echo "Gateway router: $defaultgateway"

nameserver=$(cat /etc/resolv.conf | grep -i "nameserver" | awk '{print $2}' | sed ':a;N;$!ba;s/\n/,/g')
IFS=',' read -a namarr <<< "$nameserver"
for n in "${namarr[@]}"; do
  echo "DNS server: $n"
done

searchname=$(cat /etc/resolv.conf | grep -i "search" | sed "s/search//")
IFS=' ' read -a serarr <<< "$searchname"
for s in "${serarr[@]}"; do 
  echo "DNS domain: $s"
done

nicspeed=$(ethtool ens33 | grep -i "speed" | awk '{print $2}')
echo "NIC speed: $nicspeed"

nicduplex=$(ethtool ens33 | grep -i "\duplex\b" | awk '{print $2}')
echo "NIC duplex: $nicduplex"
IFS="$bkupIFS"
#END SCRIPT
