#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Prince Of Persia - Original"
PREFIX="PrinceOfPersia1"
 
#Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "Prince Of Persia 1" "Broderbund Softwared" "" "Tinou" "$PREFIX" 
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.4-dos_support_0.5"

cd "$WINEPREFIX/drive_c"
POL_Download "$SITE/divers/oldware/prince.zip" "c0ccc7cb2530cf6719516bf58bf63281"
unzip prince.zip
 
POL_Shortcut "PRINCE.EXE" "Prince Of Persia - Original"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/PwTUACgkQ5TH6yaoTykefcwCfTUQsNUpqYHdD++HTlbtWh/x0
JTAAnjg79ldLsi16UsDUzM5aEGGY98ot
=L5jz
-----END PGP SIGNATURE-----
