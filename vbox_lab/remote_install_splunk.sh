#!/bin/bash

# === CONFIGURATION ===
VM_IP="192.168.0.70"
VM_USER="osboxes"
VM_PASS="osboxes.org"
SPLUNK_VERSION="9.4.2"
SPLUNK_HASH="e9664af3d956"
SPLUNK_FILENAME="splunk-${SPLUNK_VERSION}-${SPLUNK_HASH}-linux-amd64.deb"
SPLUNK_URL="https://download.splunk.com/products/splunk/releases/${SPLUNK_VERSION}/linux/${SPLUNK_FILENAME}"

# === CHECK DEPENDENCIES ===
if ! command -v sshpass &>/dev/null; then
    echo "❌ sshpass is not installed. Please install it using: sudo apt install sshpass"
    exit 1
fi

# === STEP 1: Download Splunk ===
echo "📥 Downloading Splunk installer..."
wget -O "$SPLUNK_FILENAME" "$SPLUNK_URL"
if [ $? -ne 0 ]; then
    echo "❌ Failed to download Splunk. Check URL or network connection."
    exit 1
fi

# === STEP 2: Copy to Remote ===
echo "📤 Copying Splunk installer to the VM..."
sshpass -p "$VM_PASS" scp "$SPLUNK_FILENAME" "${VM_USER}@${VM_IP}:/home/${VM_USER}/"
if [ $? -ne 0 ]; then
    echo "❌ Failed to copy file to VM."
    exit 1
fi

# === STEP 3: Install Splunk ===
echo "💻 Installing Splunk on the VM..."
sshpass -p "$VM_PASS" ssh "${VM_USER}@${VM_IP}" bash -s <<EOF
    echo "$VM_PASS" | sudo -S apt update
    echo "$VM_PASS" | sudo -S apt install ./splunk-${SPLUNK_VERSION}-${SPLUNK_HASH}-linux-amd64.deb -y
    echo "$VM_PASS" | sudo -S /opt/splunk/bin/splunk enable boot-start --accept-license --answer-yes
    echo "$VM_PASS" | sudo -S /opt/splunk/bin/splunk start --accept-license --answer-yes
EOF

# === STEP 4: Done ===
echo "✅ Splunk installation completed. Access it at: http://${VM_IP}:8000"