."H:\12\AWP\MiniRPG_12FI3\actorsrpg.ps1"
."H:\12\AWP\MiniRPG_12FI3\classesrpg.ps1"
."H:\12\AWP\MiniRPG_12FI3\creaturesrpg.ps1"
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath

########## initialisiert das Spielbrett 
$spielbrett = [spielbrett]::new()
$spielfeld1 = [spielfeld]::new()
$spielfeld2 = [spielfeld]::new()
$spielfeld3 = [spielfeld]::new()

########## initialisiert die Spieler

<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

function createHeroForm() {

$CreateHeroForm                  = New-Object system.Windows.Forms.Form
$CreateHeroForm.ClientSize       = '365,425'
$CreateHeroForm.text             = "Erstelle deinen Helden"
$CreateHeroForm.TopMost          = $false

$CreateHeroLabelName             = New-Object system.Windows.Forms.Label
$CreateHeroLabelName.text        = "Spielername:"
$CreateHeroLabelName.AutoSize    = $true
$CreateHeroLabelName.width       = 25
$CreateHeroLabelName.height      = 10
$CreateHeroLabelName.location    = New-Object System.Drawing.Point(25,24)
$CreateHeroLabelName.Font        = 'Microsoft Sans Serif,10'

$CreateHeroTextboxName           = New-Object system.Windows.Forms.TextBox
$CreateHeroTextboxName.multiline  = $false
$CreateHeroTextboxName.width     = 150
$CreateHeroTextboxName.height    = 20
$CreateHeroTextboxName.location  = New-Object System.Drawing.Point(120,20)
$CreateHeroTextboxName.Font      = 'Microsoft Sans Serif,10'

$CreateHeroCombobox              = New-Object system.Windows.Forms.ComboBox
$CreateHeroCombobox.text         = "Wählen..."
$CreateHeroCombobox.width        = 150
$CreateHeroCombobox.height       = 20
@('Magier','Krieger','Schurke','Schuetze') | ForEach-Object {[void] $CreateHeroCombobox.Items.Add($_)}
$CreateHeroCombobox.location     = New-Object System.Drawing.Point(120,50)
$CreateHeroCombobox.Font         = 'Microsoft Sans Serif,10'

$CreateHeroLabelClass            = New-Object system.Windows.Forms.Label
$CreateHeroLabelClass.text       = "Klasse:"
$CreateHeroLabelClass.AutoSize   = $true
$CreateHeroLabelClass.width      = 25
$CreateHeroLabelClass.height     = 10
$CreateHeroLabelClass.location   = New-Object System.Drawing.Point(25,56)
$CreateHeroLabelClass.Font       = 'Microsoft Sans Serif,10'

$CreateHeroPicture1              = New-Object system.Windows.Forms.PictureBox
$CreateHeroPicture1.width        = 100
$CreateHeroPicture1.height       = 100
$CreateHeroPicture1.location     = New-Object System.Drawing.Point(50,100)
$CreateHeroPicture1.imageLocation  = "undefined"
$CreateHeroPicture1.SizeMode     = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$CreateHeroRadioPicture1         = New-Object system.Windows.Forms.RadioButton
$CreateHeroRadioPicture1.AutoSize  = $true
$CreateHeroRadioPicture1.width   = 20
$CreateHeroRadioPicture1.height  = 20
$CreateHeroRadioPicture1.location  = New-Object System.Drawing.Point(25,145)
$CreateHeroRadioPicture1.Font    = 'Microsoft Sans Serif,10'

$CreateHeroPicture2              = New-Object system.Windows.Forms.PictureBox
$CreateHeroPicture2.width        = 100
$CreateHeroPicture2.height       = 100
$CreateHeroPicture2.location     = New-Object System.Drawing.Point(50,225)
$CreateHeroPicture2.imageLocation  = "undefined"
$CreateHeroPicture2.SizeMode     = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$CreateHeroRadioPicture2         = New-Object system.Windows.Forms.RadioButton
$CreateHeroRadioPicture2.AutoSize  = $true
$CreateHeroRadioPicture2.width   = 20
$CreateHeroRadioPicture2.height  = 20
$CreateHeroRadioPicture2.location  = New-Object System.Drawing.Point(25,270)
$CreateHeroRadioPicture2.Font    = 'Microsoft Sans Serif,10'


$CreateHeroPicture3              = New-Object system.Windows.Forms.PictureBox
$CreateHeroPicture3.width        = 100
$CreateHeroPicture3.height       = 100
$CreateHeroPicture3.location     = New-Object System.Drawing.Point(230,100)
$CreateHeroPicture3.imageLocation  = "undefined"
$CreateHeroPicture3.SizeMode     = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$CreateHeroRadioPicture3         = New-Object system.Windows.Forms.RadioButton
$CreateHeroRadioPicture3.AutoSize  = $true
$CreateHeroRadioPicture3.width   = 20
$CreateHeroRadioPicture3.height  = 20
$CreateHeroRadioPicture3.location  = New-Object System.Drawing.Point(205,145)
$CreateHeroRadioPicture3.Font    = 'Microsoft Sans Serif,10'

$CreateHeroPicture4              = New-Object system.Windows.Forms.PictureBox
$CreateHeroPicture4.width        = 100
$CreateHeroPicture4.height       = 100
$CreateHeroPicture4.location     = New-Object System.Drawing.Point(230,225)
$CreateHeroPicture4.imageLocation  = "undefined"
$CreateHeroPicture4.SizeMode     = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$CreateHeroRadioPicture4         = New-Object system.Windows.Forms.RadioButton
$CreateHeroRadioPicture4.AutoSize  = $true
$CreateHeroRadioPicture4.width   = 20
$CreateHeroRadioPicture4.height  = 20
$CreateHeroRadioPicture4.location  = New-Object System.Drawing.Point(205,270)
$CreateHeroRadioPicture4.Font    = 'Microsoft Sans Serif,10'
$CreateHeroRadioPicture4.Add_Click({ 
  if ($CreateHeroRadioPicture4.Checked -and ($CreateHeroTextboxName -not $null) -and ($CreateHeroCombobox.SelectedItem -isnot $null) ) {
    $CreateHeroSubmitButton.Enabled = $true
  }
})

$CreateHeroSubmitButton          = New-Object system.Windows.Forms.Button
$CreateHeroSubmitButton.text     = "Annehmen"
$CreateHeroSubmitButton.width    = 80
$CreateHeroSubmitButton.height   = 30
$CreateHeroSubmitButton.enabled  = $false
$CreateHeroSubmitButton.location  = New-Object System.Drawing.Point(60,365)
$CreateHeroSubmitButton.Font     = 'Microsoft Sans Serif,10'
$CreateHeroSubmitButton.Add_Click({# $spieler1 =  
 })

$CreateHeroCancelButton          = New-Object system.Windows.Forms.Button
$CreateHeroCancelButton.text     = "Beenden"
$CreateHeroCancelButton.width    = 80
$CreateHeroCancelButton.height   = 30
$CreateHeroCancelButton.location  = New-Object System.Drawing.Point(240,365)
$CreateHeroCancelButton.Font     = 'Microsoft Sans Serif,10'
$CreateHeroCancelButton.Add_Click({ 
  $CreateHeroForm.Close() 
})

$CreateHeroForm.controls.AddRange(@($CreateHeroLabelName,$CreateHeroTextboxName,$CreateHeroCombobox,$CreateHeroLabelClass,$CreateHeroPicture1,$CreateHeroRadioPicture1,$CreateHeroRadioPicture2,$CreateHeroPicture2,$CreateHeroRadioPicture3,$CreateHeroPicture3,$CreateHeroRadioPicture4,$CreateHeroPicture4,$CreateHeroSubmitButton,$CreateHeroCancelButton))




$CreateHeroForm.ShowDialog()

}

