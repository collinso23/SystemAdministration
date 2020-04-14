#START SCRIPT
#!/bin/bash

set -eo pipefail

error() {
	printf "Error: $1\n"
	exit 1
}

infile=$1
outfile=$2
findstr=$3
replacestr=$4

if [[ $# -ne 4 ]]; then
	error "Requires exactly 4 arguments"
elif [[ ! -f "$infile"  ]]; then
	error "$infile must be valid file"
fi

sed s/"$findstr"/"$replacestr"/g $infile > $outfile

cat $outfile
#END SCRIPT
