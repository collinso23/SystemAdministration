#START SCRIPT
#!/bin/bash

infile=/etc/passwd

cat $infile | awk -F: '{
if($3 < 1000 );

else if ($7 != "/bin/bash")
print $1"*";

else print $1;}'


#END SCRIPT
