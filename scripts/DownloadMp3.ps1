$links = Get-Item -Path ".\linklist.txt"
New-Item -ItemType Directory -Path ".\bin" -Force
$app = Get-Item -Path ".\bin\yt-dlp.exe"
$output = New-Item -ItemType Directory -Path ".\download" -Force

$logs = New-Item -ItemType Directory -Path ".\logs" -Force
$timestamp = Get-Date -Format "yyyy-MM-dd"
$logFile = "$($logs.FullName)\log_$timestamp.txt"

$cmdCommand = "`"$($app.FullName)`" -x --audio-format mp3 -S `"br`" --output `"$output\%(title)s.%(ext)s`" --force-overwrites --batch-file `"$($links.FullName)`" 2>&1"
& C:\Windows\System32\cmd.exe /c $cmdCommand | Tee-Object -Append -FilePath $logFile