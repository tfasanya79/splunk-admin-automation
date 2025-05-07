
# Windows VM First Boot Automation

This document provides a brief overview of the `autounattend.xml` and `Initialize-WinLab.ps1` files used to automate the setup of a Windows virtual machine (VM) in a lab environment.

---

## 🔧 autounattend.xml

This is a Windows Setup answer file that automates the initial installation and configuration process of the Windows OS. It is used during the first boot (Windows Setup phase) and handles tasks such as:

- 📛 **Creating a default user**
  - User: `Admin`
  - Password: `P@ssw0rd`
- 🔒 **Disabling UAC (User Account Control)** for smoother automation.
- 🔌 **Enabling WinRM** (Windows Remote Management), which is essential for remote scripting and configuration.
- 🔁 **Automatic Login**: Automatically logs in the created user after installation, preparing the system for the next configuration stage.

### 🔮 Future Capabilities
You can extend `autounattend.xml` to:
- Join a domain
- Set up disk partitions
- Pre-install software
- Configure network settings

---

## 🧩 Initialize-WinLab.ps1

This PowerShell script is intended to run post-installation. It finalizes the environment configuration after the user is automatically logged in.

### Responsibilities:
- Prepares the system for remote access or automation tasks
- Installs desired software or dependencies
- Applies additional system settings (firewall rules, security policies, etc.)

### 🔮 Future Capabilities
You can extend this script to:
- Download and install additional tools
- Register with centralized management platforms
- Schedule recurring maintenance tasks
- Run Splunk forwarder or agent setup

---

## 📌 Usage Notes

1. Place `autounattend.xml` in the root of a Windows ISO or bootable media.
2. Ensure the PowerShell script is accessible post-setup, either via:
   - Cloud-init like methods (VirtualBox shared folders)
   - Manual copy or ISO mount

---

By combining these two automation methods, you achieve a robust and flexible Windows setup pipeline for any lab or enterprise deployment.
