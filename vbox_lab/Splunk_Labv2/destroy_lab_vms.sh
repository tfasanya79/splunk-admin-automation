#!/bin/bash

# Destroy Lab VMs

VM_NAMES=("Splunk-Unattended-Lab" "Ent_Machine" "Attack_Machine")

echo "🧹 Starting teardown of lab VMs..."

for VM in "${VM_NAMES[@]}"; do
  echo "⛘️ Powering off $VM if running..."
  if VBoxManage showvminfo "$VM" &>/dev/null; then
    VBoxManage controlvm "$VM" poweroff 2>/dev/null || true
  else
    echo "⚠️  VM $VM not found. Skipping power off."
  fi

  echo "🗑️  Unregistering and deleting $VM..."
  if VBoxManage showvminfo "$VM" &>/dev/null; then
    for i in {1..5}; do
      VBoxManage unregistervm "$VM" --delete && break
      echo "   ⚠️  Attempt $i failed. VM might still be locked. Retrying in 3 seconds..."
      sleep 3
    done
    if VBoxManage showvminfo "$VM" &>/dev/null; then
      echo "❌ Failed to delete $VM after 5 attempts."
    fi
  else
    echo "⚠️  VM $VM not found. Skipping deletion."
  fi
done

# Clean up shared folder if it exists
SHARE_DIR="/c/Users/timot/SplunkLabShare"

echo ""
echo "🧼 Cleaning up shared folder (if it exists)..."
if [ -d "$SHARE_DIR" ]; then
    rm -rf "$SHARE_DIR" && echo "✅ Shared folder removed: $SHARE_DIR" || echo "❌ Failed to remove shared folder."
else
    echo "ℹ️ No shared folder to delete at: $SHARE_DIR"
fi

echo ""
echo "🧹 Lab teardown complete."
