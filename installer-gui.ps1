Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ---------------- SETTINGS ----------------
$ScriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
$LogFile = Join-Path $ScriptFolder "installed.log"
if (!(Test-Path $LogFile)) { New-Item $LogFile -ItemType File | Out-Null }

# ---------------- FORM ----------------
$form = New-Object System.Windows.Forms.Form
$form.Text = "Installer Dashboard"
$form.Size = New-Object System.Drawing.Size(650,500)
$form.StartPosition = "CenterScreen"

# Delay Label
$lblDelay = New-Object System.Windows.Forms.Label
$lblDelay.Text = "Delay (seconds):"
$lblDelay.Location = New-Object System.Drawing.Point(20,20)
$form.Controls.Add($lblDelay)

# Delay Input
$numDelay = New-Object System.Windows.Forms.NumericUpDown
$numDelay.Minimum = 0
$numDelay.Maximum = 300
$numDelay.Value = 3
$numDelay.Location = New-Object System.Drawing.Point(140,18)
$form.Controls.Add($numDelay)

# Start Button
$btnStart = New-Object System.Windows.Forms.Button
$btnStart.Text = "Start Installation"
$btnStart.Location = New-Object System.Drawing.Point(300,15)
$form.Controls.Add($btnStart)

# Log Box
$logBox = New-Object System.Windows.Forms.TextBox
$logBox.Multiline = $true
$logBox.ScrollBars = "Vertical"
$logBox.ReadOnly = $true
$logBox.Size = New-Object System.Drawing.Size(600,380)
$logBox.Location = New-Object System.Drawing.Point(20,60)
$form.Controls.Add($logBox)

# ---------------- FUNCTIONS ----------------
function Log($msg) {
    $time = (Get-Date).ToString("HH:mm:ss")
    $logBox.AppendText("[$time] $msg`r`n")
}

# ---------------- BUTTON ACTION ----------------
$btnStart.Add_Click({

    $Delay = [int]$numDelay.Value
    $Installed = Get-Content $LogFile

    $exeFiles = Get-ChildItem $ScriptFolder -Filter "*.exe" | Sort-Object Name

    foreach ($file in $exeFiles) {

        if ($Installed -contains $file.Name) {
            Log "Skipping (already installed): $($file.Name)"
            continue
        }

        Log "Installing: $($file.Name)"
        $startTime = Get-Date

        Start-Process -FilePath $file.FullName -Wait

        $endTime = Get-Date
        $duration = [math]::Round(($endTime - $startTime).TotalSeconds,2)

        Add-Content $LogFile "$($file.Name) | Installed | $duration sec | $endTime"
        Log "Completed: $($file.Name) in $duration sec"

        Start-Sleep -Seconds $Delay
    }

    Log "✅ All installations finished"
})

# ---------------- RUN ----------------
$form.Topmost = $true
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()