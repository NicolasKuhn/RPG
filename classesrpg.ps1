$a = $PSCommandPath
."H:\12\AWP\MiniRPG_12FI3\actorsrpg.ps1"
."$root\actorsrpg.ps1"

cls

write-host $a
sleep 20
class Spieler : Akteur { #Oberklasse
  [string]$spielerName
  [int]$erfahrungspunkte = 0
}

class Magier : Spieler { #Unterklasse -> erbt $spielername und angreifen()
  [int]$manapunkte = 10

  magier($spielername, $id) {
  $this.spielerName = $spielername
  $this.lebenspunkte = 35
  $this.angriffsschaden = 5
  $this.id = $id
  }
  
  heilen($ziel, $heilwert) {
    $ziel.setLebenspunkte(-$heilwert)
    $this.setCooldown()
  } 
  
}

class Krieger : Spieler {
  [bool]$wut = $false

  krieger($spielername, $id) {
  $this.spielerName = $spielername
  $this.lebenspunkte = 67
  $this.angriffsschaden = 10
  $this.id = $id
  }

  toggleWut() {
    if ($this.lebenspunkte -lt 34) {
      $this.wut = $true
    }
    else {
      $this.wut = $false
    }
  }
}

class schuetze : Spieler {
  [int]$fokus = 0

  schuetze($spielername, $id) {
  $this.spielerName = $spielername
  $this.lebenspunkte = 50
  $this.angriffsschaden = 7
  $this.id = $id
  }

  setFokus() {
    $this.fokus++      
  }
  

}

class Schurke : Spieler {
  [int]$energie
  [bool]$getarnt = $false

  schurke($spielername, $id) {
    $this.spielerName = $spielername
    $this.angriffsschaden = 8
    $this.id = $id
  }

  tarnen() {
    $this.getarnt = $true
    $this.setCooldown()
  }
}


