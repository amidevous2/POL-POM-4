#!/bin/bash
# Date : (2010-05-11 21-00)
# Last revision : (2010-05-11 21-00)
# Wine version used : 1.1.2
# Distribution used to test : Debian Squeeze (Testing)
# Author : GNU_Raziel
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Rally Championship 2000"
PREFIX="RallyChampionship2000"
WORKING_WINE_VERSION="1.1.2"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_INSERT_MEDIA="Veuillez insérer le disque $TITLE dans votre lecteur\nsi ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_SUCCES="$TITLE has been installed successfully."
fi
 
#starting the script
cd $REPERTOIRE/tmp
rm *.jpg
POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Ubisoft" "http://www.ubi.com" "Tophu" "$PREFIX"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#downloading specific Wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable 
POL_LoadVar_PROGRAMFILES

#asking for CDROM and checking if it's correct one
POL_SetupWindow_message "$LNG_INSERT_MEDIA"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "ral.exe"
wine start /unix "$CDROM/ral.exe"
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"

## PlayOnMac Section
[ "$PLAYONMAC" == "" ] && Set_Managed "On"
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section
Set_DXGrab "On"
 
#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$REPERTOIRE/tmp/"
	rm -rf "$REPERTOIRE/tmp/*"
fi
 
#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "ral.exe" "$TITLE" "" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJD4ACgkQ5TH6yaoTykffLwCdGNdEZ8CqayCjrjg9NsgIfjYY
NKAAn0dgEIBy4bffjZDHPmlIJgA2D0/R
=RN+e
-----END PGP SIGNATURE-----
