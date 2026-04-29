$ErrorActionPreference = "Stop"

$REPO = "quanthumtech/qai-v2"
$BIN_DIR = if ($env:QAI_INSTALL) { $env:QAI_INSTALL } else { "C:\Program Files\qaicli" }

# Detect arch
$ARCH = if ($env:PROCESSOR_ARCHITECTURE -eq "AMD64") { "x64" } elseif ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") { "arm64" } else { "x64" }
$PLATFORM = "windows-$ARCH"

# Get latest release tag
$TAG = (Invoke-RestMethod "https://api.github.com/repos/$REPO/releases/latest").tag_name

$URL = "https://github.com/$REPO/releases/download/$TAG/qaicli-$PLATFORM.exe"

Write-Host "Installing qaicli $TAG..."

# Download
$TempFile = "$env:TEMP\qaicli.exe"
Invoke-WebRequest -Uri $URL -OutFile $TempFile -UseBasicParsing

# Create directory if needed
if (!(Test-Path $BIN_DIR)) {
    New-Item -ItemType Directory -Path $BIN_DIR -Force | Out-Null
}

# Move to bin (handle admin)
$Dest = "$BIN_DIR\qaicli.exe"
try {
    Move-Item -Path $TempFile -Destination $Dest -Force
    Copy-Item -Path $Dest -Destination "$BIN_DIR\qai.exe" -Force
} catch {
    # Need admin
    $adminDest = "$Dest"
    Start-Process powershell -Verb RunAs -ArgumentList "-Command", "Move-Item -Path '$TempFile' -Destination '$adminDest' -Force" -Wait -NoNewWindow
    Start-Process powershell -Verb RunAs -ArgumentList "-Command", "Copy-Item -Path '$adminDest' -Destination '$BIN_DIR\qai.exe' -Force" -Wait -NoNewWindow
}

# Add to PATH if needed
$UserPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($UserPath -notlike "*$BIN_DIR*") {
    [Environment]::SetEnvironmentVariable("PATH", "$UserPath;$BIN_DIR", "User")
    Write-Host "Added $BIN_DIR to PATH"
}

Write-Host "✓ qaicli installed to $BIN_DIR\qaicli.exe"
Write-Host "✓ qai installed to $BIN_DIR\qai.exe"
Write-Host "  Run: qai"