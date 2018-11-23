."H:\12\AWP\MiniRPG_12FI3\actorsrpg.ps1"
."H:\12\AWP\MiniRPG_12FI3\classesrpg.ps1"
."H:\12\AWP\MiniRPG_12FI3\creaturesrpg.ps1"

########## initialisiert das Spielbrett 
$spielbrett = [spielbrett]::new()
$spielfeld1 = [spielfeld]::new()
$spielfeld2 = [spielfeld]::new()
$spielfeld3 = [spielfeld]::new()

########## initialisiert die Spieler
$spieler1 = [magier]::new("Bob", 101)
$spieler2 = [krieger]::new("Hubert", 102)

########## initialisiert die gegner
$kreaturname = generateName("Goblin")
$gegner1 = [goblin]::new($kreaturname, 201)
$kreaturname = generateName("Goblin")
$gegner2 = [goblin]::new($kreaturname, 202)
$kreaturname = generateName("Goblin")
$gegner3 = [goblin]::new($kreaturname, 203)
$kreaturname = generateName("Troll")
$gegner4 = [troll]::new($kreaturname, 204)

##########  fügt gegner den spielfeldern hinzu
[void]$spielfeld1.kreaturen.Add($gegner1)
[void]$spielfeld2.kreaturen.Add($gegner2)
[void]$spielfeld2.kreaturen.Add($gegner3)
[void]$spielfeld3.kreaturen.Add($gegner4)

########## fügt Spielfelder dem Spielbrett hinzu
[void]$spielbrett.spielfelder.Add($spielfeld1)
[void]$spielbrett.spielfelder.Add($spielfeld2)
[void]$spielbrett.spielfelder.Add($spielfeld3)

########## fügt Helden der Party hinzu
$party = [party]::new()
[void]$party.helden.Add($spieler1)
[void]$party.helden.Add($spieler2)

########## Gameplay Loop

########## Sind wir nicht über das Spielfeld hinausgeschossen?
while ($party.feld -lt $spielbrett.spielfelder.Count) {

    ########## Sind noch Kreaturen auf dem aktuellen Spielfeld? 
    while (($spielbrett.spielfelder[$party.feld]).kreaturen.Count -ne 0) {
        ########## Hat die Party noch Aktionen über?
        while ($party.cooldown -eq $false) {
            ########## Spieleraktion
            foreach ($spieler in $party.helden) {
                Write-Host "1. Angreifen"
                Write-Host "2. swah" 
                $switch = Read-Host "Zahl der Aktion eingeben"
    
                switch ($switch) {
                    "1" {
                        foreach ($kreatur in $spielbrett.spielfelder[$party.feld].kreaturen) {
                        Write-Host "ID: "$kreatur.id
                        Write-Host "Name: " $kreatur.kreaturName
                        }
                        $zielID = Read-Host "Ziel-ID eingeben" 
                        foreach($kreatur in $spielbrett.spielfelder[$party.feld].kreaturen) {
                            if ($kreatur.id -eq $zielID) {
                                $ziel = $kreatur
                            }
                        }
                        
                        $spieler.angreifen($ziel, 5)
                        $spieler.setCooldown($true)
                        checkHealth($ziel)
                        $party.checkCooldown()
                    }
                }
            } ################################ foreach Ende
                    
        }
        ########## Kreaturenaktionen
        ########## Kreaturencooldown?
        while ($spielbrett.spielfelder[$party.feld].cooldown -eq $false) {
            ########## alle Kreaturen greifen random einen Helden an
            foreach($kreatur in $spielbrett.spielfelder[$party.feld].kreaturen) {
                $zielAI = Get-Random -InputObject $party.helden
                $kreatur.angreifen($zielAI, $kreatur.angriffsschaden)
                $kreatur.setCooldown($true)
            }
            ########## Sind alle Kreaturen auf Cooldown, so wird die Party wieder aktiv gesetzt
            $spielbrett.spielfelder[$party.feld].checkCooldown($party)
        }
        ############
    }
    $party.feld++
}