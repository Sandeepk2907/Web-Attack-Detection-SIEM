#  Web Attack Detection in SIEM

Simulate common web attacks and detect them using Splunk or ELK Stack SIEM.

##  Project Overview
This project demonstrates how to:
- Set up a vulnerable web app (DVWA) as a target
- Simulate real attacks using Kali Linux tools
- Collect and analyze logs in a SIEM
- Write detection queries for SQLi, XSS, Brute Force, Path Traversal

##  Tech Stack
- **Attacker:** Kali Linux, Metasploit, sqlmap, Hydra
- **Target:** Ubuntu + DVWA + Apache
- **SIEM:** Splunk Free / ELK Stack
- **Log Shipping:** Splunk Universal Forwarder / Filebeat

##  Architecture
Kali (Attacker) → DVWA Target → Apache Logs → Splunk/ELK → Alerts

##  Folder Structure

```plaintext
web-attack-detection-siem/
│
├── README.md
│
├── docs/
│   ├── setup-guide.md
│   └── architecture.png
│
├── attack-scripts/
│   ├── sqli_test.sh
│   ├── xss_test.sh
│   ├── bruteforce_test.sh
│   └── traversal_test.sh
│
├── siem-queries/
│   ├── splunk/
│   │   ├── sqli_detection.spl
│   │   ├── xss_detection.spl
│   │   ├── bruteforce_detection.spl
│   │   └── error_spike_detection.spl
│   │
│   └── elk/
│       ├── sqli_detection.kql
│       ├── xss_detection.kql
│       └── bruteforce_detection.kql
│
├── configs/
│   ├── filebeat.yml
│   ├── splunk-forwarder-config.txt
│   └── dvwa-config.php
│
|── screenshots/
|   ├── dvwa-setup.png
|   ├── splunk-dashboard.png
│
└── report/
    └── PROJECT_REPORT.md
```


##  Setup Guide
See [docs/setup-guide.md](docs/setup-guide.md)

##  Disclaimer
For **educational purposes only**.
All attacks performed in an isolated lab environment.
Do NOT use on systems you don't own.

##  License
MIT License
