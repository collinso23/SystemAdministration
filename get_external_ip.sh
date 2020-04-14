#START SCRIPT
#!/bin/bash
set -eo pipefail
wget -q -O myip www.ipchicken.com
grep -oE "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" myip
rm myip
#END SCRIPT
