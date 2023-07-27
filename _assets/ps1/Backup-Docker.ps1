Function Backup-Docker {

    param (
        $DockerPath = '/docker',
        $BackupPath = '/media/sda'
    )

    $StartLocation = Get-Location
    
    try {
        
        Set-Location $DockerPath

        Invoke-DockerCompose -Action Down

        $TimeStamp = Get-Date -Format FileDateTimeUniversal
        $BackupLocation = Join-Path $BackupPath ('docker-{0}.tar.gz' -f $TimeStamp)
        tar czf $BackupLocation $DockerPath

        Invoke-DockerCompose -Action Up

    }
    catch {
        Set-Location $StartLocation
    }
    Set-Location $StartLocation

}