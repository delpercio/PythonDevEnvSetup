# Check if Python is already installed
if ($null -ne $(Get-Command python).Source) {
    Write-Output "Python is already installed. Skipping installation."
}
else {
    # Download the latest Python 3.x release from the official website
    $pythonUrl = "https://www.python.org/ftp/python/3.X.X/python-3.X.X-amd64.exe"
    $pythonExe = "$($env:TEMP)\python-3.X.X-amd64.exe"
    Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonExe

    # Install Python with the default options
    Start-Process $pythonExe -Wait -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1"
}

# Check if pip is already installed
if ($null -ne $(Get-Command pip).Source) {
    Write-Output "pip is already installed. Skipping installation."
}
else {
    # Download get-pip.py from the official website
    $pipUrl = "https://bootstrap.pypa.io/get-pip.py"
    $pipPy = "$($env:TEMP)\get-pip.py"
    Invoke-WebRequest -Uri $pipUrl -OutFile $pipPy

    # Install pip using Python
    python $pipPy
}

# Check if virtualenv is already installed
if ($null -ne $(Get-Command virtualenv).Source) {
    Write-Output "virtualenv is already installed. Skipping installation."
}
else {
    # Install virtualenv using pip
    pip install virtualenv
}

# Check if Visual Studio Code is already installed
if ($null -ne (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction SilentlyContinue | 
        Where-Object { $_.DisplayName -eq 'Microsoft Visual Studio Code' })) {
    Write-Output "Visual Studio Code is already installed. Skipping installation."
}
else {
    # Download the latest Visual Studio Code release from the official website
    $vscodeUrl = "https://az764295.vo.msecnd.net/stable/1f5e91b4d3b5aad98db510e2c3ea3ef6841a53e6/VSCodeUserSetup-x64-1.X.X.exe"
    $vscodeExe = "$($env:TEMP)\VSCodeUserSetup-x64-1.X.X.exe"
    Invoke-WebRequest -Uri $vscodeUrl -OutFile $vscodeExe

    # Install Visual Studio Code with the default options
    Start-Process $vscodeExe -Wait -ArgumentList "/verysilent"
}

# Create a new virtual environment for the project
virtualenv myproject

# Activate the virtual environment
.\myproject\Scripts\Activate.ps1

# Install the required packages for the project
pip install -r requirements.txt

# Open the project folder in Visual Studio Code
& "C:\Program Files\Microsoft VS Code\Code.exe" .