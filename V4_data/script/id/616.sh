#!/bin/bash
# Date: 2011-17-07
# Distribution used to test: Debian Squeeze
# Wine version used: 1.3.24
# Author: Berillions
# Graphic Card : GeForce GT330M
# Drivers : 275.09.07

[ "$PLAYONLINUX" = "" ] && exit 0 
source "$PLAYONLINUX/lib/sources"
 
Title="Heroes of Might & Magic 5 : Tribes Of The East"
Prefix="HOMM5_T"
WORKING_WINE_VERSION="1.3.24"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera
terminée sous peine de devoir recommencer l'installation."
LNG_INSTINPROGRESS="Installation en cours..."
LNG_INSERTMEDIA="Inserer le CD/DVD de $TYTUL dans votre lecteur."
else
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation
is finished or you will have to redo the installation."
LNG_INSTINPROGRESS="Installation in progress..."
LNG_INSERTMEDIA="Please insert $TYTUL media into your disk drive."
fi
 
wget http://upload.wikimedia.org/wikipedia/en/d/de/Boxshot_uk_large.jpg --output-document="$REPERTOIRE/tmp/HOMM5_T"
convert "$REPERTOIRE/tmp/HOMM5_T" -scale 150x356\! "$REPERTOIRE/tmp/left.jpg"
 
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpg"
 
#Presentation
POL_SetupWindow_presentation "$Title" "Nival Interactive" "http://www.mightandmagic.com/HeroesV/" "Berillions" "$Prefix"

POL_SetupWindow_message "$LNG_INSERTMEDIA"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe" 
 
#Installation de Wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"
 
#Préparation de Wine
select_prefix "$REPERTOIRE/wineprefix/$Prefix"
POL_SetupWindow_prefixcreate

POL_SetupWindow_wait_next_signal "$LNG_INSTINPROGRESS" "$TYTUL"
wine "$CDROM/Setup.exe"
POL_SetupWindow_detect_exit

POL_SetupWindow_message "$LNG_WAIT_END" "$Title"
 
#Création Launcher 
POL_SetupWindow_auto_shortcut "$Prefix" "H5_Game.exe" "$Title" "" ""
POL_SetupWindow_auto_shortcut "$Prefix" "UpgradeLauncher.exe" "$Title - Update" "" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$Title"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk4jM28ACgkQ5TH6yaoTykfGfwCfd6fvFkVavx4OpfJrD0fB2vK5
YSsAoIk7p63+SpaRQZFmnLGZkvz7STQI
=DrnX
-----END PGP SIGNATURE-----
