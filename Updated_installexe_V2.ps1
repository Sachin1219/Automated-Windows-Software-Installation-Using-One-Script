Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ================= AUTO FOLDER =================
$ScriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
$LogFile = Join-Path $ScriptFolder "installed.log"

# ================= LOAD INSTALLED LIST =================
$installedApps = @()

if (Test-Path $LogFile) {
    $installedApps = Get-Content $LogFile | ForEach-Object {
        ($_ -split "\|")[0].Trim().ToLower()
    }
}

# ================= GUI =================
$form = New-Object System.Windows.Forms.Form
$form.Text = "Auto Installer System (Stable Version)"
$form.Size = New-Object System.Drawing.Size(700,520)
$form.StartPosition = "CenterScreen"

$title = New-Object System.Windows.Forms.Label
$title.Text = "Automated Installer Engine"
$title.Font = New-Object System.Drawing.Font("Arial",14,[System.Drawing.FontStyle]::Bold)
$title.Location = New-Object System.Drawing.Point(20,10)
$title.Size = New-Object System.Drawing.Size(400,30)
$form.Controls.Add($title)

$info = New-Object System.Windows.Forms.Label
$info.Text = "Folder: $ScriptFolder"
$info.Location = New-Object System.Drawing.Point(20,40)
$info.Size = New-Object System.Drawing.Size(650,20)
$form.Controls.Add($info)

# Delay
$delayLabel = New-Object System.Windows.Forms.Label
$delayLabel.Text = "Delay (sec):"
$delayLabel.Location = New-Object System.Drawing.Point(20,80)
$form.Controls.Add($delayLabel)

$delayBox = New-Object System.Windows.Forms.TextBox
$delayBox.Text = "3"
$delayBox.Location = New-Object System.Drawing.Point(120,80)
$delayBox.Size = New-Object System.Drawing.Size(50,20)
$form.Controls.Add($delayBox)

# Output
$outputBox = New-Object System.Windows.Forms.TextBox
$outputBox.Location = New-Object System.Drawing.Point(20,120)
$outputBox.Size = New-Object System.Drawing.Size(640,300)
$outputBox.Multiline = $true
$outputBox.ScrollBars = "Vertical"
$form.Controls.Add($outputBox)

# ================= START BUTTON =================
$startBtn = New-Object System.Windows.Forms.Button
$startBtn.Text = "START INSTALL"
$startBtn.Location = New-Object System.Drawing.Point(20,440)
$startBtn.Size = New-Object System.Drawing.Size(200,30)

$startBtn.Add_Click({

    $delay = [int]$delayBox.Text

    $files = Get-ChildItem -Path $ScriptFolder -Filter *.exe | Sort-Object Name

    foreach ($file in $files) {

        $fileName = $file.Name.ToLower()

        # ================= SKIP =================
        if ($installedApps -contains $fileName) {
            $outputBox.AppendText("[SKIP] $($file.Name)`r`n")
            continue
        }

        $outputBox.AppendText("[RUN] $($file.Name)`r`n")

        $startTime = Get-Date

        try {

            # ================= SAFE EXECUTION METHOD =================
            $exePath = $file.FullName

            $cmd = "start `"`" `"$exePath`""

            $process = Start-Process -FilePath "cmd.exe" `
                -ArgumentList "/c $cmd" `
                -PassThru -Wait

            # assume success if launched
            $endTime = Get-Date
            $duration = ($endTime - $startTime).TotalSeconds

            $logEntry = "$($file.Name) | Installed | $([math]::Round($duration,2)) sec | $(Get-Date)"
            Add-Content $LogFile $logEntry

            $installedApps += $fileName

            $outputBox.AppendText("[DONE] $($file.Name)`r`n")

        }
        catch {
            $outputBox.AppendText("[ERROR] Cannot run $($file.Name)`r`n")
        }

        Start-Sleep -Seconds $delay
        $outputBox.AppendText("Waiting $delay sec...`r`n")
    }

    $outputBox.AppendText("===== ALL DONE =====`r`n")
})

$form.Controls.Add($startBtn)

$form.Topmost = $true
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()