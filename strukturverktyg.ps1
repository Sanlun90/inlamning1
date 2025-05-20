# Funktion för att skapa mappstruktur
function SkapaMapp {
    param (
        [string]$Namn
    )

    $sökväg = Join-Path -Path (Get-Location) -ChildPath $Namn

    if (-not (Test-Path -Path $sökväg)) {
        New-Item -ItemType Directory -Path $sökväg | Out-Null
        Write-Host "Mappen '$Namn' har skapats."
    } else {
        Write-Host "Mappen '$Namn' finns redan."
    }
}

# Anropa funktionen
$namn = "MinMapp"
SkapaMapp -Namn $namn
