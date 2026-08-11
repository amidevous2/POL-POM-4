#!/bin/bash
# Date : (2009-05-29 11-00)
# Last revision : (2009-06-21 11-00)
# Wine version used : N/A 
# Distribution used to test : N/A
# Author : NSLW
# Licence : Retail

#Translated from V2 to V3
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}

#Definition des variables
LONG_NAME="Tomb Raider Legend"
PREFIX="TombRaiderLegend"
EDITOR="Eidos Interactive"
WEBSITE="http://www.tombraider.com/legend/"
AUTHOR="malownu - Modifications/Standardisation par GNU_Raziel and NSLW"
 
wget http://upload.wikimedia.org/wikipedia/en/thumb/a/a4/TombRaiderLegend.jpg/256px-TombRaiderLegend.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$LONG_NAME" "$EDITOR" "$WEBSITE" "$AUTHOR" "$PREFIX" 

 
if [ "$POL_LANG" == "fr_FR.UTF-8" ]
then
LNG_WAIT_END="Appuyez sur "Suivant" UNIQUEMENT quand l'installation du jeu sera terminée sous peine de devoir recommencer l'installation." 
else
LNG_WAIT_END="Click on "Next" ONLY when the game installation is finished or you will have to redo the installation."
fi 
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
cd "$WINEPREFIX/dosdevices"
ln -s $CDROM d:
 
cd "$WINEPREFIX/drive_c/windows/temp/" 
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"d:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
POL_SetupWindow_message "Wait 5 seconds then click next" "$LONG_NAME"
 
#Configuration de wine
Set_OS "winxp"
Set_SoundDriver alsa
 
cd "$CDROM"
wine "setup.exe"
POL_SetupWindow_message "$LNG_WAIT_END" "$LONG_NAME"

#simuler_reboot
POL_SetupWindow_reboot
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Tomb Raider - Legend" "trl.exe" "" "$LONG_NAME" "" ""

POL_SetupWindow_message "$LONG_NAME has been installed successfully" "$LONG_NAME"
POL_SetupWindow_message "Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff." "Note about copy protection" "/usr/share/playonlinux/themes/tango/warning.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEEACgkQ5TH6yaoTykcJWgCglwN+0sJyT/mbAUI0shPONDN5
2GIAoJQuzaRzVOkIzI6+SsARd+DIMiUs
=iUf4
-----END PGP SIGNATURE-----
