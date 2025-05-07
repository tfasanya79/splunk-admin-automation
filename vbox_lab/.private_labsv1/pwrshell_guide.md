# PowerShell Startup Script Guide for Windows VM Automation

This guide explains the purpose and usage of the PowerShell startup script implemented in your automated Windows VM setup. It complements the `autounattend.xml` file, enabling additional customization and automation post-boot.

---

## 📁 Script Location

Place your PowerShell script (e.g., `setup.ps1`) in a shared folder that is accessible by the virtual machine at startup, or inject it via VirtualBox Guest Additions.

---

## ⚙️ Purpose of the PowerShell Script

The PowerShell script allows you to:

* Install software (e.g., Splunk Forwarder, security tools, etc.)
* Configure system settings (e.g., enable Windows features, disable services)
* Join domains or configure networking
* Set environment variables, paths, or other user/system-level settings

---

## 🚀 Typical Use After First Boot

The script runs after Windows boots and autologin completes, assuming:

* WinRM is enabled (from `autounattend.xml`)
* UAC is disabled (from `autounattend.xml`)
* A user with administrative privileges is logged in

You can run the script manually, or configure it to run automatically via Task Scheduler or Registry (e.g., `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`).

---

## 📌 Future Capabilities

The PowerShell script can be extended to:

* Perform security hardening
* Connect to remote systems
* Download updates or patches
* Automate testing or compliance checks

---

## ✅ Tip

Test your PowerShell script separately on a non-production VM first to avoid boot or configuration errors.

---

This complements your `autounattend.xml` file, providing full automation from install to configuration. You can now add your own commands to the PowerShell script to fit your exact needs.

---

Let me know if you'd like a template script or integration with remote management tools like Ansible or SCCM.
