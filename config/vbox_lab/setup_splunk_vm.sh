#!/bin/bash

# Configurable values
VM_NAME="Splunk-Automation-Lab"
VM_OS_TYPE="Ubuntu_64"
ISO_PATH="$HOME/Downloads/ubuntu-22.04.4-desktop-amd64.iso"
HDD_SIZE=40000
RAM_SIZE=4096
CPU_COUNT=2

echo "Creating VirtualBox VM: $VM_NAME"

# Create VM
VBoxManage createvm --name "$VM_NAME" --ostype $VM_OS_TYPE --register
VBoxManage modifyvm "$VM_NAME" --memory $RAM_SIZE --cpus $CPU_COUNT --nic1 nat --audio none

# Create virtual disk
VBoxManage createmedium disk --filename "$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi" --size $HDD_SIZE
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi"

# Attach ISO for Ubuntu installation
VBoxManage storagectl "$VM_NAME" --name "IDE Controller" --add ide
VBoxManage storageattach "$VM_NAME" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "$ISO_PATH"

# Set boot order
VBoxManage modifyvm "$VM_NAME" --boot1 dvd --boot2 disk --boot3 none --boot4 none

# Launch VM for manual Ubuntu install
echo "✅ VM created. You can now start it manually with:"
echo "VBoxManage startvm \"$VM_NAME\" --type gui"

# After installing Ubuntu and setting up Splunk, you can export:
# VBoxManage export "$VM_NAME" -o "${VM_NAME}.ova"
