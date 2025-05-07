#!/bin/bash

KALI_VM_NAME="Attack_Machine"
KALI_VDI_PATH="C:\\Users\\timot\\Downloads\\vm_images\\kali-linux-2025.1a-virtualbox-amd64.vdi"
SHARED_FOLDER_PATH="C:\\Users\\timot\\SplunkLabShare"

echo "🛠️ Creating $KALI_VM_NAME..."

# Create the VM
VBoxManage createvm --name "$KALI_VM_NAME" --ostype "Debian_64" --register

# Set resources
VBoxManage modifyvm "$KALI_VM_NAME" --memory 4096 --vram 128 --cpus 2 \
    --nic1 bridged --bridgeadapter1 "Intel(R) Ethernet Connection" \
    --boot1 disk --boot2 dvd --boot3 none --boot4 none

# Attach the VDI
VBoxManage storagectl "$KALI_VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$KALI_VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$KALI_VDI_PATH"

# Add Shared Folder (optional)
if [ -d "/c/Users/timot/SplunkLabShare" ]; then
    VBoxManage sharedfolder add "$KALI_VM_NAME" --name "SplunkShare" --hostpath "$SHARED_FOLDER_PATH" --automount
else
    echo "⚠️ Shared folder not found. Skipping shared folder setup."
fi

# Start VM
VBoxManage startvm "$KALI_VM_NAME" --type gui

echo "✅ $KALI_VM_NAME created and started."
