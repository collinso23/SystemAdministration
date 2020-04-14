#!/bin/bash
#START SCRIPT

usage() {
    echo "Error: $1"
    exit 0
}

if [[ $# -ne 0 ]]; then

    usage "Wrong number of args"

fi


newfile="${1:-user_list}"

touch /tmp/pw.tmp

tempfile=/tmp/pw.tmp

while read line; do

    lastname=$(echo $line | cut -d, -f1)

    firstname=$(echo $line | cut -d, -f2)

    fletter=$(echo $line | cut -d, -f2 | head -c1 )

    name=$(echo "$firstname $lastname")

    newLogin=$(echo "${lastname}${fletter}" | tr "A-Z" "a-z")

    password=$(cat /dev/urandom | tr -dc 'A-Za-z0-9' | head -c 8)

    logCheck=$(cat /etc/passwd | grep -i $newLogin | cut -d: -f1)

    printf "Adding: ${name}: $newLogin, $password\n"

    printf "\n"

    if [[ "$newLogin" == "$logCheck" ]]; then

        count=0
        while [ "$newLogin" == "$logCheck" ]; do

            count=$(($count + 1 ))
            echo $count
            newLogin=$(echo ${newLogin}${count})

        done

        /usr/sbin/groupadd "$newLogin"
        /usr/sbin/useradd -c"$name" -d/home/"$newLogin" -g"$newLogin" -m -s/bin/bash "$newLogin"
        printf "\n"

    else

      /usr/sbin/groupadd "$newLogin"
      /usr/sbin/useradd -c"$name" -d/home/"$newLogin" -g"$newLogin" -m -s/bin/bash "$newLogin"
      printf "\n"
    fi

    echo "$password" > $tempfile

    cat $tempfile | /usr/bin/passwd --stdin $newLogin > /dev/null

done < "$newfile"


rm -r $tempfile

#END SCRIPT

