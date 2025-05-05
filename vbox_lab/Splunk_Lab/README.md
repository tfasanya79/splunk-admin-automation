
```markdown
# Splunk Admin Automation Lab

## Overview
This repository contains automation for creating a lab environment to learn and practice Splunk administration, cybersecurity, and incident response. The lab consists of:

1. **Splunk VM**: A Linux-based VM running Splunk for log collection and analysis.
2. **Windows Server VM (Ent_Machine)**: A Windows machine with Sysmon for log collection and analysis in Splunk.
3. **Kali Linux VM (Attack_Machine)**: A machine for penetration testing and attack simulations.

---

## Lab Setup Steps

### Prerequisites

1. **Install VirtualBox** and make sure `VBoxManage` is available in your terminal.
2. **Download ISO files**:
   - **Ubuntu 22.04 Server**: [Download here](https://ubuntu.com/download/server)
   - **Windows Server 2022**: [Download here](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server)
   - **Kali Linux ISO**: [Download here](https://www.kali.org/get-kali/)
   
### Running the Script

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/splunk-admin-automation.git
   cd splunk-admin-automation
````

2. Make the script executable:

   ```bash
   chmod +x create_splunk_lab.sh
   ```

3. Run the script:

   ```bash
   ./create_splunk_lab.sh
   ```

   This will:

   * Create and configure the **Splunk Lab VM**.
   * Create and configure the **Windows Server (Ent\_Machine)** with Sysmon.
   * Create and configure the **Kali Linux (Attack\_Machine)**.

### Sysmon Setup on Windows Server

1. After Windows Server is installed, download and install **Sysmon** using PowerShell:

   ```powershell
   sysmon -accepteula -h md5,sha256 -c sysmon-config.xml
   ```

2. Configure Splunk to onboard Sysmon logs from `C:\Windows\System32\winevt\Logs\Microsoft-Windows-Sysmon`.

### Accessing the Lab

* **Splunk Web Interface**: Access from your host at `http://localhost:8000`.
* **Windows Server**: RDP or access via VirtualBox GUI for Sysmon configuration.
* **Kali Linux**: Access through VirtualBox GUI for penetration testing and attack simulations.


---

## Notes

* After setting up the VMs, follow the instructions in the script to complete any necessary configurations.
* The lab setup is designed for cybersecurity learning, with a focus on **Splunk log analysis** and **attack/defense techniques**.

```
