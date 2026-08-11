#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Prehistorik"
PREFIX="Prehistorik"
 
#Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "Prehistorik" "Titus" "" "Tinou" "$PREFIX" 
 
POL_Wine_SelectPrefix "$PREFIX"
POL_SetupWindow_prefixcreate "1.4-dos_support_0.5"

cd "$WINEPREFIX/drive_c"
POL_Download "$SITE/divers/oldware/historik.zip" "8702b49382b02a255f85a901bd8c38f0"
unzip historik.zip
 
POL_Shortcut "HISTORIK.EXE" "Prehistorik"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/PwUkACgkQ5TH6yaoTykdVqACgjYFWqqltmVZEN2ScX+jGSXyM
aLEAn3cWCpYYbIW8UXdXWlfbfyLbttao
=jtUD
-----END PGP SIGNATURE-----
