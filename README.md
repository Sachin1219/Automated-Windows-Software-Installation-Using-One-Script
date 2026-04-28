# 🧠 Automated Windows Software Installation System

A PowerShell-based GUI tool that automates the installation of multiple `.exe` applications in sequence — with logging, delay control, and resume capability.

---

## 🚀 Features

✔ Automatic detection of all `.exe` installers in the folder  
✔ Sequential installation (one-by-one execution)  
✔ Adjustable delay between installations  
✔ GUI dashboard for control and visibility  
✔ Installation logging with timestamps and duration  
✔ Skip already installed applications (log-based tracking)  
✔ Resume installation after system reboot  

---

## 📂 Folder Structure

Place the script and installers in the same directory:


MyInstallers/
│
├── installer-gui.ps1
├── installed.log (auto-generated)
├── Chrome.exe
├── VLC.exe
├── VSCode.exe


---

## ▶️ How to Use

### Step 1:
Copy all `.exe` installers into one folder

### Step 2:
Place `installer-gui.ps1` in the same folder

### Step 3:
Right-click → **Run with PowerShell**

---

### ⚠️ If script execution is blocked:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
⚙️ How It Works

This system follows a structured automation flow:

Detects its own folder location
Reads the installation log (installed.log)
Scans all .exe files in the directory
Compares each file against the log
Installs only those not already completed
Logs installation status, time, and duration
Applies a delay between installations
🧠 Why This Is Powerful

This system is:

✅ Reboot-safe
✅ Idempotent (no duplicate installs)
✅ Predictable and controlled
📊 Example Log Entry
Chrome.exe | Installed | 18.4 sec | 2026-01-20 12:10
VLC.exe    | Installed | 9.2 sec  | 2026-01-20 12:11
⚠️ Limitations
Installers run in normal mode (not silent)
Some applications may require user interaction
Failure detection is basic (no exit-code validation yet)
GPU / driver installers may behave differently
🔮 Future Improvements
Silent installation support (/S, /quiet)
Exit-code based success/failure detection
Progress bar UI
Installer selection (checkbox list)
Export logs to CSV / JSON
MSI support
🎯 Use Cases
New Windows setup automation
IT deployment workflows
Developer workstation setup
Bulk software installation
Personal productivity automation
🧩 Concept Behind This

This is not just a script — it is a system.

It demonstrates:

State tracking (log file)
Controlled execution (sequential installs)
Recovery (resume after interruption)
Observability (GUI + logs)
📺 Video Explanation

Watch full breakdown on YouTube:
👉 [ADD YOUR VIDEO LINK HERE]

🙌 Support

If you found this useful:

⭐ Star this repo
📺 Subscribe on YouTube
💬 Share feedback

📜 License

Free to use for learning and personal automation.

💡 Final Thought

Automation is not about doing things faster.

It’s about building systems that:

Don’t forget
Don’t repeat
Don’t break under interruption

---

# 📁 **PROJECT STRUCTURE (IMPORTANT)**

```plaintext
automated-windows-software-installer/
│
├── installer-gui.ps1     ← MAIN SCRIPT
├── installed.log         ← AUTO GENERATED (don’t upload)
├── setup.bat             ← INSTALLER (optional)
├── launch.bat            ← RUN TOOL (optional)
├── README.md
├── LICENSE
└── .gitignore
