# yt-dlp

New-Item -ItemType Directory ".\bin" -Force -Verbose
$binaryLocation = ".\bin\yt-dlp.exe"
$backupLocation = ".\temp\yt-dlp_bkp.exe"

if (Test-Path $binaryLocation) {
	Move-Item -Path $binaryLocation -Destination $backupLocation -ErrorAction Stop
}

try {
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
} catch {
	if (Test-Path $backupLocation) {
		Move-Item -Path $backupLocation -Destination $binaryLocation -ErrorAction Stop
	}
	Write-Host "Error: $_"
}
