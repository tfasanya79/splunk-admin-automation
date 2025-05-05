#!/bin/bash

# === CONFIGURATION ===
VM_NAME="Splunk-Unattended-Lab"           # Splunk VM (Ubuntu) for logging and analysis
ISO_PATH="$HOME/Downloads/ubuntu-22.04.4-live-server-amd64.iso"  # Ubuntu ISO for Splunk VM
SPLUNK_TGZ_URL="https://download.splunk.com/products/splunk/releases/9.1.2/linux/splunk-9.1.2-a7f645ddaf91-Linux-x86_64.tgz"  # Splunk Download URL
USERNAME="splunkadmin"                     # Username for Splunk VM
PASSWORD="splunk123"                       # Password for Splunk VM
RAM_MB=4096                                # Memory for VMs
CPUS=2                                     # CPU count for VMs
DISK_MB=40000                              # Disk size for VMs

# === CREATE SPLUNK VM ===
echo "[+] Creating Splunk VM..."

# Create the Splunk Lab VM
VBoxManage createvm --name "$VM_NAME" --ostype Ubuntu_64 --register
VBoxManage modifyvm "$VM_NAME" --memory $RAM_MB --cpus $CPUS --nic1 nat --audio none

# Create and attach a hard disk
VBoxManage createmedium disk --filename "$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi" --size $DISK_MB
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi"

# Start unattended Ubuntu installation
echo "[+] Starting unattended Ubuntu installation..."
VBoxManage unattended install "$VM_NAME" \
  --iso="$ISO_PATH" \
  --user="$USERNAME" \
  --password="$PASSWORD" \
  --full-user-name="Splunk Admin" \
  --hostname="splunklab" \
  --install-additions \
  --start-vm=gui \
  --post-install-command="curl -sSL $SPLUNK_TGZ_URL -o splunk.tgz && \
    tar -xvzf splunk.tgz && \
    sudo mv splunk /opt/ && \
    sudo /opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt --seed-passwd $PASSWORD"

echo "[+] Splunk VM created. Please complete the Ubuntu installation to access Splunk."

# === CREATE WINDOWS SERVER VM (Ent_Machine) ===
echo "[+] Creating Windows Server VM (Ent_Machine) for Sysmon..."

# Define Windows Server configuration (modify ISO path as needed)
WINDOWS_ISO="$HOME/Downloads/Windows_Server_2022.iso"
WINDOWS_VM_NAME="Ent_Machine"

# Create the Windows VM
VBoxManage createvm --name "$WINDOWS_VM_NAME" --ostype Windows2019_64 --register
VBoxManage modifyvm "$WINDOWS_VM_NAME" --memory $RAM_MB --cpus $CPUS --nic1 nat --audio none

# Create and attach a disk
VBoxManage createmedium disk --filename "$HOME/VirtualBox VMs/$WINDOWS_VM_NAME/$WINDOWS_VM_NAME.vdi" --size $DISK_MB
VBoxManage storagectl "$WINDOWS_VM_NAME" --name "SATA Controller" --add sata
VBoxManage storageattach "$WINDOWS_VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$WINDOWS_VM_NAME/$WINDOWS_VM_NAME.vdi"

# Attach the Windows Server ISO
VBoxManage storagectl "$WINDOWS_VM_NAME" --name "IDE Controller" --add ide
VBoxManage storageattach "$WINDOWS_VM_NAME" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "$WINDOWS_ISO"

# Set the boot order for Windows
VBoxManage modifyvm "$WINDOWS_VM_NAME" --boot1 dvd --boot2 disk --boot3 none --boot4 none

echo "[+] VM created. Now you can manually install Windows Server and then proceed with Sysmon installation."

# === CREATE KALI LINUX VM (Attack_Machine) ===
echo "[+] Creating Kali Linux VM (Attack_Machine) for Cybersecurity testing..."

# Define Kali Linux configuration (modify ISO path as needed)
KALI_ISO="$HOME/Downloads/kali-linux.iso"
KALI_VM_NAME="Attack_Machine"

# Create the Kali VM
VBoxManage createvm --name "$KALI_VM_NAME" --ostype Debian_64 --register
VBoxManage modifyvm "$KALI_VM_NAME" --memory $RAM_MB --cpus $CPUS --nic1 nat --audio none

# Create and attach a disk
VBoxManage createmedium disk --filename "$HOME/VirtualBox VMs/$KALI_VM_NAME/$KALI_VM_NAME.vdi" --size $DISK_MB
VBoxManage storagectl "$KALI_VM_NAME" --name "SATA Controller" --add sata
VBoxManage storageattach "$KALI_VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$KALI_VM_NAME/$KALI_VM_NAME.vdi"

# Attach the Kali Linux ISO
VBoxManage storagectl "$KALI_VM_NAME" --name "IDE Controller" --add ide
VBoxManage storageattach "$KALI_VM_NAME" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "$KALI_ISO"

# Set the boot order for Kali
VBoxManage modifyvm "$KALI_VM_NAME" --boot1 dvd --boot2 disk --boot3 none --boot4 none

echo "[+] VM created. Proceed with Kali Linux installation and setup."

# === FINAL NOTES ===
echo "✅ All VMs have been created!"
echo "   1. Complete the Splunk installation inside Ubuntu."
echo "   2. Complete Windows Server installation, then manually install Sysmon."
echo "   3. Install Kali Linux for attack simulations."
