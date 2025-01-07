New-Item -ItemType Directory ".\bin" -Force -Verbose
$binaryLocation = ".\bin\yt-dlp.exe"

$curlPs = Invoke-WebRequest -Uri "https://api.github.com/repos/yt-dlp/yt-dlp/releases/latest"
$downloadLink32 = ($curlPs.Content | ConvertFrom-Json).assets.browser_download_url | Where-Object { $_ -like "*yt-dlp_x86.exe" }
$downloadLink64 = ($curlPs.Content | ConvertFrom-Json).assets.browser_download_url | Where-Object { $_ -like "*yt-dlp.exe" }

if ([Environment]::Is64BitOperatingSystem) {
    $finalDownloadLink = $downloadLink64
} else {
    $finalDownloadLink = $downloadLink32
}

if (Test-Path $binaryLocation) {
    Remove-Item $binaryLocation -Force -Verbose
}

Invoke-WebRequest -Uri $finalDownloadLink -OutFile $binaryLocation