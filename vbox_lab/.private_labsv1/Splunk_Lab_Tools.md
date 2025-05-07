## ✅ What **Can Be Fully Automated**

| Step                                | Automatable?                                                        | How |
| ----------------------------------- | ------------------------------------------------------------------- | --- |
| VM creation + disk + ISO attachment | ✅ Already done via `VBoxManage`                                     |     |
| Ubuntu OS installation              | ✅ With **unattended install** using `VBoxManage unattended install` |     |
| Splunk installation inside Ubuntu   | ✅ With a **cloud-init script** or remote `ssh` + provisioning       |     |
| Code deployment + automation        | ✅ With `scp`, Ansible, or `ssh` automation                          |     |


* Automate VM startup order
* Automate VM startup order
* Verify shared folder mounts from inside each guest
* Integrate logging or progress tracking
* Export the lab as a reusable OVA set

-----------------------------------------------------------------------

 Splunk VM (Ubuntu)
✅ Created successfully.

✅ Unattended installation is running with correct ISO and settings.

⏳ Wait for installation to complete in VirtualBox — this usually takes a few minutes.

🔄 After it finishes:
Log in with:

Username: student
Password: student

Then you can install Splunk manually or automate it in a follow-up script.
--------------------------------------------------------------------------

✅ Windows Server (Ent_Machine)
✅ VM and virtual hard disk created.

⛔ No unattended install (normal for Windows ISOs without setup automation).

🛠️ Next Step:
Boot the VM.

Manually walk through the installation using your Windows Server ISO.

After install:

Install Sysmon

Set up log forwarding if needed.

----------------------------------------------------------------------




Yes — nearly **all the steps** above can be automated, including:

---

## ✅ What **Can Be Fully Automated**

| Step                                | Automatable?                                                        | How |
| ----------------------------------- | ------------------------------------------------------------------- | --- |
| VM creation + disk + ISO attachment | ✅ Already done via `VBoxManage`                                     |     |
| Ubuntu OS installation              | ✅ With **unattended install** using `VBoxManage unattended install` |     |
| Splunk installation inside Ubuntu   | ✅ With a **cloud-init script** or remote `ssh` + provisioning       |     |
| Code deployment + automation        | ✅ With `scp`, Ansible, or `ssh` automation                          |     |

---

## 🚀 Fully Automating Ubuntu + Splunk Setup

### ✅ Option 1: Use `VBoxManage unattended install`

This feature can auto-install Ubuntu **without user interaction**, including setting:

* Username/password
* Hostname
* Timezone
* Optional install scripts (like `install_splunk.sh`)

Example:

```bash
VBoxManage unattended install "Splunk-Automation-Lab" \
  --iso="$HOME/Downloads/ubuntu-24.04.2-desktop-amd64.iso" \
  --user=admin \
  --password=adminpass \
  --full-user-name="Splunk Admin" \
  --hostname=splunk-lab \
  --install-additions \
  --start-vm=gui \
  --post-install-command="curl -s https://raw.githubusercontent.com/yourrepo/install_splunk.sh | bash"
```

> This will **fully install Ubuntu**, create a user, boot, and run the post-install script for Splunk.

---

### ✅ Option 2: Use **cloud-init** or `install_splunk.sh`

If using a headless Ubuntu Server ISO, you can include a `cloud-init` or a `preseed.cfg` file to auto-install both Ubuntu and Splunk.

Alternatively, after the OS is installed, you can:

1. SSH into the VM
2. Run a provisioning script like:

```bash
#!/bin/bash
wget -O splunk.tgz "https://download.splunk.com/products/splunk/releases/9.1.2/linux/splunk-9.1.2-xxx-Linux-x86_64.tgz"
tar -xvzf splunk.tgz
sudo mv splunk /opt/
sudo /opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt --seed-passwd changeme
```

---

### 📦 Extra Automation Tools (Optional)

* Use **Ansible** for full reproducibility (especially in teams)
* Use **Packer** to build ready-to-use VM images with Splunk preinstalled
* Use **Vagrant** to manage the whole lifecycle easily

---

Would you like me to give you a ready-to-run `VBoxManage unattended install` script that installs Ubuntu and Splunk automatically?

---------------------------------------------------------------------------------------
Excellent — now that everything is wired up correctly, here's a quick walkthrough of how to **test the complete setup end-to-end**:

---

### ✅ Recommended Test Steps

#### **1. Review/Edit Your `.env` File**

Ensure all variables are properly defined. Confirm:

* `SHARED_FOLDER_PATH` exists or will be created (e.g., `C:\Users\yourname\SplunkLabShare`)
* `KALI_OVA_PATH` points to the actual Kali OVA file
* Paths use double-backslashes (`\\`) or forward slashes (`/`) on Windows

---

#### **2. Clean Slate (Optional but Recommended)**

```bash
./destroy_lab_vms.sh
```

> Ensure previous VMs are deleted before creating new ones.

---

#### **3. Run the Lab Creation Script**

```bash
./create_splunk_lab.sh
```

You should see:

* Each VM being created (Splunk, Windows, Kali)
* Shared folder setup (and auto-created if needed)
* Snapshots taken after initialization
* A warning if Kali OVA file is missing or already imported

---

#### **4. Check VirtualBox GUI**

Open VirtualBox:

* Confirm that VMs are listed and powered off (except during unattended installs)
* Snapshots should be visible under each VM

---

#### **5. Validate Shared Folder Mounting (Post-Boot)**

After VMs boot:

* Log into a VM
* Confirm that `SplunkLabShare` is available/mounted

---

#### **6. Optional Improvements**

Let me know if you want to:

* Automate VM startup order
* Verify shared folder mounts from inside each guest
* Integrate logging or progress tracking
* Export the lab as a reusable OVA set

Would you like me to walk through `.env` validation or assist with adding post-boot health checks next?

