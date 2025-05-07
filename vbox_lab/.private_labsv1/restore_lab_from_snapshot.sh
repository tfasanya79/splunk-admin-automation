#!/bin/bash

# Load environment variables
source "C:/Users/timot/Downloads/splunk-admin-automation/vbox_lab/.private_labsv1/environment.env"

# VM names
VM_NAMES=("$SPLUNK_VM_NAME" "$WINDOWS_VM_NAME" "$KALI_VM_NAME")

# Snapshot name
SNAPSHOT_NAME="${SNAPSHOT_NAME:-PostSetup}"

echo "♻️ Starting VM restoration from snapshot: $SNAPSHOT_NAME"

for VM in "${VM_NAMES[@]}"; do
  echo "🔄 Restoring $VM to snapshot: $SNAPSHOT_NAME..."
  if VBoxManage showvminfo "$VM" &>/dev/null; then
    VBoxManage snapshot "$VM" restore "$SNAPSHOT_NAME"
    echo "✅ $VM restored to snapshot: $SNAPSHOT_NAME"
  else
    echo "❌ $VM not found or not registered. Skipping..."
  fi
done

echo ""
echo "🚀 Starting all restored VMs..."
for VM in "${VM_NAMES[@]}"; do
  VBoxManage startvm "$VM" --type headless && echo "▶️ $VM started" || echo "❌ Failed to start $VM"
done

echo ""
echo "✅ Lab restoration complete."