$FormSpielerzahl                 = New-Object system.Windows.Forms.Form
$FormSpielerzahl.ClientSize      = '300,116'
$FormSpielerzahl.text            = "ERLEBE FANTASTISCHE ABENTEUER!"
$FormSpielerzahl.TopMost         = $false

$SpielerzahlCombobox             = New-Object system.Windows.Forms.ComboBox
$SpielerzahlCombobox.text        = "Wählen..."
$SpielerzahlCombobox.width       = 81
$SpielerzahlCombobox.height      = 20
@('1','2','3','4','5') | ForEach-Object {[void] $SpielerzahlCombobox.Items.Add($_)}
$SpielerzahlCombobox.location    = New-Object System.Drawing.Point(146,22)
$SpielerzahlCombobox.Font        = 'Microsoft Sans Serif,10'
$SpielerzahlCombobox.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList;

$SpielerzahlLabel                = New-Object system.Windows.Forms.Label
$SpielerzahlLabel.text           = "Anzahl der Spieler:"
$SpielerzahlLabel.AutoSize       = $true
$SpielerzahlLabel.width          = 25
$SpielerzahlLabel.height         = 10
$SpielerzahlLabel.location       = New-Object System.Drawing.Point(20,25)
$SpielerzahlLabel.Font           = 'Microsoft Sans Serif,10'

