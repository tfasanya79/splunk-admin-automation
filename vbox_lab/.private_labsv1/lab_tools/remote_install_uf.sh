#!/bin/bash

# Remote details
VM_USER=osboxes
VM_IP=192.168.0.70
VM_PASS=osboxes.org

# Universal Forwarder version
UF_VERSION=9.2.1
UF_BUILD=5e2c4f0f0c0e
UF_FILE=splunkforwarder-$UF_VERSION-$UF_BUILD-linux-2.6-amd64.deb
UF_URL="https://download.splunk.com/products/universalforwarder/releases/$UF_VERSION/linux/$UF_FILE"

# Install directory
REMOTE_HOME=/home/$VM_USER

echo "📥 Downloading Splunk UF installer..."
wget -O "$UF_FILE" "$UF_URL"

if [[ ! -f "$UF_FILE" ]]; then
    echo "❌ UF download failed. Aborting."
    exit 1
fi

echo "📤 Copying UF installer to the VM..."
sshpass -p "$VM_PASS" scp "$UF_FILE" $VM_USER@$VM_IP:$REMOTE_HOME

echo "💻 Installing Splunk Universal Forwarder on the VM..."
sshpass -p "$VM_PASS" ssh -o StrictHostKeyChecking=no $VM_USER@$VM_IP "bash -s" <<EOF
  echo "$VM_PASS" | sudo -S dpkg -i "$UF_FILE"
  sudo /opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --no-prompt --seed-passwd admin:changeme
  sudo /opt/splunkforwarder/bin/splunk enable boot-start

  echo "✅ Configuring UF to forward to Splunk Enterprise on localhost:9997"
  sudo /opt/splunkforwarder/bin/splunk add forward-server 127.0.0.1:9997 -auth admin:changeme
  sudo /opt/splunkforwarder/bin/splunk add monitor /var/log/syslog -auth admin:changeme
EOF

echo "✅ Splunk UF installed and forwarding logs to 127.0.0.1:9997"
