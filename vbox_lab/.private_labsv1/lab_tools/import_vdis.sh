#!/bin/bash

# VM names
UBUNTU_VM="Ubuntu_VM"
KALI_VM="Kali_VM"

# Paths to existing .vdi files
UBUNTU_VDI="C:\\Users\\timot\\Downloads\\vm_images\\Ubuntu Server 22.04 (64bit).vdi"
KALI_VDI="C:\\Users\\timot\\Downloads\\vm_images\\kali-linux-2025.1a-virtualbox-amd64.vdi"

echo "📦 Creating Ubuntu VM..."
VBoxManage createvm --name "$UBUNTU_VM" --ostype "Ubuntu_64" --register
VBoxManage modifyvm "$UBUNTU_VM" --memory 2048 --cpus 2 --nic1 nat
VBoxManage storagectl "$UBUNTU_VM" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$UBUNTU_VM" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$UBUNTU_VDI"

echo "📦 Creating Kali VM..."
VBoxManage createvm --name "$KALI_VM" --ostype "Debian_64" --register
VBoxManage modifyvm "$KALI_VM" --memory 2048 --cpus 2 --nic1 nat
VBoxManage storagectl "$KALI_VM" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$KALI_VM" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$KALI_VDI"

echo "✅ VMs created and .vdi files attached."
