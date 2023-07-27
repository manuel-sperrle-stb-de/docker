'/root/.config/powershell/profile.ps1'

'Get/Set PSRepository PSGallery Trusted'
if (-not ((Get-PSRepository PSGallery).InstallationPolicy -eq 'Trusted')) { Set-PSRepository PSGallery -InstallationPolicy Trusted }

'Install/Import Module DockerCompletion'
if (-not (Get-InstalledModule DockerCompletion -ErrorAction SilentlyContinue)) { Install-Module DockerCompletion }
if (-not (Get-Module DockerCompletion)) { Import-Module DockerCompletion }

'Dot-sourcing *.Function.ps1 from $PSScriptRoot'
Get-ChildItem $PSScriptRoot -Recurse -Filter '*.Function.ps1' | ForEach-Object { 
    $_.FullName
    . $_.FullName 
}