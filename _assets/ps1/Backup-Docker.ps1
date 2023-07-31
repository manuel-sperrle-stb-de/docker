Get-ChildItem $PSScriptRoot -Recurse -File -Filter '*.Function.ps1' | ForEach-Object {
    $_.BaseName.TrimEnd('.Function') | Write-Host
    . $_.FullName
}

$BackupDockerParams = @{
    DockerPath = '/docker'
    BackupPath = '/media/sda'
}
Backup-Docker @BackupDockerParams