# Project Report: Web Attack Detection in SIEM

## Abstract

This project demonstrates an end-to-end security monitoring workflow: simulating common web application attacks against a deliberately vulnerable target, then detecting those attacks using a Security Information and Event Management (SIEM) platform. The goal was to gain hands-on experience with both offensive techniques (red team) and detection engineering (blue team), which together form the core skill set of a SOC Analyst or Security Engineer.

---

## 1. Introduction

Web applications are among the most common attack surfaces in modern IT environments. Attacks such as SQL Injection, Cross-Site Scripting (XSS), Path Traversal, and credential brute-forcing remain prevalent because input validation and access control are frequently misconfigured. While many resources teach these attacks in isolation, fewer connect the attack side to detection engineering — understanding what evidence an attack leaves behind in logs, and how to write queries that surface that evidence reliably.

This project was built to close that gap by combining attack simulation with detection rule development in a real SIEM platform, in a fully isolated, legal lab environment.

## 2. Objectives

- Build a controlled, isolated lab environment for safely simulating attacks
- Simulate four major web attack classes: SQL Injection, XSS, Path Traversal, and Brute Force
- Forward web server logs into a SIEM platform (Splunk or ELK Stack)
- Develop detection queries that identify each attack class from raw logs
- Create dashboards and alerts to visualize and respond to detected threats

## 3. Lab Architecture

The environment consists of three isolated virtual machines connected on a host-only network, ensuring no attack traffic reaches external networks.

| Component | Role | OS / Software |
|---|---|---|
| Attacker VM | Generates attack traffic | Kali Linux, Metasploit, sqlmap, Hydra, Nikto |
| Target VM | Hosts the vulnerable application | Ubuntu 22.04, Apache, PHP, MySQL, DVWA |
| SIEM VM | Collects logs and runs detection | Splunk Free or ELK Stack (Elasticsearch, Logstash, Kibana) |

**Data flow:**

```
Kali Linux (Attacker)
       │  HTTP requests (malicious payloads)
       ▼
DVWA Target (Apache access logs)
       │  Forwarded via Splunk Universal Forwarder / Filebeat
       ▼
SIEM Platform (Splunk / ELK)
       │  Detection queries + correlation
       ▼
Alerts & Dashboards
```

The target application used is DVWA (Damn Vulnerable Web Application), an intentionally insecure PHP/MySQL application designed for security training. Security level was set to "low" to ensure attacks succeed and generate representative log data.

## 4. Methodology

### 4.1 Environment Provisioning
Three VMs were provisioned in VirtualBox, networked together on a host-only adapter. Apache logging was configured to use the "combined" log format to capture full request URIs, status codes, and client IPs — the fields needed for later detection.

### 4.2 Log Pipeline
A Splunk Universal Forwarder (or Filebeat, for the ELK variant) was installed on the target VM and configured to monitor `/var/log/apache2/access.log`. Logs were shipped to the SIEM VM over port 9997 (Splunk) or indexed directly into Elasticsearch (ELK).

### 4.3 Attack Simulation
Each attack class was simulated using purpose-built tooling rather than manual requests, to produce realistic traffic volume and variety:

- **SQL Injection** — automated using `sqlmap` against DVWA's SQLi module, testing UNION-based and boolean-based injection techniques
- **Cross-Site Scripting (XSS)** — reflected XSS payloads sent via `curl`, including raw, URL-encoded, and event-handler-based variants
- **Path / Directory Traversal** — file inclusion payloads targeting `/etc/passwd`, tested with plain, single-encoded, and double-encoded path strings
- **Brute Force** — credential stuffing against the DVWA login form using `hydra` with a standard wordlist

### 4.4 Detection Engineering
For each attack class, the resulting Apache logs were inspected to identify distinguishing patterns — specific keywords, encoding signatures, or request-frequency anomalies. Detection queries were then written in Splunk's SPL and, separately, in Kibana's KQL, so the project is portable across either SIEM platform.

### 4.5 Alerting and Visualization
Detection queries were converted into scheduled Splunk alerts (5-minute intervals) and a dashboard was built showing top attacking IPs, attack-type breakdown over time, and HTTP error code distribution.

## 5. Detection Logic Summary

| Attack Type | Log Indicator | Detection Approach |
|---|---|---|
| SQL Injection | `UNION`, `SELECT`, `'OR'`, `1=1` in URI | Keyword match + per-IP frequency threshold |
| XSS | `<script>`, `alert(`, `onerror=`, URL-encoded equivalents | Keyword match on request parameters |
| Path Traversal | `../`, `%2e%2e%2f`, double-encoded variants, `etc/passwd` | Pattern match across encoding layers |
| Brute Force | Repeated POST to login endpoint, HTTP 401/403 | Time-bucketed count threshold (10+ attempts/60s) |
| General anomaly | Spike in HTTP 4xx/5xx responses | Time-bucketed status code aggregation |

## 6. Results

The lab successfully demonstrated that all four attack classes leave identifiable, queryable signatures in standard Apache access logs. Key observations:

- SQL injection and XSS attempts were reliably caught through keyword and pattern matching alone, with low false-positive risk in a single-application environment
- Path traversal required matching multiple encoding layers (plain, single, and double URL-encoding) since attackers commonly obfuscate payloads to evade naive filters
- Brute force attacks were not detectable through keyword matching at all — they required frequency-based, time-windowed logic, illustrating that detection strategy must match attack behavior, not just attack content
- Combining all detections into a single dashboard provided a practical, SOC-style view of attacker activity across the session

## 7. Limitations

- This is a single-host, low-security-level test; detection logic is tuned for clarity rather than production-grade evasion resistance
- Real-world attackers increasingly use techniques that don't leave obvious keyword signatures (e.g. blind SQLi, time-based payloads), which the current rule set does not address
- The lab uses HTTP only; HTTPS traffic inspection would require TLS termination or endpoint-level logging instead of network-level log capture

## 8. Future Work

- Add detection coverage for blind/time-based SQL injection
- Incorporate Suricata or Zeek for network-level detection alongside application logs
- Test detection rules against a higher DVWA security level to evaluate evasion resistance
- Build a MITRE ATT&CK mapping for each detection rule to align with industry-standard frameworks

## 9. Conclusion

This project provided practical, end-to-end experience spanning both offensive simulation and defensive detection engineering. It reinforced that effective detection depends not just on knowing what an attack looks like, but on understanding how it manifests in logs — and that different attack types (content-based vs. behavior-based) require fundamentally different detection strategies. The resulting query library and dashboard serve as a reusable starting point for further blue-team detection work.

---

## Repository Structure

```
web-attack-detection-siem/
├── README.md
├── PROJECT_REPORT.md
├── docs/
│   └── setup-guide.md
├── attack-scripts/
│   ├── sqli_test.sh
│   ├── xss_test.sh
│   ├── bruteforce_test.sh
│   └── traversal_test.sh
├── siem-queries/
│   ├── splunk/
│   └── elk/
├── configs/
└── screenshots/
```

## Disclaimer

All testing in this project was performed exclusively against intentionally vulnerable applications (DVWA) within an isolated, host-only virtual network with no internet-facing exposure. None of the techniques described here should be used against systems without explicit authorization.

## License

MIT License
