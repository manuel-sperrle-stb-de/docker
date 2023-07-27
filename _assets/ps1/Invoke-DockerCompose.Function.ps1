Function Invoke-DockerCompose {

    [CmdletBinding()]
    param (
        
        [string]$Name,
        
        [ValidateSet('Restart', 'Up', 'Down')]
        [string]$Action = 'Up',

        [switch]$Pull,

        [switch]$NoBuild,
        [switch]$NoDetach,
        [switch]$NoForceRecreate,
        [switch]$NoRemoveOrphans,
        [switch]$NoRenewAnonVolumes

    )   

    # Get and filter files
    $Files = Get-ChildItem -Recurse -File -Filter '*docker-compose.yml' | Select-Object -ExpandProperty FullName
    if ($Name) { $Files = $Files | Where-Object { $_ -match $Name } }

    # switch action to boolean up&down
    switch ($Action) {
        'Restart' {
            $Up = $true
            $Down = $true    
        }
        'Up' { 
            $Up = $true 
            $Down = $false
        }
        'Down' { 
            $Up = $false
            $Down = $true 
        }
    }

    $Params = @{
        Up = @(

            if ($Pull) { '--pull always' }

            if (-not $NoBuild) { '--build' } 
            if (-not $NoForceRecreate) { '--force-recreate' }
            if (-not $NoDetach) { '-d' }
            if (-not $NoRemoveOrphans) { '--remove-orphans' }
            if (-not $NoRenewAnonVolumes) { '--renew-anon-volumes' }
            
        )
    }

    [Collections.Generic.List[object]]$Expressions = @()

    if ($Down) {
        $Files | ForEach-Object -Parallel {
            $Expression = 'docker compose -f "{0}" down' -f $PSItem 
            ($Using:Expressions).Add($Expression)
        }
    }

    if ($Up) {
        $Files | ForEach-Object -Parallel {
            $Expression = 'docker compose -f "{0}" up {1}' -f $PSItem, (($Using:Params).Up -join ' ').Trim()
            ($Using:Expressions).Add($Expression)
        }    
    }

    # Output
    'Performing Action: "{0}"' -f $Action
    $Files
    $Expressions
    $Expressions | ForEach-Object -Parallel { $PSItem | Invoke-Expression }

}