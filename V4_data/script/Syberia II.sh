#!/bin/bash
# date 2010-11-28
# Wine version used : 2.22
# Distribution used to test : Ubuntu 18.04 x64
# Author : syberia303

# CHANGELOG
# [syberia303] (2010-11-18)
#    First version.
# [Dadu042] (2019-07-06)
#    Change Wine 1.0.1 to 2.22 because when I tested (POL 4.3.4) the game did not launch (crashed) once installed.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Syberia II"
PREFIX="SyberiaII"
WORKING_WINE_VERSION="2.22"

if [ "$POL_LANG" == "fr" ]; then
LNG_WAIT_WARNING="Syberia II : la nouvelle Aventure de Benoit Sokal"
LNG_WAIT_START="L'installation va commencer..." 
LNG_INSERT_MEDIA="Veuillez insérer le disque $TITLE dans votre lecteur si ce n'est pas déja fait.\nPensez à le monter si rien ne passe lors du choix du point de montage."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera\nterminée sous peine de devoir recommencer l'installation."
LNG_WAIT_HF="Terminé. Kate Walker est de retour pour de nouvelles aventures !."
else
LNG_WAIT_WARNING="Syberia II: the new Adventure game conceived by Benoit Sokal"
LNG_WAIT_START="Installation is going to begin..." 
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive if not already done.\nDon't forget to mount it if nothing happens when you're asked for the mounting point."
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to install again the game."
LNG_WAIT_HF="Finished. Kate Walker is back for some new adventures !."
fi 

#starting the script
rm "$REPERTOIRE/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/syberia2/top.jpg" "http://files.playonlinux.com/resources/setups/syberia2/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages
 
#Presentation
POL_SetupWindow_presentation "$TITLE" "MC2" "http://www.syberia-series.com/fr/" "syberia303" "$PREFIX"

POL_SetupWindow_message "$LNG_WAIT_WARNING"  "$TITLE"
 
POL_SetupWindow_message "$LNG_WAIT_START"  "$TITLE"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#downloading specific Wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"
 
#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES

POL_SetupWindow_message "$LNG_INSERT_MEDIA"  "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe"
wine start /unix "$CDROM/Setup.exe"
 
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"

## PlayOnMac Section
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section
 
POL_SetupWindow_auto_shortcut "$PREFIX" "Syberia2.exe" "$TITLE" "$TITLE.png" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_message "$LNG_WAIT_HF" "$TITLE"
POL_SetupWindow_Close 
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXSHtAAAKCRDlMfrJqhPK
R89HAJ92XIAg9E5eQ8BEnhS9wdOQVm/l/wCfSpr2Umddp8QqJM30jGzAj9RCzS4=
=811h
-----END PGP SIGNATURE-----
