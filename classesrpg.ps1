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
  $this.lebenspunkte = 35
  $this.angriffsschaden = 5
  $this.id = $id
  }

  Heilen($ziel, $heilwert) {
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

  Wut() {
    if ($this.lebenspunkte -lt 34) {
      $this.wut = $true
    }
    else {
      $this.wut = $false
    }
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
