.".\actorsrpg.ps1"

cls
class Spieler : Akteur { #Oberklasse
  [string]$spielerName
  [int]$level = 0
}

class Magier : Spieler { #Unterklasse -> erbt $spielername und angreifen()
  [int]$manapunkte = 10

  magier($spielername, $id) {
  $this.spielerName = $spielername
  $this.lebenspunkte = 40
  $this.angriffsschaden = 5
  $this.id = $id
  }

  Implosion($ziel) {
    $ziel.setLebenspunkte(($ziel.Lebenspunkte)/3)
    $this.manapunkte -= 5
    $this.setCooldown()
  }

}

class Kleriker : Spieler { #Unterklasse -> erbt $spielername und angreifen()
  [int]$manapunkte = 10
  [int]$heilwert = 10

  magier($spielername, $id) {
  $this.spielerName = $spielername
  $this.lebenspunkte = 35
  $this.angriffsschaden = 65
  $this.id = $id
  }

  Heilen($ziel, $heilwert) {
    $ziel.setLebenspunkte(-$heilwert)
    $this.manapunkte -= 2
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

  Wut() {
    if ($this.lebenspunkte -lt 34) {
      $this.wut = $true
    }
    else {
      $this.wut = $false
    }
  }
}

class Ritter : Spieler {
  [bool]$Schild = $false

  paladin($spielername, $id) {
    $this.spielername = $spielerName
    $this.lebenspunkte = 55
    $this.angriffsschaden = 9
    $this.id = $id
  }

  Schild() {
    $this.Schild = $true
  }
}

class Schuetze : Spieler {
  [int]$fokus = 0

  schuetze($spielername, $id) {
  $this.spielerName = $spielername
  $this.lebenspunkte = 50
  $this.angriffsschaden = 7
  $this.id = $id
  }

  Fokus() {
    $this.fokus++
  }


}

class Schurke : Spieler {
  [int]$energie
  [bool]$getarnt = $false

  schurke($spielername, $id) {
    $this.spielerName = $spielername
    $this.lebenspunkte = 43
    $this.angriffsschaden = 8
    $this.id = $id
  }

  Tarnen() {
    $this.getarnt = $true
    $this.setCooldown()
  }
}
