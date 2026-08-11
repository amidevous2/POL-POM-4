#!/bin/bash
# Date : (2009-09-01 10-30)
# Last revision : (2013-11-24 12-49)
# Wine version used to test : 1.1.28
# Distribution used to test : N/A
# Author : puk007

# CHANGELOG
# [SuperPlumus] (2013-11-24 12-49)
#   Update POLv3 -> POLv4 + Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="SubRip"
PREFIX="SubRip"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "T.V. Zuggy and ai4spam" "http://zuggy.wz.cz/" "puk007" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_System_TmpCreate "$PREFIX"

Set_OS "winxp"

cd "$POL_System_TmpDir"
POL_Download "http://surfnet.dl.sourceforge.net/project/subrip/subrip/SubRip%201.50%20beta%204/SubRip_150b4.zip" "d75f04a284df48c2adce9bb239141344"

POL_SetupWindow_wait "$(eval_gettext 'Please wait...')" "$TITLE"
mkdir -p "$WINEPREFIX/drive_c/SubRip"
cd "$WINEPREFIX/drive_c/SubRip"
unzip "$POL_System_TmpDir/SubRip_150b4.zip"
sleep 5

POL_System_TmpDelete

POL_Shortcut "SubRip.exe" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'Installation finished.')" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKR7qwACgkQ5TH6yaoTykcdawCgoMa6v5CTLFHPDUXDf9bE9M38
Kt0AnAl2jNZeBbJS/JnRva+nfbFbytZ/
=EfcL
-----END PGP SIGNATURE-----
