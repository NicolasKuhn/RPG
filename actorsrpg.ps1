<########## 
OBERKLASSE FÜR SPIELER UND KREATUREN MIT GEMEINSAMEN ATTRIBUTEN:
lebenspunkte
angriffschaden
cooldown
angreifen()
setlebenspunkte()
setcooldown()

'############>

class Akteur {

    [int]$id = 0
    [int]$lebenspunkte
    [int]$angriffsschaden
    [bool]$cooldown = $false

  angreifen($ziel, $schaden) {
    if ((($ziel.GetType()).Name -eq "Goblin") -and ($ziel.vergraben -eq $true)) {
      Write-Warning "Obacht! Goblin ist vergraben!"
      $this.setCooldown()
      break
      }
    $ziel.setLebenspunkte($schaden)
    
    
  }

  setLebenspunkte($mod) {
  $this.Lebenspunkte -= $mod
  }

  setCooldown($bool) {
    $this.cooldown = $bool
  }

  wuerfeln([int]$seiten, [int]$modifikator) {
  [int]$ergebnis = Get-Random(1..$seiten)
  $ergebnis += $modifikator
  $ergebnis
  }
}   


class dungeon {
  $rooms = [System.Collections.ArrayList]::new()
}

class room {

  $kreaturen = [System.Collections.ArrayList]::new()
  $spieler = @{}
  $cooldown = $false
  checkCooldown($party) {
        foreach($kreatur in $this.kreaturen) {
            $this.cooldown = $kreatur.cooldown
        }
        if ($this.cooldown) {
            $party.cooldown = $false
        }  
  }

}

class party {
  
  $cooldown = $false
  $helden = [System.Collections.ArrayList]::new()
  [int]$feld = 0
  checkCooldown() {
        foreach($spieler in $this.helden) {
            $this.cooldown = $spieler.cooldown
        }  
  }
}

function checkHealth($ziel) {
    if ($ziel.lebenspunkte -le 0) {
        Write-Warning "Gegner is doud"
        $dungeon.rooms[$party.feld].kreaturen.Remove($ziel)
    }
    else {
        Write-Host $ziel.lebenspunkte
    }
}