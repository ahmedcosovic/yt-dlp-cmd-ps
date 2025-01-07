cd ..
powershell -command "if (!(Test-Path -Path ".\linklist.txt")) { New-Item -ItemType File -Path ".\linklist.txt" }"
powershell -ExecutionPolicy RemoteSigned -File ".\scripts\updateBinary.ps1"
powershell -ExecutionPolicy RemoteSigned -File ".\scripts\updateFfmpeg.ps1"
PAUSE