$SpielerzahlSubmit               = New-Object system.Windows.Forms.Button
$SpielerzahlSubmit.text          = "Annehmen"
$SpielerzahlSubmit.width         = 80
$SpielerzahlSubmit.height        = 30
$SpielerzahlSubmit.location      = New-Object System.Drawing.Point(35,66)
$SpielerzahlSubmit.Font          = 'Microsoft Sans Serif,10'
$SpielerzahlSubmit.Add_Click({ 
  $FormSpielerzahl.Close()
  for ($i = [int]$SpielerzahlCombobox.SelectedItem; $i -gt 0; $i--) {
    createHeroForm
    } 
  })

$SpielerzahlCancel               = New-Object system.Windows.Forms.Button
$SpielerzahlCancel.text          = "Beenden"
$SpielerzahlCancel.width         = 80
$SpielerzahlCancel.height        = 30
$SpielerzahlCancel.location      = New-Object System.Drawing.Point(155,66)
$SpielerzahlCancel.Font          = 'Microsoft Sans Serif,10'
$SpielerzahlCancel.Add_Click({ $FormSpielerzahl.Close() })

$FormSpielerzahl.controls.AddRange(@($SpielerzahlCombobox,$SpielerzahlLabel,$SpielerzahlSubmit,$SpielerzahlCancel))

$FormSpielerzahl.ShowDialog()

<#
$spieler1 = [magier]::new("Casty", 101)
$spieler2 = [krieger]::new("Haui", 102)
$spieler3 = [schurke]::new("Stichi", 103)
$spieler4 = [schuetze]::new("Shooty", 104)
$spieler5 = [krieger]::new("Kloppi", 105)
#>

######################### SPIELERERSTELLUNG ENDE ######################################################################################

########## initialisiert die gegner
$kreaturname = generateName("Goblin")
$gegner1 = [goblin]::new($kreaturname, 201)
$kreaturname = generateName("Goblin")
$gegner2 = [goblin]::new($kreaturname, 202)
$kreaturname = generateName("Goblin")
$gegner3 = [goblin]::new($kreaturname, 203)
$kreaturname = generateName("Troll")
$gegner4 = [troll]::new($kreaturname, 204)
$kreaturname = generateName("Ork")
$gegner5 = [ork]::new($kreaturname, 205)
$kreaturname = generateName("Drache")
$gegner10 = [drache]::new($kreaturname, 210)

##########  fügt gegner den spielfeldern hinzu
[void]$spielfeld1.kreaturen.Add($gegner5)
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
[void]$party.helden.Add($spieler3)
[void]$party.helden.Add($spieler4)

########## Gameplay Loop

########## Sind wir nicht über das Spielfeld hinausgeschossen?
<#

