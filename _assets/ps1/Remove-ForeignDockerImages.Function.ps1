Function Remove-ForeignDockerImages {

    param (
        [Parameter(Mandatory)]
        [string]
        $RegistryName
    )

    docker image ls --format json | ConvertFrom-Json | Where-Object { $_.Repository -notmatch $RegistryName } | ForEach-Object { docker image rm ('{0}:{1}' -f $_.Repository, $_.Tag) }

}
