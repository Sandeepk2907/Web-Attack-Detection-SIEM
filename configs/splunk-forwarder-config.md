# Web Attack Detection in SIEM – Splunk Universal Forwarder Setup

This project configures Splunk Universal Forwarder on the DVWA target machine (VM2) and forwards Apache access logs to the Splunk server.

---

## Step 1: Install Splunk Universal Forwarder

Run:

```bash
sudo dpkg -i splunkforwarder.deb
```
---

## Step 2: Start Forwarder

Run:

```bash
sudo /opt/splunkforwarder/bin/splunk start --accept-license
```

---

## Step 3: Connect to Splunk Server

Replace `SPLUNK_VM_IP` with your Splunk machine IP.

Example:

```bash
sudo /opt/splunkforwarder/bin/splunk add forward-server SPLUNK_VM_IP:9997
```

## Step 4: Monitor Apache Logs

Run:

```bash
sudo /opt/splunkforwarder/bin/splunk add monitor /var/log/apache2/access.log
```

## Step 5: Restart Forwarder

Run:

```bash
sudo /opt/splunkforwarder/bin/splunk restart
```


