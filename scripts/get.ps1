$name = "pack-repo"
$version = "canary"
$url = "https://github.com/Azure/draft-$name/releases/download/$version/$name-$version-windows-amd64.zip"

if ($env:TEMP -eq $null) {
  $env:TEMP = Join-Path $env:SystemDrive 'temp'
}
$tempDir = Join-Path $env:TEMP $name
if (![System.IO.Directory]::Exists($tempDir)) {[void][System.IO.Directory]::CreateDirectory($tempDir)}
$file = Join-Path $env:TEMP "$name-$version-windows-amd64.zip"

Write-Output "Downloading $url"
(new-object System.Net.WebClient).DownloadFile($url, $file)

$installPath = "$env:DRAFT_HOME\plugins\draft-pack-repo\bin"
if (![System.IO.Directory]::Exists($installPath)) {[void][System.IO.Directory]::CreateDirectory($installPath)}
Write-Output "Preparing to install into $installPath"

Expand-Archive -Path "$file" -DestinationPath "$tempDir" -Force
Move-Item -Path "$tempDir\windows-amd64\$name.exe" -Destination "$installPath\$name.exe"

Write-Output "$name installed into $installPath\$name.exe"