while ($party.feld -lt $spielbrett.spielfelder.Count) {


    ########## Sind noch Kreaturen auf dem aktuellen Spielfeld? 
    while (($spielbrett.spielfelder[$party.feld]).kreaturen.Count -ne 0) {
        ########## Hat die Party noch Aktionen über?
        while ($party.cooldown -eq $false) {
            ########## Spieleraktion
            foreach ($spieler in $party.helden) {
                if ($spieler.cooldown -eq $true) {
                  continue

                }
                $zielString = ""
                $switch = ""
                $special = (Get-Member -InputObject $spieler -MemberType Method | where Name -In ("heilen", "Wut", "Fokus", "Tarnen")).Name
                
                while ($switch -eq "") {
                $switch = [Microsoft.VisualBasic.Interaction]::InputBox("Aktion wählen" + "`n" + "1. Angreifen" + "`n" + "2. Spezialfähigkeit: " + $special , $spieler.spielerName , "Aktion eingeben")
                }
                                    
                switch ($switch) {
                    "1" {
                        foreach ($kreatur in $spielbrett.spielfelder[$party.feld].kreaturen) {
                        #Write-Host "ID: "$kreatur.id
                        #Write-Host "Name: " $kreatur.kreaturName
                        $zielString += $kreatur.id
                        $zielString += ": "
                        $zielString += $kreatur.kreaturName
                        $zielString += "`n"
                        }
                                                
                        $zielID = ""
                        while ($zielID -eq "") { 
                        $zielID = [Microsoft.VisualBasic.Interaction]::InputBox($zielString, "Ziel wählen", "Ziel eingeben")
                        }
                        
                        foreach($kreatur in $spielbrett.spielfelder[$party.feld].kreaturen) {
                            if ($kreatur.id -eq $zielID) {
                                $ziel = $kreatur
                            }
                        }
                        
                        $spieler.angreifen($ziel, $spieler.angriffsschaden)
                        [Windows.Forms.MessageBox]::Show($spieler.spielerName + " greift " + $ziel.kreaturName + " an." + "`n" + $spieler.angriffsschaden + " Schaden zugefügt!", "Angriff")
                        $spieler.setCooldown($true)
                        checkHealth($ziel)
                        #$party.checkCooldown($party)
                    }

                    "2" {

                    }

                    default {
                      Write-Warning "Default ololol"
                    }
                }
            } ################################ foreach Ende
        $party.checkCooldown($party)                    
        }
        ########## Kreaturenaktionen
        ########## Kreaturencooldown?
        while ($spielbrett.spielfelder[$party.feld].cooldown -eq $false) {
            ########## alle Kreaturen greifen random einen Helden an
            foreach($kreatur in $spielbrett.spielfelder[$party.feld].kreaturen) {
                if ($kreatur.cooldown -eq $true) {
                  continue
                }
                $zielAI = Get-Random -InputObject $party.helden
                if ($kreatur.GetType().Name -like "Drache") {
                  $kreatur.angreifen($kreatur, $zielAI, $kreatur.angriffsschaden, $spielbrett, $party)
                  [Windows.Forms.MessageBox]::Show($kreatur.kreaturName + " greift " + $zielAI.spielerName + " an." + "`n" + $kreatur.angriffsschaden + " Schaden erlitten!", "Angriff")
                  $kreatur.setCooldown($true)
                }
                else {
                  $kreatur.angreifen($zielAI, $kreatur.angriffsschaden)
                  [Windows.Forms.MessageBox]::Show($kreatur.kreaturName + " greift " + $zielAI.spielerName + " an." + "`n" + $kreatur.angriffsschaden + " Schaden erlitten!", "Angriff")
                  $kreatur.setCooldown($true)
                }
            }
            ########## Sind alle Kreaturen auf Cooldown, so wird die Party wieder aktiv gesetzt
            
            $spielbrett.spielfelder[$party.feld].checkCooldown($spielbrett, $party)

            foreach ($kreatur in $spielbrett.spielfelder[$party.feld].kreaturen) {
              $kreatur.setCooldown($false)
            }
            
        }
        ############
        $spielbrett.spielfelder[$party.feld].cooldown = $false
        foreach ($spieler in $party.helden) {
          $spieler.cooldown = $false
        }
    }
    ########LEVELN!!!!!!!!!##############

    $party.feld++
}
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '906,724'
$Form.text                       = "Form"
$Form.TopMost                    = $false

$ListBox1                        = New-Object system.Windows.Forms.ListBox
$ListBox1.text                   = "listBox"
$ListBox1.width                  = 888
$ListBox1.height                 = 106
$ListBox1.location               = New-Object System.Drawing.Point(9,612)

$CombatLog                         = New-Object system.Windows.Forms.Label
$CombatLog.text                     = "CombatLog:"
$CombatLog.AutoSize                 = $true
$CombatLog.width                    = 25
$CombatLog.height                   = 10
$CombatLog.location                 = New-Object System.Drawing.Point(15,597)
$CombatLog.Font                     = 'Microsoft Sans Serif,10'

$LabelPlayer1                    = New-Object system.Windows.Forms.Label
$LabelPlayer1.text               = "NAME: " + $spieler1.spielerName + "`n" + "HP: " + $spieler1.lebenspunkte + "`n" + "DMG: " + $spieler1.angriffsschaden + "`n" + "COOLDOWN: " + $spieler1.cooldown + "`n" + "SPECIAL: "
$LabelPlayer1.AutoSize           = $false
$LabelPlayer1.width              = 120
$LabelPlayer1.height             = 100
$LabelPlayer1.location           = New-Object System.Drawing.Point(15,40)
$LabelPlayer1.Font               = 'Microsoft Sans Serif,10'

$LabelPlayer2                    = New-Object system.Windows.Forms.Label
$LabelPlayer2.text               = "NAME: " + $spieler2.spielerName + "`n" + "HP: " + $spieler2.lebenspunkte + "`n" + "DMG: " + $spieler2.angriffsschaden + "`n" + "COOLDOWN: " + $spieler2.cooldown + "`n" + "SPECIAL: "
$LabelPlayer2.AutoSize           = $false
$LabelPlayer2.width              = 120
$LabelPlayer2.height             = 100
$LabelPlayer2.location           = New-Object System.Drawing.Point(15,150)
$LabelPlayer2.Font               = 'Microsoft Sans Serif,10'

