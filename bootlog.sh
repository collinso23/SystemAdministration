#Start script
#!/bin/bash
usage() {
  echo "Usage: ./bootlog.sh boot|shutdown"
  echo "Error: $1"
  exit 0
}

if [[ $# -ne 1 ]]
then
  usage "Wrong number of args"
else
   case $1 in
      boot)
      date >> boot.log
      echo "$HOSTNAME booted!" >> boot.log
      ;;
      shutdown)
      date >> boot.log
      echo "$HOSTNAME shutdown!" >> boot.log  
      ;;
      *)
       usage "Program failed, wrong input!"
        ;;
   esac
        fi
#End script
