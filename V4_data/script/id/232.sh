#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Wolfenstein 3D"
PREFIX="Wolfenstein3D"
export WINEDEBUG="-all" 

# Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "Wolfenstein 3D" "ID Software" "" "Tinou" "$PREFIX" 
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.4-dos_support_0.5"

cd "$WINEPREFIX/drive_c"
mkdir -p wolf3d
cd wolf3d
POL_Download "http://image.dosgamesarchive.com/games/wolf3d.zip" "b9cbb08d192d1e4bf00c5982ff4f3cbf"
unzip wolf3d.zip

mv WOLF.1 WOLF.EXE
POL_Wine WOLF.EXE
 
POL_Shortcut "WOLF3D.EXE" "Wolfenstein 3D"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOTS5sACgkQ5TH6yaoTykcbAQCfboAQ88RB3jw0xCPavpCvhSaS
jR8AoLBn4MGHx8FYt3lHOLpoD4OiOH7g
=q+TA
-----END PGP SIGNATURE-----