$LabelPlayer3                    = New-Object system.Windows.Forms.Label
$LabelPlayer3.text               = "NAME: " + $spieler3.spielerName + "`n" + "HP: " + $spieler3.lebenspunkte + "`n" + "DMG: " + $spieler3.angriffsschaden + "`n" + "COOLDOWN: " + $spieler3.cooldown + "`n" + "SPECIAL: "
$LabelPlayer3.AutoSize           = $false
$LabelPlayer3.width              = 120
$LabelPlayer3.height             = 100
$LabelPlayer3.location           = New-Object System.Drawing.Point(15,260)
$LabelPlayer3.Font               = 'Microsoft Sans Serif,10'

$LabelPlayer4                    = New-Object system.Windows.Forms.Label
$LabelPlayer4.text               = "NAME: " + $spieler4.spielerName + "`n" + "HP: " + $spieler4.lebenspunkte + "`n" + "DMG: " + $spieler4.angriffsschaden + "`n" + "COOLDOWN: " + $spieler4.cooldown + "`n" + "SPECIAL: "
$LabelPlayer4.AutoSize           = $false
$LabelPlayer4.width              = 120
$LabelPlayer4.height             = 100
$LabelPlayer4.location           = New-Object System.Drawing.Point(14,370)
$LabelPlayer4.Font               = 'Microsoft Sans Serif,10'

$LabelPlayer5                    = New-Object system.Windows.Forms.Label
$LabelPlayer5.text               = "NAME: " + $spieler5.spielerName + "`n" + "HP: " + $spieler5.lebenspunkte + "`n" + "DMG: " + $spieler5.angriffsschaden + "`n" + "COOLDOWN: " + $spieler5.cooldown + "`n" + "SPECIAL: "
$LabelPlayer5.AutoSize           = $false
$LabelPlayer5.width              = 120
$LabelPlayer5.height             = 100
$LabelPlayer5.location           = New-Object System.Drawing.Point(15,480)
$LabelPlayer5.Font               = 'Microsoft Sans Serif,10'


##### Bilder fuer Spieler und Monster ############################################################
$imgMagier = get-item 'H:\12\AWP\MiniRPG_12FI3\Icons\Spieler\Wizard 100x.png'
$imgKrieger = get-item 'H:\12\AWP\MiniRPG_12FI3\Icons\Spieler\Krieger 100x.png'
$imgSchuetze = get-item 'H:\12\AWP\MiniRPG_12FI3\Icons\Spieler\Archer 100x.png'
$imgSchurke = get-item 'H:\12\AWP\MiniRPG_12FI3\Icons\Spieler\Rogue.jpg'
$imgGoblin = Get-Item 'H:\12\AWP\MiniRPG_12FI3\Icons\Monster\Dragon 100x.png'
$imgDracheGruen = Get-Item 'H:\12\AWP\MiniRPG_12FI3\Icons\Monster\Dragon 100x.png'
$imgDracheRot = Get-Item 'H:\12\AWP\MiniRPG_12FI3\Icons\Monster\Dragon 100x.png'
$imgDracheSchwarz = Get-Item 'H:\12\AWP\MiniRPG_12FI3\Icons\Monster\Dragon 100x.png'
$imgDracheKnochen = Get-Item 'H:\12\AWP\MiniRPG_12FI3\Icons\Monster\Dragon 100x.png'
$imgTroll = Get-Item 'H:\12\AWP\MiniRPG_12FI3\Icons\Monster\Dragon 100x.png'
$imgOrkCommon = Get-Item 'H:\12\AWP\MiniRPG_12FI3\Icons\Monster\Dragon 100x.png'
$imgOrkElite = Get-Item 'H:\12\AWP\MiniRPG_12FI3\Icons\Monster\Dragon 100x.png'


$PictureBoxPlayer1               = New-Object system.Windows.Forms.PictureBox
$PictureBoxPlayer1.width         = 100
$PictureBoxPlayer1.height        = 100
$PictureBoxPlayer1.location      = New-Object System.Drawing.Point(145,40)

#################VIELLEICHT AUSLAGERN IN EINE FUNKTION ##############################################
switch ($spieler1.GetType().Name) {
  "Magier" { $PictureBoxPlayer1.imageLocation  = $imgMagier}
  "Krieger" { $PictureBoxPlayer1.imageLocation  = $imgKrieger}
  "Schuetze" { $PictureBoxPlayer1.imageLocation  = $imgSchuetze}
  "Schurke" { $PictureBoxPlayer1.imageLocation  = $imgSchurke}
  }
