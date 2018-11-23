."H:\12\AWP\MiniRPG_12FI3\actorsrpg.ps1"

  
function generateName ($kreatur) {
    $trollnamen =  @("Bordis", "Morgor", "Runtal")
    $trolltitel =  @("der Vernichter", "der Blutlose", "Blumenverzehrer")
    $goblinnamen = @("Mupitz", "Lintar", "Räffgi", "Hanz", "Güstin")
    $goblintitel = @("der Wehrlose", "vom Mohnfeld", "Raffzahn", "Flaschenleerer",  "Hinkebein")
   
    switch ( $kreatur )
    {
        "Troll"  { $name = Get-Random $trollnamen; $name += " "; $name += Get-Random $trolltitel }
        "Goblin" { $name = Get-Random $goblinnamen; $name += " "; $name += Get-Random $goblintitel }
        "Ork"    { $name = Get-Random $orknamen; $name += " "; $name += Get-Random $orktitel }
        "Drache" { $name = Get-Random $drachennamen; $name += " "; $name += Get-Random $drachentitel }
    }

    return $name
  }

class Kreatur : Akteur {
  
  [string]$kreaturName 
  
}

class Troll : Kreatur {
  [bool]$wut = $false
  [int]$regeneration
  [int]$lebenspunkte = 70

  troll($kreaturname, $id) {
    $this.kreaturname = $kreaturname
    $this.angriffsschaden = 20
    $this.id = $id
  }

  trollen() {}
}

class Goblin : Kreatur {
  [int]$schnelligkeit
  [int]$lebenspunkte = 18
  [bool]$vergraben = $false

  goblin($kreaturname, $id) {
    $this.angriffsschaden = 6
    $this.kreaturname = $kreaturname
    $this.id = $id
  }

  graben() {
    $this.vergraben = $true
  }
}