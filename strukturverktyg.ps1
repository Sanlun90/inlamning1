function SkapaMapp {
    param (
        [string]$Namn
    )

    $stig = Join-Path -Path (Get-Location) -ChildPath $Namn

    try {
        if (Test-Path $stig) {
            Write-Host "Mappen '$Namn' finns redan."
        } else {
            New-Item -Path $stig -ItemType Directory | Out-Null
            Write-Host "Mappen '$Namn' har skapats."
        }

        # Skapa undermappar oavsett om huvudmappen redan fanns eller inte
        $undermappar = @("logs", "scripts", "temp")
        foreach ($mapp in $undermappar) {
            $undermappStig = Join-Path $stig $mapp
            if (-not (Test-Path $undermappStig)) {
                New-Item -Path $undermappStig -ItemType Directory | Out-Null
                Write-Host "Undermapp '$mapp' skapades."
            } else {
                Write-Host "Undermapp '$mapp' finns redan."
            }
        }
    }
    catch {
        Write-Error "Fel vid skapande av mappstruktur: $_"
    }
}

# Anropa funktionen
$namn = "MinMapp"
SkapaMapp -Namn $namn
