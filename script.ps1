# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process ->This is pre-requisite for setting execution policy

### Install Azure CLI
Write-Output "Azure CLI installation started."
# Download the Azure CLI installer
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
 
# Install Azure CLI silently
Start-Process msiexec.exe -Wait -ArgumentList '/i AzureCLI.msi /quiet'
 
# Clean up the downloaded installer
Remove-Item .\AzureCLI.msi
 
# Add Azure CLI installation directory to PATH
$env:Path += ";C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin"
 
Write-Output "Azure CLI installation complete."

### Install GIT
Write-Output "Git installation started." 
# get latest download url for git-for-windows 64-bit exe
$git_url = "https://api.github.com/repos/git-for-windows/git/releases/latest"
$asset = Invoke-RestMethod -Method Get -Uri $git_url | % assets | where name -like "*64-bit.exe"

# download installer
$installer = "$env:temp\$($asset.name)"
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $installer

# run installer
$git_install_inf = "<install inf file>"
$install_args = "/SP- /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL /NORESTART /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /LOADINF=""$git_install_inf"""
Start-Process -FilePath $installer -ArgumentList $install_args -Wait
Write-Output "Git installation completed."


### docker 
Write-Output "Docker installation started."
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1" -o install-docker-ce.ps1
.\install-docker-ce.ps1
# Clean up the downloaded installer
Remove-Item .\install-docker-ce.ps1
Write-Output "Docker installation completed."


### visual studio
# Define the URL of Visual Studio Professional
$url = "https://download.visualstudio.microsoft.com/download/pr/e730a0bd-baf1-4f4c-9341-ca5a9caf0f9f/4358b712148b3781631ab8d0eea42af736398c8b44fba868b76cb255b3de7e7c/vs_Professional.exe"

# Define the local path where the installer will be saved
$filePath = "C:\Users\alijon\Downloads\vs_Professional.exe"

# Define installation options (modify as needed)
$vsOptions = "/quiet /norestart"

# Create the directory if it doesn't exist
if (!(Test-Path -Path $filePath)) {
    New-Item -ItemType Directory -Path (Split-Path -Parent $filePath) -Force | Out-Null
}

# Download Visual Studio Professional installer
Invoke-WebRequest -Uri $url -OutFile $filePath

# Check if the download was successful
if (Test-Path $filePath) {
    Write-Output "Download completed. Starting installation..."

    # Start the installation process
    Start-Process -FilePath $filePath -ArgumentList $vsOptions -Wait
} else {
    Write-Output "Failed to download the installer from $url"
}