$PictureBoxPlayer1.SizeMode      = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$PictureBoxPlayer2               = New-Object system.Windows.Forms.PictureBox
$PictureBoxPlayer2.width         = 100
$PictureBoxPlayer2.height        = 100
$PictureBoxPlayer2.location      = New-Object System.Drawing.Point(145,150)
$PictureBoxPlayer2.imageLocation  = "undefined"
$PictureBoxPlayer2.SizeMode      = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$PictureBoxPlayer3               = New-Object system.Windows.Forms.PictureBox
$PictureBoxPlayer3.width         = 100
$PictureBoxPlayer3.height        = 100
$PictureBoxPlayer3.location      = New-Object System.Drawing.Point(145,260)
$PictureBoxPlayer3.imageLocation  = "undefined"
$PictureBoxPlayer3.SizeMode      = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$PictureBoxPlayer4               = New-Object system.Windows.Forms.PictureBox
$PictureBoxPlayer4.width         = 100
$PictureBoxPlayer4.height        = 100
$PictureBoxPlayer4.location      = New-Object System.Drawing.Point(145,370)
$PictureBoxPlayer4.imageLocation  = "undefined"
$PictureBoxPlayer4.SizeMode      = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$PictureBoxPlayer5               = New-Object system.Windows.Forms.PictureBox
$PictureBoxPlayer5.width         = 100
$PictureBoxPlayer5.height        = 100
$PictureBoxPlayer5.location      = New-Object System.Drawing.Point(145,480)
$PictureBoxPlayer5.imageLocation  = "undefined"
$PictureBoxPlayer5.SizeMode      = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$WinForm1                        = New-Object system.Windows.Forms.Form
$WinForm1.ClientSize             = '906,724'
$WinForm1.text                   = "Form"
$WinForm1.TopMost                = $false

$LabelMonster1                   = New-Object system.Windows.Forms.Label
$LabelMonster1.text              = "NAME: HP: DMG: COOLDOWN: SPECIAL:"
$LabelMonster1.AutoSize          = $false
$LabelMonster1.width             = 120
$LabelMonster1.height            = 100
$LabelMonster1.location          = New-Object System.Drawing.Point(770,40)
$LabelMonster1.Font              = 'Microsoft Sans Serif,10'

$LabelMonster2                   = New-Object system.Windows.Forms.Label
$LabelMonster2.text              = "NAME: HP: DMG: COOLDOWN: SPECIAL:"
$LabelMonster2.AutoSize          = $false
$LabelMonster2.width             = 120
$LabelMonster2.height            = 100
$LabelMonster2.location          = New-Object System.Drawing.Point(770,150)
$LabelMonster2.Font              = 'Microsoft Sans Serif,10'

$LabelMonster3                   = New-Object system.Windows.Forms.Label
$LabelMonster3.text              = "NAME: HP: DMG: COOLDOWN: SPECIAL:"
$LabelMonster3.AutoSize          = $false
$LabelMonster3.width             = 120
$LabelMonster3.height            = 100
$LabelMonster3.location          = New-Object System.Drawing.Point(770,260)
$LabelMonster3.Font              = 'Microsoft Sans Serif,10'

$LabelMonster4                   = New-Object system.Windows.Forms.Label
$LabelMonster4.text              = "NAME: HP: DMG: COOLDOWN: SPECIAL:"
$LabelMonster4.AutoSize          = $false
$LabelMonster4.width             = 120
$LabelMonster4.height            = 100
$LabelMonster4.location          = New-Object System.Drawing.Point(770,370)
$LabelMonster4.Font              = 'Microsoft Sans Serif,10'

$LabelMonster5                   = New-Object system.Windows.Forms.Label
$LabelMonster5.text              = "NAME: HP: DMG: COOLDOWN: SPECIAL:"
$LabelMonster5.AutoSize          = $false
$LabelMonster5.width             = 120
$LabelMonster5.height            = 100
$LabelMonster5.location          = New-Object System.Drawing.Point(770,480)
$LabelMonster5.Font              = 'Microsoft Sans Serif,10'

