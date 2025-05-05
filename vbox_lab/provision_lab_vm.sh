#!/bin/bash

# === 1. Update OS and install base packages ===
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget unzip git python3 python3-pip net-tools ufw

# === 2. Create Splunk user and install Splunk ===
sudo useradd -m splunk
cd /tmp
wget -O splunk.tgz "https://download.splunk.com/products/splunk/releases/9.2.1/linux/splunk-9.2.1-xxxxxxx-linux-2.6-amd64.tgz"
sudo tar -xzf splunk.tgz -C /opt
sudo chown -R splunk:splunk /opt/splunk

# === 3. Start Splunk (accept license) ===
sudo -u splunk /opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt

# === 4. Enable Splunk to start on boot ===
sudo -u splunk /opt/splunk/bin/splunk enable boot-start -user splunk

# === 5. Clone your automation project ===
cd ~
git clone https://github.com/your-org/splunk-admin-automation.git
cd splunk-admin-automation

# === 6. Install Python dependencies ===
pip3 install -r requirements.txt

# === 7. Sample Splunk config setup ===
cp config/splunk_instances.yaml config/splunk_instances.local.yaml
echo "# ✅ Please update 'splunk_instances.local.yaml' with your Splunk hostname and credentials"

# === 8. Optional: Enable firewall and allow Splunk web UI ===
sudo ufw allow 8000/tcp
sudo ufw allow ssh
sudo ufw --force enable

echo "✅ Provisioning complete. Access Splunk via http://<VM-IP>:8000"
