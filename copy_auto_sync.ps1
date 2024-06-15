$targetDriveLetter = "H"  
$targetDriveLetterWithColon = $targetDriveLetter + ":"
$targetLabel = "USB_SYNC"  
$targetSerialNumber = "\\?\Volume{1ca28332-127b-11ef-865e-b4b5b692a164}\"  
$configFilePath = "A:\Scripts\usb_auto_sync\config.txt"  # Replace with the actual path to your config file

$drive = Get-Volume -FileSystemLabel $targetLabel

if ($drive -and $drive.DriveLetter -eq $targetDriveLetter -and $drive.UniqueId -eq $targetSerialNumber) {
    Start-Process explorer.exe -ArgumentList $targetDriveLetterWithColon
}
# Function to read the configuration file and return a hashtable of key-value pairs
function Get-Config {
    param (
        [string]$path
    )

    $config = @{}
    $lines = Get-Content $path

    foreach ($line in $lines) {
        $parts = $line -split '='
        if ($parts.Count -eq 2) {
            $key = $parts[0].Trim()
            $value = $parts[1].Trim()
            $config[$key] = $value
        }
    }

    return $config
}

# Read the configuration file
$config = Get-Config -path $configFilePath

# Extract the source directory and items to copy from the configuration
$sourceDirectory = $config["SourceDirectory"]
$itemsToCopy = $config["ItemsToCopy"] -split ','
$destinationFolder = $config["DestinationFolder"]

$destinationDirectory = Join-Path -Path $targetDriveLetterWithColon -ChildPath $destinationFolder

$drive = Get-Volume -FileSystemLabel $targetLabel

if ($drive -and $drive.DriveLetter -eq $targetDriveLetter -and $drive.UniqueId -like "*$targetSerialNumber*") {
    foreach ($item in $itemsToCopy) {
        $sourcePath = Join-Path -Path $sourceDirectory -ChildPath $item
        $destinationPath = Join-Path -Path $destinationDirectory -ChildPath $item

        if (Test-Path $sourcePath) {
            Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force
        } else {
            Write-Host "Source item does not exist: $sourcePath"
        }
    }
}