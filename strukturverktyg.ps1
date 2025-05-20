# Fråga användaren om mappnamn
$namn = Read-Host "Ange ett namn för mappen"

# Funktion för att skapa en mapp
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

# Skapa undermappar
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

    return $stig  
}

# Anropa funktionen och spara huvudmappens sökväg
$namn = "MinMapp"
$stig = SkapaMapp -Namn $namn

# Skapa loggfil med dagens datum
try {
    $datum = Get-Date -Format "yyyy-MM-dd"
    $loggFilnamn = "log-$datum.txt"
    $loggStig = Join-Path -Path (Join-Path $stig "logs") -ChildPath $loggFilnamn

# Skriv loggmeddelande
    $loggText = "Loggfilen skapad: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    $loggText | Out-File -FilePath $loggStig -Encoding UTF8 

    Write-Host "Loggfilen är sparad i: $stig"
    Write-Host "Loggfil skapad: $loggStig"
}
catch {
    Write-Host "Ett fel uppstod: $_"
}


