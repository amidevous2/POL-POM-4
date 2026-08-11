#!/bin/bash
# Date : (2009-05-25 15-00)
# Last revision : (2009-05-25 15-00)
# Wine version used : N/A 
# Distribution used to test : N/A
# Author : NSLW
# Licence : Retail

#Translated from V2 to V3
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

TITLE="Dawn Of War : Dark Crusade"
PREFIX="W40K_DawnOfWar"

#Presentation
#presentation "Dawn Of War : Dark Crusade" "THQ" "http://www.thq-games.com/fr" "Tinou" "W40K_DawnOfWar"

POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "THQ" "http://www.thq-games.com/fr" "Tinou and NSLW" "$PREFIX" 

#Cette partie contiendra le code du jeu.
 
#Ask_For_cdrom
#Check_cdrom "setup.exe"

#mkdir -p $REPERTOIRE/wineprefix/W40K_DawnOfWar
#select_prefixe "$REPERTOIRE/wineprefix/W40K_DawnOfWar"
#creer_prefixe

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

cd "$WINEPREFIX/dosdevices"
ln -s $CDROM d:
 
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > $REPERTOIRE/tmp/cdrom.reg
echo "\"d:\"=\"cdrom\"" >> $REPERTOIRE/tmp/cdrom.reg
regedit $REPERTOIRE/tmp/cdrom.reg
POL_SetupWindow_message "Wait 5 seconds then click next" "$TITLE"

Set_OS winxp
 
wine $CDROM/setup.exe
 
#Fin du code du jeu
#Création du lanceur
 
#creer_lanceur "W40K_DawnOfWar" "$PROGRAMFILES/THQ/Dawn of War - Dark Crusade/" "DarkCrusade.exe" "DawnOfWar_DarkCrusade.xpm" "Dawn of War : Dark Crusade"
POL_SetupWindow_make_shortcut "$PREFIX" "Program Files/THQ/Dawn of War - Dark Crusade" "DarkCrusade.exe" "DawnOfWar_DarkCrusade.xpm" "$TITLE" "" ""

POL_SetupWindow_message "$TITLE has been installed successfully" "$TITLE"
POL_SetupWindow_Close 
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJD0ACgkQ5TH6yaoTykfrbwCgkujmVxChw/j4XL+vSSOea/6G
EX0AnREn2FonrQqZHbJeGV6oNMSp+Qhy
=7Nbz
-----END PGP SIGNATURE-----
