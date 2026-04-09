# Automated-Windows-Software-Installation-Using-One-Script
🧠 Automated Windows Software Installation System

A PowerShell-based GUI tool that automates the installation of multiple .exe applications in sequence with logging, delay control, and resume capability.

🚀 Features
Automatic detection of all .exe installers in the folder
Sequential installation (one-by-one execution)
Adjustable delay between installations
GUI dashboard for control and visibility
Installation logging with timestamps and duration
Skip already installed applications (log-based tracking)
Resume installation after system reboot
📂 Folder Structure

Place the script and installers in the same directory:

MyInstallers/
│── installer-gui.ps1
│── installed.log   (auto-generated)
│── App1.exe
│── App2.exe
│── App3.exe
▶️ How to Use
Copy all .exe installers into one folder
Place installer-gui.ps1 in the same folder
Right-click → Run with PowerShell

If script execution is blocked, run:

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
⚙️ How It Works

The script follows a simple system design:

Detects its own folder location
Reads the installation log file (installed.log)
Scans all .exe files in the directory
Compares each file against the log
Installs only those not already completed
Logs installation status, time, and duration
Applies a delay between installations

This makes the system:

Reboot-safe
Idempotent (no duplicate installs)
Predictable and controlled
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

Watch the full breakdown on YouTube:
👉 (Add your video link here)

📜 License

Free to use for learning and personal automation.

💡 Final Thought

Automation is not about doing things faster.

It’s about building systems that:

Don’t forget
Don’t repeat
And don’t break under interruption
