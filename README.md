# USB Sync PowerShell Script

This PowerShell script copies specified files and folders from a source directory to a specific folder on a USB drive when the drive is plugged in. The source directory, list of items to copy, and other settings are configured in an external configuration file.

## Prerequisites

- Windows operating system
- PowerShell installed
- A USB drive with a known volume label and serial number


## Getting Drive Information

To get the necessary information about your USB drive (drive letter, volume label, and unique serial number), you can use the following PowerShell command:

```powershell
Get-Volume -DriveLetter H | Select-Object -Property DriveLetter, FileSystemLabel, UniqueId
```

## Configuration

1. Create a configuration file named `config.txt` in a directory.

2. Add the following settings to `config.txt`, replacing the placeholders with your actual values:

    ```plaintext
    TargetDriveLetter=YOUR_DRIVE_LETTER
    TargetLabel=YOUR_USB_LABEL
    TargetSerialNumber=YOUR_USB_SERIAL_NUMBER
    SourceDirectory=YOUR_SOURCE_DIRECTORY
    ItemsToCopy=YOUR_ITEMS_TO_COPY
    DestinationFolder=YOUR_DESTINATION_FOLDER
    ```

    - `TargetDriveLetter`: The drive letter assigned to your USB drive.
    - `TargetLabel`: The volume label of your USB drive.
    - `TargetSerialNumber`: The unique serial number of your USB drive.
    - `SourceDirectory`: The directory containing the files and folders you want to copy.
    - `ItemsToCopy`: A comma-separated list of files and folders to copy.
    - `DestinationFolder`: The folder on the USB drive where the items will be copied.
