# Setup Guide

## Requirements
- VirtualBox or VMware
- Kali Linux ISO
- Ubuntu 22.04 ISO
- 8GB RAM minimum on host

## VM Setup
| VM  | OS           | Role         | RAM |
|-----|--------------|--------------|-----|
| VM1 | Kali Linux   | Attacker     | 2GB |
| VM2 | Ubuntu 22.04 | Target/DVWA  | 2GB |
| VM3 | Ubuntu 22.04 | Splunk/ELK   | 4GB |

## Step 1: Install DVWA on VM2
```bash
sudo apt update
sudo apt install apache2 php php-mysqli mysql-server git -y
cd /var/www/html
sudo git clone https://github.com/digininja/DVWA.git
sudo systemctl start apache2
```

## Step 2: Install Splunk on VM3
```bash
wget -O splunk.deb 'https://download.splunk.com/products/splunk/releases/9.1.0/linux/splunk-9.1.0-linux-2.6-amd64.deb'
sudo dpkg -i splunk.deb
sudo /opt/splunk/bin/splunk start --accept-license
```

## Step 3: Run Attack Scripts from VM1 (Kali)
```bash
chmod +x attack-scripts/*.sh
./attack-scripts/sqli_test.sh http://VM2-IP
```

## Step 4: Check Detections in Splunk
- Open browser → http://VM3-IP:8000
- Go to Search → paste queries from siem-queries/splunk/
