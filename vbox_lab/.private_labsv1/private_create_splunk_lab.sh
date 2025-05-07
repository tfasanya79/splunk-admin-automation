#!/bin/bash

# Load environment variables from .env
set -a
source ./environment.env
set +a

# Helper functions
vm_exists() {
    VBoxManage showvminfo "$1" &> /dev/null
}

delete_vm_if_exists() {
    if vm_exists "$1"; then
        VBoxManage unregistervm "$1" --delete
    fi
}

take_snapshot() {
    VM_NAME="$1"
    SNAP_NAME="InitialSnapshot"
    echo "📸 Taking snapshot of $VM_NAME"
    VBoxManage snapshot "$VM_NAME" take "$SNAP_NAME" --pause
}

create_shared_folder() {
    VM_NAME="$1"
    VBoxManage sharedfolder add "$VM_NAME" \
        --name "SplunkLabShare" \
        --hostpath "$SHARED_FOLDER_PATH" \
        --automount
}

ensure_shared_folder_path_exists() {
    if [[ ! -d "$SHARED_FOLDER_PATH" ]]; then
        echo "📁 Shared folder path doesn't exist. Creating: $SHARED_FOLDER_PATH"
        mkdir -p "$SHARED_FOLDER_PATH"
    fi
}

# Begin creation

echo "📦 Starting lab creation using configuration from ./environment.env..."

# --- SPLUNK VM ---
echo "🛠️  Creating Splunk VM ($SPLUNK_VM_NAME)..."
delete_vm_if_exists "$SPLUNK_VM_NAME"
VBoxManage createvm --name "$SPLUNK_VM_NAME" --ostype "$SPLUNK_VM_TYPE" --register
VBoxManage modifyvm "$SPLUNK_VM_NAME" \
    --memory "$SPLUNK_VM_RAM" \
    --cpus "$SPLUNK_VM_CPUS" \
    --nic1 bridged \
    --bridgeadapter1 "$BRIDGE_ADAPTER_NAME" \
    --audio none

VBoxManage createmedium disk --filename "$VIRTUALBOX_VM_DIR/$SPLUNK_VM_NAME/$SPLUNK_VM_NAME.vdi" --size "$SPLUNK_VM_DISK_SIZE" --format VDI
VBoxManage storagectl "$SPLUNK_VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$SPLUNK_VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VIRTUALBOX_VM_DIR/$SPLUNK_VM_NAME/$SPLUNK_VM_NAME.vdi"

ensure_shared_folder_path_exists
create_shared_folder "$SPLUNK_VM_NAME"

VBoxManage unattended install "$SPLUNK_VM_NAME" \
    --iso="$SPLUNK_UNATTENDED_ISO" \
    --user="$SPLUNK_USERNAME" \
    --password="$SPLUNK_PASSWORD" \
    --install-additions \
    --locale=en_US \
    --country=US \
    --time-zone=UTC \
    --hostname=splunk-vm

echo "🚀 Starting unattended Splunk VM install..."
VBoxManage startvm "$SPLUNK_VM_NAME" --type headless
sleep 5

# Snapshot
sleep "$WAIT_BEFORE_SNAPSHOT"
take_snapshot "$SPLUNK_VM_NAME"

# --- WINDOWS PLACEHOLDER ---
echo "🛠️  Creating placeholder Windows VM ($WIN_VM_NAME)..."
delete_vm_if_exists "$WIN_VM_NAME"
VBoxManage createvm --name "$WIN_VM_NAME" --ostype "$WIN_VM_TYPE" --register
VBoxManage modifyvm "$WIN_VM_NAME" \
    --memory "$WIN_VM_RAM" \
    --cpus "$WIN_VM_CPUS" \
    --nic1 bridged \
    --bridgeadapter1 "$BRIDGE_ADAPTER_NAME"

ensure_shared_folder_path_exists
create_shared_folder "$WIN_VM_NAME"

echo "⚠️  Please manually install and configure the Windows VM ($WIN_VM_NAME)"
take_snapshot "$WIN_VM_NAME"

# --- KALI VM IMPORT ---
if vm_exists "$KALI_VM_NAME"; then
    echo "⚠️  $KALI_VM_NAME already exists. Skipping import."
else
    if [[ ! -f "$KALI_OVA_PATH" ]]; then
        echo "❌ Kali OVA file not found at $KALI_OVA_PATH"
    else
        echo "📥 Importing Kali VM from OVA..."
        VBoxManage import "$KALI_OVA_PATH" --vsys 0 --vmname "$KALI_VM_NAME"
        VBoxManage modifyvm "$KALI_VM_NAME" \
            --nic1 bridged \
            --bridgeadapter1 "$BRIDGE_ADAPTER_NAME"
        ensure_shared_folder_path_exists
        create_shared_folder "$KALI_VM_NAME"
        take_snapshot "$KALI_VM_NAME"
    fi
fi

echo "✅ Lab environment created successfully using .env configuration!"