$PictureBoxMonster1              = New-Object system.Windows.Forms.PictureBox
$PictureBoxMonster1.width        = 100
$PictureBoxMonster1.height       = 100
$PictureBoxMonster1.location     = New-Object System.Drawing.Point(655,40)
$PictureBoxMonster1.imageLocation  = "undefined"
$PictureBoxMonster1.SizeMode     = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$PictureBoxMonster2              = New-Object system.Windows.Forms.PictureBox
$PictureBoxMonster2.width        = 100
$PictureBoxMonster2.height       = 100
$PictureBoxMonster2.location     = New-Object System.Drawing.Point(655,150)
$PictureBoxMonster2.imageLocation  = "undefined"
$PictureBoxMonster2.SizeMode     = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$PictureBoxMonster3              = New-Object system.Windows.Forms.PictureBox
$PictureBoxMonster3.width        = 100
$PictureBoxMonster3.height       = 100
$PictureBoxMonster3.location     = New-Object System.Drawing.Point(655,260)
$PictureBoxMonster3.imageLocation  = "undefined"
$PictureBoxMonster3.SizeMode     = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$PictureBoxMonster4              = New-Object system.Windows.Forms.PictureBox
$PictureBoxMonster4.width        = 100
$PictureBoxMonster4.height       = 100
$PictureBoxMonster4.location     = New-Object System.Drawing.Point(654,370)
$PictureBoxMonster4.imageLocation  = "undefined"
$PictureBoxMonster4.SizeMode     = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$PictureBoxMonster5              = New-Object system.Windows.Forms.PictureBox
$PictureBoxMonster5.width        = 100
$PictureBoxMonster5.height       = 100
$PictureBoxMonster5.location     = New-Object System.Drawing.Point(655,480)
$PictureBoxMonster5.imageLocation  = "undefined"
$PictureBoxMonster5.SizeMode     = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$ButtonAttackPlayer1             = New-Object system.Windows.Forms.Button
$ButtonAttackPlayer1.text        = "Attack"
$ButtonAttackPlayer1.width       = 60
$ButtonAttackPlayer1.height      = 30
$ButtonAttackPlayer1.location    = New-Object System.Drawing.Point(260,40)
$ButtonAttackPlayer1.Font        = 'Microsoft Sans Serif,10'

$ButtonAttackPlayer2             = New-Object system.Windows.Forms.Button
$ButtonAttackPlayer2.text        = "Attack"
$ButtonAttackPlayer2.width       = 60
$ButtonAttackPlayer2.height      = 30
$ButtonAttackPlayer2.location    = New-Object System.Drawing.Point(260,150)
$ButtonAttackPlayer2.Font        = 'Microsoft Sans Serif,10'

$ButtonAttackPlayer3             = New-Object system.Windows.Forms.Button
$ButtonAttackPlayer3.text        = "Attack"
$ButtonAttackPlayer3.width       = 60
$ButtonAttackPlayer3.height      = 30
$ButtonAttackPlayer3.location    = New-Object System.Drawing.Point(260,260)
$ButtonAttackPlayer3.Font        = 'Microsoft Sans Serif,10'

$ButtonAttackPlayer4             = New-Object system.Windows.Forms.Button
$ButtonAttackPlayer4.text        = "Attack"
$ButtonAttackPlayer4.width       = 60
$ButtonAttackPlayer4.height      = 30
$ButtonAttackPlayer4.location    = New-Object System.Drawing.Point(260,370)
$ButtonAttackPlayer4.Font        = 'Microsoft Sans Serif,10'

$ButtonAttackPlayer5             = New-Object system.Windows.Forms.Button
$ButtonAttackPlayer5.text        = "Attack"
$ButtonAttackPlayer5.width       = 60
$ButtonAttackPlayer5.height      = 30
$ButtonAttackPlayer5.location    = New-Object System.Drawing.Point(260,480)
$ButtonAttackPlayer5.Font        = 'Microsoft Sans Serif,10'


$ButtonSpecialPlayer1            = New-Object system.Windows.Forms.Button
$ButtonSpecialPlayer1.text       = "Special"
$ButtonSpecialPlayer1.width      = 60
$ButtonSpecialPlayer1.height     = 30
$ButtonSpecialPlayer1.location   = New-Object System.Drawing.Point(260,80)
$ButtonSpecialPlayer1.Font       = 'Microsoft Sans Serif,10'

$ButtonSpecialPlayer2            = New-Object system.Windows.Forms.Button
$ButtonSpecialPlayer2.text       = "Special"
$ButtonSpecialPlayer2.width      = 60
$ButtonSpecialPlayer2.height     = 30
$ButtonSpecialPlayer2.location   = New-Object System.Drawing.Point(260,190)
$ButtonSpecialPlayer2.Font       = 'Microsoft Sans Serif,10'

