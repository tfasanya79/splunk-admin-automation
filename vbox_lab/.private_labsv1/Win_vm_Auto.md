
## 📋 Windows VM Automation: Setup Summary

### 🔹 Purpose:

Automate the setup and configuration of the **Windows Virtual Machine (VM)** using two key files: `autounattend.xml` and `Initialize-WinLab.ps1`.

---

### 📄 `autounattend.xml`

**Function:**
Automates the Windows installation process without requiring user input.

**Key Features:**

* Automatically accepts the Windows license agreement.
* Creates a user account `Admin` with password `P@ssw0rd`.
* Enables automatic logon for the Admin user.
* Sets locale, time zone, and system hostname (`WinLabVM`).
* Disables User Account Control (UAC).
* Enables Windows Remote Management (WinRM).

**Usage:**
Include this file in the root of an ISO or mountable media during Windows setup. 
Windows Setup detects and applies it to perform a full unattended installation.

---

### ⚙️ `Initialize-WinLab.ps1`

**Function:**
Executes post-setup system configuration tasks after the first Windows boot.

**Key Features:**

* Ensures the script runs with elevated administrator privileges.
* Sets PowerShell execution policy to allow local script execution.
* Installs tools (e.g., Notepad++ via Chocolatey).
* Placeholder for future customizations (e.g., registry changes, firewall rules).

**Usage:**
Manually run after installation or include in a startup task via Task Scheduler or `SetupComplete.cmd`.

---

### 🧠 Future Capabilities

These scripts and configuration can be expanded to:

* 🔐 **Security Hardening:** Enforce password policies, firewall configurations, and disable unnecessary services.
* 🛠️ **Tool Deployment:** Install system tools, monitoring agents, or development environments.
* 💻 **UI Customization:** Set desktop backgrounds, pin apps, or modify UI settings for user sessions.
* ☁️ **Cloud or Domain Integration:** Join to Active Directory, configure remote access endpoints, or prepare for cloud orchestration (Ansible, SCCM).

---

Let me know if you'd like to automate the PowerShell script execution as part of the Windows first boot.


========================================================================================
# 💡 Customizing autounattend.xml for Windows VM Setup

This guide outlines how to tailor your `autounattend.xml` file to suit a variety of automation needs during Windows 
VM installation.

---

## 📍 What is `autounattend.xml`?

`autounattend.xml` is used during Windows installation to automate setup tasks like user creation, 
language selection, disk partitioning, and post-install scripts.

---

## 🛠️ How to Modify Key Sections

### 1. Regional and Language Settings

```xml
<settings pass="windowsPE">
  <component name="Microsoft-Windows-International-Core-WinPE" ...>
    <InputLocale>en-US</InputLocale>
    <SystemLocale>en-US</SystemLocale>
    <UILanguage>en-US</UILanguage>
    <UserLocale>en-US</UserLocale>
  </component>
</settings>
```

Change `en-US` to your preferred culture code (e.g., `fr-FR` for French).

---

### 2. Create Users / Set Passwords

```xml
<component name="Microsoft-Windows-Shell-Setup" ...>
  <UserAccounts>
    <LocalAccounts>
      <LocalAccount wcm:action="add">
        <Name>Admin</Name>
        <Group>Administrators</Group>
        <Password>
          <Value>P@ssw0rd</Value>
          <PlainText>true</PlainText>
        </Password>
      </LocalAccount>
    </LocalAccounts>
  </UserAccounts>
</component>
```

Use strong passwords and avoid plaintext in production environments.

---

### 3. Enable Autologin

```xml
<AutoLogon>
  <Username>Admin</Username>
  <Password>
    <Value>P@ssw0rd</Value>
    <PlainText>true</PlainText>
  </Password>
  <Enabled>true</Enabled>
  <LogonCount>1</LogonCount>
</AutoLogon>
```

This logs in the specified user after the first boot.

---

### 4. Disk Partitioning

```xml
<DiskConfiguration>
  <Disk wcm:action="add">
    <DiskID>0</DiskID>
    <WillWipeDisk>true</WillWipeDisk>
    <CreatePartitions>
      <CreatePartition wcm:action="add">
        <Order>1</Order>
        <Type>Primary</Type>
        <Size>100000</Size>
      </CreatePartition>
    </CreatePartitions>
    <ModifyPartitions>
      <ModifyPartition wcm:action="add">
        <Active>true</Active>
        <Format>NTFS</Format>
        <Label>OS</Label>
        <Letter>C</Letter>
        <Order>1</Order>
        <PartitionID>1</PartitionID>
      </ModifyPartition>
    </ModifyPartitions>
  </Disk>
  <WillShowUI>OnError</WillShowUI>
</DiskConfiguration>
```

Ensure disk size matches your VM’s virtual hard drive.

---

### 5. Enable WinRM for Remote Management

```xml
<component name="Microsoft-Windows-RemoteShell" ...>
  <AllowUnencrypted>true</AllowUnencrypted>
  <EnableRemoteManagement>true</EnableRemoteManagement>
</component>
```

WinRM allows you to manage the VM remotely via PowerShell.

---

## ✅ Best Practices

* **Test** your changes in a test VM before production use.
* Use a **validated XML tool** (e.g., Windows System Image Manager) to ensure correctness.
* Avoid plaintext passwords in sensitive environments.

---

## 🔮 What You Can Do in the Future

* Install applications silently using `FirstLogonCommands`.
* Integrate PowerShell scripts to perform advanced configuration.
* Set up domain joining or network configuration.

---

Want to extend this guide further (e.g., app installation or silent driver injection)? Let me know!



















================================================================================================
