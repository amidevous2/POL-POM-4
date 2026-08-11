#!/bin/bash

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Age Of Mythology"
PREFIX="AgeOfMythologyGold"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Microsoft" "" "Tinou" "$PREFIX" 


POL_SetupWindow_InstallMethod "DVD"

if [ "$INSTALL_METHOD" = "DVD" ]; then
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "Autorun.exe"

	POL_Wine_SelectPrefix "$PREFIX" 
	POL_Wine_PrefixCreate "1.4"

	POL_Call POL_Install_mfc42
	POL_Wine_OverrideDLL native,builtin pidgen.dll

	POL_Wine --ignore-errors "$CDROM/Autorun.exe" 
	POL_Wine_WaitExit "$TITLE"

	POL_Wine --ignore-errors "$CDROM/Autorun.exe" 
	POL_Wine_WaitExit "$TITLE - The Titans"

fi

POL_LoadVar_ScreenResolution
POL_Shortcut "aom.exe" "$TITLE" "" "xres=$ScreenWidth yres=$ScreenHeight"
POL_Shortcut "aomx.exe" "$TITLE - The Titans" "" "xres=$ScreenWidth yres=$ScreenHeight"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlAlBDIACgkQ5TH6yaoTykca9ACfUxjE8+6Pf6tfjnJEYxhvWUot
KskAoJvud+9DEf48kRjS3AOvXTBR1PXA
=akue
-----END PGP SIGNATURE-----
