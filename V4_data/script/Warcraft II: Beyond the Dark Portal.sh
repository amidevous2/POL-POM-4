#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Warcraft II: Beyond the Dark Portal"
export WINEDEBUG="-all"

#Presentation
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Blizzard" "" "Tinou" "WarcraftII"

POL_SetupWindow_cdrom
if [ -e "$CDROM/INSTALL.EXE" ]; then
	setup="INSTALL.EXE"
else
	setup="SETUP.EXE"
fi
POL_SetupWindow_check_cdrom "$setup"

POL_Wine_SelectPrefix "WarcraftII"
POL_SetupWindow_prefixcreate "1.4-dos_support_0.5"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$CDROM/$setup"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/Pwa8ACgkQ5TH6yaoTykf0/ACfVgmCRdZDbqpRFh/pRLsjIt0f
AYQAn1iU6PW04JkxqSNZlrH1pURVAI8F
=3jGA
-----END PGP SIGNATURE-----
