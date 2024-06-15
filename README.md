# USB Sync PowerShell Script

This PowerShell script copies specified files and folders from a source directory to a specific folder on a USB drive when the drive is plugged in. The source directory, list of items to copy, and other settings are configured in an external configuration file.

## Prerequisites

- Windows operating system
- PowerShell installed
- A USB drive with a known volume label and serial number

## Configuration

1. Create a configuration file named `config.txt` in a directory that will be ignored by Git (ensure this directory is listed in your `.gitignore` file).

2. Add the following settings to `config.txt`, replacing the placeholders with your actual values:

    ```plaintext
    TargetDriveLetter=H
    TargetLabel=USB_SYNC
    TargetSerialNumber=\\?\Volume{1ca28332-127b-11ef-865e-b4b5b692a164}\
    SourceDirectory=C:\Users\karan\PycharmProjects\pmt-backend
    ItemsToCopy=file1.txt,local_manage.py,local_pmt
    DestinationFolder=pmt_backend
    ```

    - `TargetDriveLetter`: The drive letter assigned to your USB drive.
    - `TargetLabel`: The volume label of your USB drive.
    - `TargetSerialNumber`: The unique serial number of your USB drive.
    - `SourceDirectory`: The directory containing the files and folders you want to copy.
    - `ItemsToCopy`: A comma-separated list of files and folders to copy.
    - `DestinationFolder`: The folder on the USB drive where the items will be copied.
