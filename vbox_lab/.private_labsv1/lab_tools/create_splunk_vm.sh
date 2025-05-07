#!/bin/bash

# === Splunk VM Setup using Existing VDI ===

SPLUNK_VM_NAME="Splunk-Unattended-Lab"
SPLUNK_VDI_PATH="C:\\Users\\timot\\Downloads\\vm_images\\Ubuntu Server 22.04 (64bit).vdi"
SHARED_FOLDER_PATH="C:\\Users\\timot\\SplunkLabShare"
SHARED_FOLDER_NAME="SplunkLabShare"
RAM_MB=4096
CPU_COUNT=2

echo "🛠️ Creating $SPLUNK_VM_NAME..."

# Create VM
VBoxManage createvm --name "$SPLUNK_VM_NAME" --ostype Ubuntu_64 --register

# Set up storage
VBoxManage storagectl "$SPLUNK_VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$SPLUNK_VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$SPLUNK_VDI_PATH"

# VM configuration
VBoxManage modifyvm "$SPLUNK_VM_NAME" --memory "$RAM_MB" --cpus "$CPU_COUNT" --vram 128
VBoxManage modifyvm "$SPLUNK_VM_NAME" --nic1 nat

# Shared folder
VBoxManage sharedfolder add "$SPLUNK_VM_NAME" --name "$SHARED_FOLDER_NAME" --hostpath "$SHARED_FOLDER_PATH" --automount

# Start VM
VBoxManage startvm "$SPLUNK_VM_NAME" --type gui

echo "✅ $SPLUNK_VM_NAME created and started."
