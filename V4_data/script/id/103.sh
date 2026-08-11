#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Warcraft II"
export WINEDEBUG="-all"

#Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "Warcraft II" "Blizzard" "" "Tinou" "WarcraftII"

POL_SetupWindow_cdrom
if [ -e "$CDROM/INSTALL.EXE" ]; then
	setup="INSTALL.EXE"
else
	setup="SETUP.EXE"
fi
POL_SetupWindow_check_cdrom "$setup"

POL_Wine_SelectPrefix "WarcraftII"
POL_SetupWindow_prefixcreate "1.4-dos_support_0.5"

POL_Wine_WaitBefore "Warcraft II"
POL_Wine "$CDROM/$setup"

POL_Shortcut "WAR2.EXE" "Warcraft II"
POL_Shortcut "WAR2ED95.EXE" "Warcraft II - Map Editor"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/PwZoACgkQ5TH6yaoTykecBgCdGIymRRwa1q7EbjxbKmTAAWt5
UOYAnRXRBtc47bYG2kk9UN4On8eG4taR
=+i1y
-----END PGP SIGNATURE-----
