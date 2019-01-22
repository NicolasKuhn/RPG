.".\actorsrpg.ps1"


function generateName ($kreatur) {
    $trollnamen =  @("Bordis", "Morgor", "Runtal")
    $trolltitel =  @("der Vernichter", "der Blutlose", "Blumenverzehrer")
    $goblinnamen = @("Mupitz", "Lintar", "Räffgi", "Hanz", "Güstin", "Knorf", "Moklud", "Gublar", "Veehlo")
    $goblintitel = @("der Wehrlose", "vom Mohnfeld", "Raffzahn", "Flaschenleerer",  "Hinkebein", "Dünnarm", "Dungesser", "Khan", "Mienenschneider")
    $orknamen = @("Malfarok", "Bundrak", "Garrosh", "Grommash", "Gundrek", "Thrall", "Loknarash", "Sguk", "Orgug", "Zog", "Hrolkug", "Wubdagog")
    $orktitel = @("der Furchtlose", "Durchfallatem", "der Schreckliche", "der Mannigfaltige", ", Odem des Nordens", "der Kurze", "Furchtbringer")
    $drachennamen = @("Gerillion", "Tiamat", "Alexstraza", "Dardioch")
    $drachentitel = @(", Herr des Lichts", "Weltenender", ", Fürst der grünen Drachenschar", ", Seele des chromatischen Drachenschwarms")

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

class Ork : Kreatur {
  [int]$lebenspunkte = 35
  [bool]$verstaerkunggerufen = $false

  ork($kreaturname, $id) {
    $this.angriffsschaden = 13
    $this.kreaturname = $kreaturname
    $this.id = $id
  }

  verstaerkungRufen($spielbrett, $party) {
    $variable = Get-Random
    $kreaturname = generateName("Goblin")
    $kreatur = [goblin]::new($kreaturname, 301)
    Set-Variable -Name $variable -Value $kreatur
    $temp = Get-Variable -Name $variable
    $spielbrett.spielfelder[$party.feld].kreaturen.Add($temp.Value)
    $this.verstaerkunggerufen = $true
    $this.cooldown = $true
    $variable = $null
    $kreaturname = $null
    $kreatur = $null
  }
}

class Drache : Kreatur{
  [int]$lebenspunkte = 100
  [bool]$atemattacke = $true

  drache($kreaturname, $id) {
    $this.angriffsschaden = 30
    $this.kreaturname = $kreaturname
    $this.id = $id
  }

  atemattacke($party) {
    foreach($dude in $party) {
        $dude.setLebenspunkte(10)
    }
  }

  angreifen($self, $ziel, $schaden, $spielbrett, $party) {
    $ziel.setLebenspunkte($schaden)
    $self.setLebenspunkte($schaden * -0.5)
  }
}
