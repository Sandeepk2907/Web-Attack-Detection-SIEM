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
- `attack-scripts/` — Shell scripts to simulate attacks
- `siem-queries/splunk/` — Splunk SPL detection queries
- `siem-queries/elk/` — Kibana KQL detection queries
- `configs/` — Config files for Filebeat and Splunk Forwarder
- `docs/` — Setup guide and architecture diagram
- `screenshots/` — Project screenshots

##  Setup Guide
See [docs/setup-guide.md](docs/setup-guide.md)

##  Disclaimer
For **educational purposes only**.
All attacks performed in an isolated lab environment.
Do NOT use on systems you don't own.

##  License
MIT License
