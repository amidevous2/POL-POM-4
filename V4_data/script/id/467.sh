#!/bin/bash
# Date : (2009-09-17 18-00)
# Last revision : (2015-12-16)
# Wine version used : 1.8-rc4
# Distribution used to test : (Not tested)
# Author : NSLW
# Modified by MTres19
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Theme Park World"
PREFIX="ThemeParkWorld"
WINEVERSION="1.8-rc4"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Bullfrog Productions" "" "NSLW" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_SetupWindow_cdrom
POL_Wine_InstallCDROM "d"

Set_OS "win2k"

POL_Wine start /unix "$CDROM/Autorun.exe"
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_VMS "32"

POL_Shortcut "TP.EXE" "$TITLE"

POL_Call POL_Function_NoCDWarning

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlZ/DVUACgkQ5TH6yaoTykcHJwCgq0vRhp9GOeOSYbDebPvU2iW1
OKAAnj1stRdrrUv5i5f6cQ1F/td+hqpA
=yme1
-----END PGP SIGNATURE-----
