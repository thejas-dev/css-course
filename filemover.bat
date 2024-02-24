@echo off
setlocal enabledelayedexpansion

rem Set the limit of files per folder
set "filesPerFolder=100"

rem Count total number of files
set "totalFiles=0"
for %%F in (*) do (
    set /a "totalFiles+=1"
)

rem Calculate total number of folders needed
set /a "totalFolders=(totalFiles+filesPerFolder-1)/filesPerFolder"

rem Create folders
for /L %%i in (1, 1, %totalFolders%) do (
    mkdir "Folder%%i"
)

set "counter=0"
set "folderNumber=1"

rem Iterate through files and move them to respective folders
for %%F in (*) do (
    set /a "counter+=1"
    set /a "folderNumber=(counter-1)/filesPerFolder + 1"

    rem Create a new folder if needed
    if not exist "Folder!folderNumber!" (
        mkdir "Folder!folderNumber!"
    )

    rem Move the file to the corresponding folder
    move "%%F" "Folder!folderNumber!"
)

echo Files have been distributed into dynamically created folders.
