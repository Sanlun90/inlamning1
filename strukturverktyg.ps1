# Funktion för att skapa mappstruktur
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
    }
    catch {
        Write-Error "Fel vid skapande av mapp: $_"
    }
}

# Anropa funktionen
$namn = "MinMapp"
SkapaMapp -Namn $namn
