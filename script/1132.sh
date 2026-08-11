#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Simultit"
PREFIX="Simultit"
 
#Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Unknown" "" "Tinou" "$PREFIX" 
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.4-dos_support_0.5"

cd "$WINEPREFIX/drive_c"
POL_Download "http://themaximax.free.fr/Logiciels/Simultit.zip" "ca9b1752e8202baba9380f9d0b7a5f75"
unzip Simultit.zip
 
POL_Shortcut "SIMULTIT.EXE" "Simultit"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/UqFkACgkQ5TH6yaoTykdXqwCfRr09mNZtLh99ndvWuhTA22ki
6tIAn3/OEqPKyyk8cXHwnLZ/gpvtLFqZ
=p4Bp
-----END PGP SIGNATURE-----