$ButtonSpecialPlayer3            = New-Object system.Windows.Forms.Button
$ButtonSpecialPlayer3.text       = "Special"
$ButtonSpecialPlayer3.width      = 60
$ButtonSpecialPlayer3.height     = 30
$ButtonSpecialPlayer3.location   = New-Object System.Drawing.Point(260,300)
$ButtonSpecialPlayer3.Font       = 'Microsoft Sans Serif,10'

$ButtonSpecialPlayer4            = New-Object system.Windows.Forms.Button
$ButtonSpecialPlayer4.text       = "Special"
$ButtonSpecialPlayer4.width      = 60
$ButtonSpecialPlayer4.height     = 30
$ButtonSpecialPlayer4.location   = New-Object System.Drawing.Point(260,410)
$ButtonSpecialPlayer4.Font       = 'Microsoft Sans Serif,10'

$ButtonSpecialPlayer5            = New-Object system.Windows.Forms.Button
$ButtonSpecialPlayer5.text       = "Special"
$ButtonSpecialPlayer5.width      = 60
$ButtonSpecialPlayer5.height     = 30
$ButtonSpecialPlayer5.location   = New-Object System.Drawing.Point(260,520)
$ButtonSpecialPlayer5.Font       = 'Microsoft Sans Serif,10'

$ButtonCancel1                   = New-Object system.Windows.Forms.Button
$ButtonCancel1.text              = "Cancel"
$ButtonCancel1.width             = 60
$ButtonCancel1.height            = 30
$ButtonCancel1.visible           = $false
$ButtonCancel1.enabled           = $false
$ButtonCancel1.location          = New-Object System.Drawing.Point(260,80)
$ButtonCancel1.Font              = 'Microsoft Sans Serif,10'

$ButtonCancel2                   = New-Object system.Windows.Forms.Button
$ButtonCancel2.text              = "Cancel"
$ButtonCancel2.width             = 60
$ButtonCancel2.height            = 30
$ButtonCancel2.visible           = $false
$ButtonCancel2.enabled           = $false
$ButtonCancel2.location          = New-Object System.Drawing.Point(260,190)
$ButtonCancel2.Font              = 'Microsoft Sans Serif,10'

$ButtonCancel3                   = New-Object system.Windows.Forms.Button
$ButtonCancel3.text              = "Cancel"
$ButtonCancel3.width             = 60
$ButtonCancel3.height            = 30
$ButtonCancel3.visible           = $false
$ButtonCancel3.enabled           = $false
$ButtonCancel3.location          = New-Object System.Drawing.Point(260,300)
$ButtonCancel3.Font              = 'Microsoft Sans Serif,10'

$ButtonCancel4                   = New-Object system.Windows.Forms.Button
$ButtonCancel4.text              = "Cancel"
$ButtonCancel4.width             = 60
$ButtonCancel4.height            = 30
$ButtonCancel4.visible           = $false
$ButtonCancel4.enabled           = $false
$ButtonCancel4.location          = New-Object System.Drawing.Point(260,410)
$ButtonCancel4.Font              = 'Microsoft Sans Serif,10'

$ButtonCancel5                   = New-Object system.Windows.Forms.Button
$ButtonCancel5.text              = "Cancel"
$ButtonCancel5.width             = 60
$ButtonCancel5.height            = 30
$ButtonCancel5.visible           = $false
$ButtonCancel5.enabled           = $false
$ButtonCancel5.location          = New-Object System.Drawing.Point(260,520)
$ButtonCancel5.Font              = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($ListBox1,$CombatLog,$LabelPlayer5,$LabelPlayer4,$LabelPlayer1,$LabelPlayer3,$LabelPlayer2,$PictureBoxPlayer1,$PictureBoxPlayer2,$PictureBoxPlayer3,$PictureBoxPlayer4,$PictureBoxPlayer5,$LabelMonster1,$LabelMonster2,$LabelMonster3,$LabelMonster4,$LabelMonster5,$PictureBoxMonster4,$PictureBoxMonster5,$PictureBoxMonster3,$PictureBoxMonster2,$PictureBoxMonster1,$ButtonAttackPlayer1,$ButtonAttackPlayer2,$ButtonAttackPlayer3,$ButtonAttackPlayer4,$ButtonAttackPlayer5,$ButtonSpecialPlayer2,$ButtonSpecialPlayer1,$ButtonSpecialPlayer3,$ButtonSpecialPlayer4,$ButtonSpecialPlayer5,$ButtonCancel1,$ButtonCancel2,$ButtonCancel3,$ButtonCancel4,$ButtonCancel5))

$ButtonCancel1.Add_Click({  })


$Form.ShowDialog()