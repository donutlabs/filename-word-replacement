$rootDirectory = "c:/filepath"
$oldWord = "beans"
$newWord = "rice"

# Define a function to recursively rename files
function Rename-Files {
    param(
        [string]$directory,
        [string]$oldWord,
        [string]$newWord
    )
    # Get all files in the current directory
    $files = Get-ChildItem -Path $directory -File
    foreach ($file in $files) {
        # Check if the old word is present in the filename
        if ($file.Name -match $oldWord) {
            # Replace the old word with the new word
            $newFilename = $file.Name -replace $oldWord, $newWord
            # Construct the full paths for renaming
            $oldPath = $file.FullName
            $newPath = Join-Path -Path $directory -ChildPath $newFilename
            # Rename the file
            Rename-Item -Path $oldPath -NewName $newFilename -Force
            Write-Host "Renamed: $oldPath -> $newPath"
        }
    }
    # Recursively call the function for all subdirectories
    $subdirectories = Get-ChildItem -Path $directory -Directory
    foreach ($subdirectory in $subdirectories) {
        Rename-Files -directory $subdirectory.FullName -oldWord $oldWord -newWord $newWord
    }
}

# Call the function to start renaming files
Rename-Files -directory $rootDirectory -oldWord $oldWord -newWord $newWord
