#!/bin/bash
# Date: (2009-06-14 14-32)
# Last revision: (2009-09-11 08-30)
# Distribution used to test: Ubuntu Jaunty
# Wine version used: 1.1.22 
# Licence: Free
# Author: Berillions
 
#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
Title="Max Payne"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_ERR="Si vous rencontrer deux messages d'erreur concernant un manque de mémoire au début de l'installation, ne vous en fiez pas. le jeu fonctionnera tout de même."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera
terminée sous peine de devoir recommencer l'installation."
else
LNG_ERR="If you have two error messages before the installation, don't worry. You will be able to launch the game."
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation
is finished or you will have to redo the installation.."
fi

cd "$REPERTOIRE/tmp"
wget http://wilibre.free.fr/images/POL/max_payne.jpg --output-document=left.jpeg
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"
 
#Presentation
POL_SetupWindow_presentation "MaxPayne" "RockstarGame" "http://maxpayne.godgames.com/main.htm/" "Berillions" "MaxPayne"

#Installation de Wine
POL_SetupWindow_install_wine "1.1.43"

#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Install.exe" 

#Préparation de Wine
select_prefixe "$REPERTOIRE/wineprefix/MaxPayne"
#POL_SetupWindow_prefixcreate

#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3} 

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

#Configuration de Wine
Set_OS winxp
 
#Création Icone
cd "$REPERTOIRE/tmp"
wget http://sd-1.archive-host.com/membres/images/51568577817080088/MaxPayne.png
mv "$REPERTOIRE/tmp/MaxPayne.png" "$REPERTOIRE/icones/32/$Title"

POL_SetupWindow_message "$LNG_ERR" "$Title"
wine $CDROM/Install.exe
POL_SetupWindow_message "$LNG_WAIT_END" "$Title"
 
#Création Launcher 
POL_SetupWindow_make_shortcut "MaxPayne" "$PROGRAMFILES/Max Payne" "MaxPayne.exe" "" "Max Payne"

Set_WineVersion_Assign "1.1.43" "Max Payne"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFEACgkQ5TH6yaoTykcz1gCgq5nXmGGOvD7lDFeOa01rcV0e
YJ4AnjSElfkAmhwSMwfosRDt/q93l3w1
=GWBI
-----END PGP SIGNATURE-----
