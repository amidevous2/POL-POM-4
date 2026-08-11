#!/bin/bash
# Date : (2009-05-27 9-00)
# Last revision : (2009-05-27 9-00)
# Wine version used : N/A 
# Distribution used to test : Fedora 10
# Author : NSLW
# Licence : Retail

#Translated from V2 to V3
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 
  
#Declaration des variables
CODENAME="BreathOfFire4"
REALNAME="Breath of Fire IV"
EDITEUR="Capcom"
WEBSITE="http://www.capcom.com/"
SCRIPTEUR="Tr4sK and NSLW" 
 
#Presentation
#presentation "$REALNAME" "$EDITEUR" "$WEBSITE" "$SCRIPTEUR" "$CODENAME" 1 3

POL_SetupWindow_Init
POL_SetupWindow_presentation "$REALNAME" "$EDITEUR" "$WEBSITE" "$SCRIPTEUR" "$CODENAME" 
 
#Préparation du prefix
#mkdir -p $REPERTOIRE/wineprefix/$CODENAME/
#select_prefixe "$REPERTOIRE/wineprefix/$CODENAME"
#creer_prefixe 2 3

select_prefix "$REPERTOIRE/wineprefix/$CODENAME"
POL_SetupWindow_prefixcreate

#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

#Verification du CDROM
#Ask_For_cdrom 3 3
#Check_cdrom "MOV/ZBOF4.DAT"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "MOV/ZBOF4.DAT"
cd "$WINEPREFIX/dosdevices"
ln -s $CDROM d:
 
cd "$WINEPREFIX/drive_c/windows/temp/" 
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"d:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
POL_SetupWindow_message "Wait 5 seconds then click next" "$TITLE"
 
#cd $CDROM
#wine Setup.exe

POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
cd $CDROM
wine "Setup.exe"
POL_SetupWindow_detect_exit
 
#Fin du code du jeu
#Création du lanceur
 
#creer_lanceur "$CODENAME" "Program Files/Capcom/Bof4" "BOF4.exe" "" "$REALNAME"

POL_SetupWindow_make_shortcut "$CODENAME" "$PROGRAMFILES/Capcom/Bof4" "BOF4.exe" "" "$REALNAME" "" ""

POL_SetupWindow_message "$REALNAME has been installed successfully" "$REALNAME"
POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEAACgkQ5TH6yaoTykeojQCfXJ0DFB5BwR7Pom0G7x2/VrJZ
d9gAnRS6pUBQi30qMd9Q5U8E4sePl7oD
=POwU
-----END PGP SIGNATURE-----
