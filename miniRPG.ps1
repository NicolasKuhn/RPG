cls
. .\actorsrpg.ps1
. .\classesrpg.ps1
. .\creaturesrpg.ps1

########## initialisiert das dungeon
$dungeon = [dungeon]::new()
$room1 = [room]::new()
$room2 = [room]::new()
$room3 = [room]::new()

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

##########  fügt gegner den roomsn hinzu
[void]$room1.kreaturen.Add($gegner1)
[void]$room2.kreaturen.Add($gegner2)
[void]$room2.kreaturen.Add($gegner3)
[void]$room3.kreaturen.Add($gegner4)

########## fügt rooms dem dungeon hinzu
[void]$dungeon.rooms.Add($room1)
[void]$dungeon.rooms.Add($room2)
[void]$dungeon.rooms.Add($room3)

########## fügt Helden der Party hinzu
$party = [party]::new()
[void]$party.helden.Add($spieler1)
[void]$party.helden.Add($spieler2)

########## Gameplay Loop

########## Sind wir nicht über das room hinausgeschossen?
while ($party.room -lt $dungeon.rooms.Count) {

    ########## Sind noch Kreaturen auf dem aktuellen room?
    while (($dungeon.rooms[$party.room]).kreaturen.Count -ne 0) {
        ########## Hat die Party noch Aktionen über?
        while ($party.cooldown -eq $false) {
            ########## Spieleraktion
            foreach ($spieler in $party.helden) {
                Write-Host "1. Angreifen"
                Write-Host "2. swah"
                $switch = Read-Host "Zahl der Aktion eingeben"

                switch ($switch) {
                    "1" {
                        foreach ($kreatur in $dungeon.rooms[$party.room].kreaturen) {
                        Write-Host "ID: "$kreatur.id
                        Write-Host "Name: " $kreatur.kreaturName
                        }
                        $zielID = Read-Host "Ziel-ID eingeben"
                        foreach($kreatur in $dungeon.rooms[$party.room].kreaturen) {
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
        while ($dungeon.rooms[$party.room].cooldown -eq $false) {
            ########## alle Kreaturen greifen random einen Helden an
            foreach($kreatur in $dungeon.rooms[$party.room].kreaturen) {
                $zielAI = Get-Random -InputObject $party.helden
                $kreatur.angreifen($zielAI, $kreatur.angriffsschaden)
                $kreatur.setCooldown($true)
            }
            ########## Sind alle Kreaturen auf Cooldown, so wird die Party wieder aktiv gesetzt
            $dungeon.rooms[$party.room].checkCooldown($party)
        }
        ############
    }
    $party.room++
}
