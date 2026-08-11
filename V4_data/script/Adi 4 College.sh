#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Adi 4"
WINEVERSION="1.2.3"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Coktel" "" "Tinou" "Adi4"


POL_Wine_SelectPrefix "Adi4"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

POL_Wine_WaitBefore "$TITLE"
cd "$CDROM"
POL_Wine "$CDROM/setup.exe"

POL_Shortcut "ADI4.EXE"  "Adi 4"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+xPkgACgkQ5TH6yaoTykcqswCeJiCvrM1JQuko/lbhi0ecYRI4
F0EAnRX+PCnRSk7MJs3Mdo1SWX9RhSwG
=An/i
-----END PGP SIGNATURE-----
