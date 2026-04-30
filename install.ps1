$ErrorActionPreference = "Stop"

$REPO = "quanthumtech/qai-v2"
$BIN_DIR = if ($env:QAI_INSTALL) { $env:QAI_INSTALL } else { "$env:LOCALAPPDATA\qaicli" }

# Detect arch
$ARCH = if ($env:PROCESSOR_ARCHITECTURE -eq "AMD64") { "x64" } elseif ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") { "arm64" } else { "x64" }

# Get latest release tag
$TAG = (Invoke-RestMethod "https://api.github.com/repos/$REPO/releases/latest").tag_name

$URL = "https://github.com/$REPO/releases/download/$TAG/qaicli"

Write-Host "Installing qaicli $TAG..."

# Create directory if needed
if (!(Test-Path $BIN_DIR)) {
    New-Item -ItemType Directory -Path $BIN_DIR -Force -ErrorAction SilentlyContinue | Out-Null
}

# If still doesn't exist, try with admin
if (!(Test-Path $BIN_DIR)) {
    $tempDir = "$env:TEMP\qaicli_install"
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
    $BIN_DIR = $tempDir
    Write-Host "Using temp directory: $BIN_DIR"
}

# Download with timeout for large file
$TempFile = "$env:TEMP\qaicli.exe"
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($URL, $TempFile)
} catch {
    # Fallback to Invoke-WebRequest with timeout
    $TimeoutSec = 300
    Invoke-WebRequest -Uri $URL -OutFile $TempFile -UseBasicParsing -TimeoutSec $TimeoutSec
}

# Move to bin
$Dest = "$BIN_DIR\qaicli.exe"
Move-Item -Path $TempFile -Destination $Dest -Force
Copy-Item -Path $Dest -Destination "$BIN_DIR\qai.exe" -Force

# Add to PATH if needed
$UserPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($UserPath -notlike "*$BIN_DIR*") {
    [Environment]::SetEnvironmentVariable("PATH", "$UserPath;$BIN_DIR", "User")
    Write-Host "Added $BIN_DIR to PATH (may need restart)"
}

Write-Host "✓ qaicli installed to $BIN_DIR\qaicli.exe"
Write-Host "✓ qai installed to $BIN_DIR\qai.exe"
Write-Host "  Run: qai (or use full path: $BIN_DIR\qai.exe)"