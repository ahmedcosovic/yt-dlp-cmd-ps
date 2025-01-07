$binaryLocation = New-Item -ItemType Directory ".\bin" -Force -Verbose
$tempLocation = New-Item -ItemType Directory ".\temp" -Force -Verbose

$curlPs = Invoke-WebRequest -Uri "https://api.github.com/repos/GyanD/codexffmpeg/releases/latest"
$finalDownloadLink = ($curlPs.Content | ConvertFrom-Json).assets.browser_download_url | Where-Object { $_ -like "*essentials_build.zip" }
$fileName = $finalDownloadLink.Substring($finalDownloadLink.LastIndexOf("/")+1)
$fileNameExZip = $fileName.Trim(".zip")

Invoke-WebRequest -Uri $finalDownloadLink -OutFile "$tempLocation\$fileName"
Expand-Archive "$tempLocation\$fileName" -DestinationPath $tempLocation
Move-Item -Path "$tempLocation\$fileNameExZip\bin\ffmpeg.exe" -Destination $binaryLocation -Force -Verbose
Move-Item -Path "$tempLocation\$fileNameExZip\bin\ffplay.exe" -Destination $binaryLocation -Force -Verbose
Move-Item -Path "$tempLocation\$fileNameExZip\bin\ffprobe.exe" -Destination $binaryLocation -Force -Verbose
Remove-Item "$tempLocation\*" -Force -Recurse