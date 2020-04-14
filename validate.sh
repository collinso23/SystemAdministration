#START SCRIPT
#!/bin/bash
set -eo pipefail

error() {
	printf "Error: $1\n"
	printf "$2 did not match $3\n"	
	exit 1	
}

read -p "Enter your first name: " firstname 
flgex="^[A-Z]([a-z]|[A-Z]|-){1,}+$" 
if [[ ! "$firstname" =~ $flgex ]]; then
	error "Firstname must start with a capital letter and contain only letters and hyphens!" "$flgex" "$firstname" 	
fi

read -p "Enter your last name: " lastname
if [[ ! "$lastname" =~ $flgex ]]; then
	error "Lastname must start with a capital letter and contain only letters and hyphens!" "$flgex" "$lastname" 	
fi

read -p "Enter your zip code: " zipcode
zipgex="^[0-9]{5}$"
if [[ ! "$zipcode"  =~ $zipgex ]]; then
	error "Zip must be exactly 5 digits" "$zipgex" "$zipcode"
fi

read -p "Enter you email address: " email
emgex="(\w|\.|-)+@(\w|\.|-)+.([a-z]|[A-Z])+"
if [[ ! "$email" =~ $emgex ]]; then
	error "Email address must be USER@DOMAIN, where both USER and DOMAIN must be only letters, numbers, dots, underscores, and hyphens!"$emgex $email
fi

printf "Validated: $firstname, $lastname, $zipcode, $email successfully!\n"
#END SCRIPT