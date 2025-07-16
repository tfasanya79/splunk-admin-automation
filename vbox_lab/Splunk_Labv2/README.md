# Splunk Cybersecurity Lab with VirtualBox

This lab sets up a 3-VM environment using VirtualBox:

- **Splunk Lab (Ubuntu + Splunk)**
- **Ent_Machine (Windows Server + Sysmon for monitoring)**
- **Attack_Machine (Kali Linux for offensive security learning)**

## 💻 Requirements

- VirtualBox installed
- Ubuntu 24.04 ISO
- Windows Server 2022 ISO
- Kali Linux ISO
- Bash (run script from Git Bash or WSL on Windows)

## 🚀 Setup Steps

1. Download ISOs:
   - [Ubuntu 24.04.2 ISO](https://releases.ubuntu.com/24.04/)
   - [Windows Server 2022 ISO](https://www.microsoft.com/en-us/evalcenter/)
   - [Kali Linux ISO](https://www.kali.org/get-kali/)

2. Place them in your `~/Downloads/` directory.

3. Run the setup script:
   ```bash
   bash create_splunk_lab.sh
