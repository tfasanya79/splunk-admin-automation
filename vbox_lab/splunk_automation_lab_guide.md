
# 🧪 Splunk Admin Automation Lab (VirtualBox Edition)

This lab sets up a full testing environment for demonstrating and validating Splunk admin automation using Python scripts.

---

## 🖥️ Lab Overview

| Component       | Details                   |
| --------------- | ------------------------- |
| VM Base OS      | Ubuntu 22.04 LTS          |
| Splunk          | Enterprise Trial (latest) |
| Automation Code | `splunk-admin-automation` |
| Tools           | Python 3, Git, curl, pip  |

---

## 📦 Part 1: VM Setup in VirtualBox

1. **Create a new VM** in VirtualBox:

   * Name: `Splunk-Automation-Lab`
   * Type: Linux
   * Version: Ubuntu (64-bit)
   * RAM: 4096 MB
   * CPUs: 2
   * HDD: 40 GB (dynamically allocated)

2. **Install Ubuntu 22.04 LTS** from ISO.

3. **Post-installation Setup**:

   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo apt install -y wget curl unzip git python3 python3-pip
   ```

---

## 🚀 Part 2: Install Splunk

1. **Download Splunk Enterprise**:

   ```bash
   wget -O splunk.tgz "https://download.splunk.com/products/splunk/releases/9.2.1/linux/splunk-9.2.1-xxxxxxx-linux-2.6-amd64.tgz"
   ```

2. **Install Splunk**:

   ```bash
   sudo tar -xzvf splunk.tgz -C /opt
   sudo useradd splunk
   sudo chown -R splunk:splunk /opt/splunk
   ```

3. **Start Splunk as `splunk` user**:

   ```bash
   sudo su - splunk
   /opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt
   ```

4. **Access Splunk Web**:

   * URL: `http://<VM-IP>:8000`
   * User: `admin`
   * Password: your set password

---

## 🧰 Part 3: Deploy the Automation Code

1. **Clone the project**:

   ```bash
   git clone https://github.com/your-org/splunk-admin-automation.git
   cd splunk-admin-automation
   ```

2. **Install Python dependencies**:

   ```bash
   pip3 install -r requirements.txt
   ```

3. **Configure your environment**:

   ```bash
   cp config/splunk_instances.yaml config/splunk_instances.local.yaml
   # Edit the local file with your Splunk host, username, and password
   ```

---

## ⚙️ Part 4: Try It Out

### 🔹 Create an index

```bash
python3 scripts/deploy_indexes.py --env dev --index_name test_index --retention 90d
```

### 🔹 Run a manual health check

```bash
python3 -c "from modules.health_monitoring import get_indexer_health; get_indexer_health('dev')"
```

### 🔹 Start scheduled health checks

```bash
python3 scripts/start_health_scheduler.py --env dev
```

### 🔹 Send test email alert

```bash
python3 -c "from modules.email_notifications import send_email_notification; send_email_notification('Splunk Alert', 'Test email sent from automation lab')"
```

---

## 🛑 Cleanup / Reset

```bash
/opt/splunk/bin/splunk stop
rm -rf /opt/splunk/var/lib/splunk/*
```

---

## 🧪 Extra Tips

* Access logs: `/opt/splunk/var/log/splunk/`
* Restart Splunk: `/opt/splunk/bin/splunk restart`
* Use `screen` or `tmux` to keep long-running jobs persistent
* Add `.env` file for reusable variables if preferred

