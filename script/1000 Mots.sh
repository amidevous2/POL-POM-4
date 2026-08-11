#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
 
TITRE="1000 Mots"
PREFIXE="1000mots"
 
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITRE" "Educampa" "" "Tinou" "$PREFIXE"
cd $REPERTOIRE/tmp/
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIXE"
POL_SetupWindow_prefixcreate
 
cd "$WINEPREFIX/drive_c/windows/system32"
 
POL_SetupWindow_download "Downloading dependances" "$TITRE" "$SITE/dlls/mfc40.dll"
POL_SetupWindow_download "Downloading dependances" "$TITRE" "$SITE/dlls/threed32.ocx"
cd "$REPERTOIRE/tmp/"

POL_SetupWindow_download "Downloading $TITRE" "$TITRE" "http://perso.wanadoo.fr/jm.campaner/jmc_1000MOTS/installation/Ins_1000Mots.exe"

# URL dead as of 2019-05-25
# POL_SetupWindow_download "Downloading $TITRE" "$TITRE" "http://www.e-70.com/educampa/Ins_1000Mots.exe"

file="$REPERTOIRE/tmp/Ins_1000Mots.exe"
POL_SetupWindow_wait_next_signal "Installing $TITRE" "$TITRE"
wine "$file" /silent
POL_SetupWindow_detect_exit
POL_Shortcut "1000Mots_v3.exe" "$TITRE"
 
POL_Call POL_Install_vbrun6
POL_Call POL_Install_ie6
 
cd "$WINEPREFIX/drive_c/windows/system32"
cabextract "$POL_USER_ROOT/ressources/vbrun60sp6.exe"
 
POL_Call POL_Function_OverrideDLL native,builtin oleaut32
 
POL_SetupWindow_message "$TITRE has been installed successfully" "$TITRE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOlxvQAKCRDlMfrJqhPK
R7NcAKCJ+Gf8CH+3JzmVrsrmafUYZWv/PgCgqCPeT12p0lKDgTVnlTmzIKZy610=
=jRj/
-----END PGP SIGNATURE-----
