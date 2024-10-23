Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Realmsgate Mini Launcher'
$form.Size = New-Object System.Drawing.Size(300, 150)

# Create a label for status
$label = New-Object System.Windows.Forms.Label
$label.Text = 'Preparing to download Minecraft Installer...'
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(10, 20)
$form.Controls.Add($label)

# Create a progress bar
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(10, 50)
$progressBar.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($progressBar)

# Create a button to cancel
$button = New-Object System.Windows.Forms.Button
$button.Text = 'Cancel'
$button.Location = New-Object System.Drawing.Point(10, 80)
$button.Add_Click({
    $form.Close()
})
$form.Controls.Add($button)

# Show the form
$form.Show()

# Define download link and temp file
$downloadLink = "https://github.com/Abhinav2011VS/Realmsgate-Mini/releases/download/v0.1.0/Realmsgate-Mini-installer-0.1.0.exe"
$tempInstaller = "$env:TEMP\Realmsgate-Mini-installer.exe"

# Download the installer synchronously
try {
    $client = New-Object System.Net.WebClient

    # Start downloading
    $client.DownloadFile($downloadLink, $tempInstaller)

    # Update UI on completion
    $label.Text = "Download completed!"
    Start-Sleep -Seconds 1

    # Execute the downloaded installer
    Start-Process $tempInstaller -Verb RunAs

} catch {
    [System.Windows.Forms.MessageBox]::Show("Failed to download the Minecraft installer. Error: $_", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
} finally {
    # Ensure the form closes
    $form.Close()
}