#!/bin/bash

# Load environment variables from environment.env
source ./environment.env

# Define paths
UBUNTU_ISO="$SPLUNK_ISO_PATH"
WINDOWS_ISO="C:\\Users\\timot\\Downloads\\vm_images\\windows11_en-us.iso"
KALI_VDI="C:\\Users\\timot\\Downloads\\vm_images\\Kali Linux 2024.4 (64bit).vdi"

# Networking
BRIDGE_ADAPTER="Intel(R) Wi-Fi 6E AX211 160MHz"

echo "[+] Checking existing VMs..."

### SPLUNK VM
if VBoxManage list vms | grep -q "\"$SPLUNK_VM_NAME\""; then
    echo "[!] $SPLUNK_VM_NAME already exists. Skipping creation."
else
    echo "[+] Creating Splunk VM..."
    VBoxManage createvm --name "$SPLUNK_VM_NAME" --ostype Ubuntu_64 --register
    VBoxManage createhd --filename "C:\\Users\\timot\\VirtualBox VMs\\$SPLUNK_VM_NAME\\$SPLUNK_VM_NAME.vdi" --size 20000
    VBoxManage storagectl "$SPLUNK_VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
    VBoxManage storageattach "$SPLUNK_VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "C:\\Users\\timot\\VirtualBox VMs\\$SPLUNK_VM_NAME\\$SPLUNK_VM_NAME.vdi"
    VBoxManage storageattach "$SPLUNK_VM_NAME" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "$UBUNTU_ISO"
    VBoxManage modifyvm "$SPLUNK_VM_NAME" --memory $RAM_MB --vram 128 --cpus $CPU_COUNT --boot1 dvd --boot2 disk
    VBoxManage modifyvm "$SPLUNK_VM_NAME" --nic1 bridged --bridgeadapter1 "$BRIDGE_ADAPTER"
    VBoxManage sharedfolder add "$SPLUNK_VM_NAME" --name "$SHARED_FOLDER_NAME" --hostpath "$SHARED_FOLDER_PATH" --automount
    VBoxManage startvm "$SPLUNK_VM_NAME" --type gui
    echo "[+] $SPLUNK_VM_NAME created. Manually install Ubuntu."
fi

### WINDOWS VM
if VBoxManage list vms | grep -q "\"$WINDOWS_VM_NAME\""; then
    echo "[!] $WINDOWS_VM_NAME already exists. Skipping creation."
else
    echo "[+] Creating Windows VM..."
    VBoxManage createvm --name "$WINDOWS_VM_NAME" --ostype Windows11_64 --register
    VBoxManage createhd --filename "C:\\Users\\timot\\VirtualBox VMs\\$WINDOWS_VM_NAME\\$WINDOWS_VM_NAME.vdi" --size 30000
    VBoxManage storagectl "$WINDOWS_VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
    VBoxManage storageattach "$WINDOWS_VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "C:\\Users\\timot\\VirtualBox VMs\\$WINDOWS_VM_NAME\\$WINDOWS_VM_NAME.vdi"
    VBoxManage storageattach "$WINDOWS_VM_NAME" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "$WINDOWS_ISO"
    VBoxManage modifyvm "$WINDOWS_VM_NAME" --memory $RAM_MB --vram 128 --cpus $CPU_COUNT --boot1 dvd --boot2 disk
    VBoxManage modifyvm "$WINDOWS_VM_NAME" --nic1 bridged --bridgeadapter1 "$BRIDGE_ADAPTER"
    VBoxManage sharedfolder add "$WINDOWS_VM_NAME" --name "WinShare" --hostpath "$SHARED_FOLDER_PATH" --automount
    VBoxManage startvm "$WINDOWS_VM_NAME" --type gui
    echo "[+] $WINDOWS_VM_NAME created. Manually install Windows."
fi

### KALI VM
if VBoxManage list vms | grep -q "\"$KALI_VM_NAME\""; then
    echo "[!] $KALI_VM_NAME already exists. Skipping creation."
else
    echo "[+] Creating Kali VM..."
    VBoxManage createvm --name "$KALI_VM_NAME" --ostype Debian_64 --register
    VBoxManage storagectl "$KALI_VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
    VBoxManage storageattach "$KALI_VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$KALI_VDI"
    VBoxManage modifyvm "$KALI_VM_NAME" --memory $RAM_MB --vram 128 --cpus $CPU_COUNT --boot1 disk
    VBoxManage modifyvm "$KALI_VM_NAME" --nic1 bridged --bridgeadapter1 "$BRIDGE_ADAPTER"
    VBoxManage sharedfolder add "$KALI_VM_NAME" --name "KaliShare" --hostpath "$SHARED_FOLDER_PATH" --automount
    VBoxManage startvm "$KALI_VM_NAME" --type gui
    echo "[+] $KALI_VM_NAME started using prebuilt VDI."
fi

echo "✅ All VMs created and started where applicable."
