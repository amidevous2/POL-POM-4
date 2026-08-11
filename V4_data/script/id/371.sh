#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Adibou 2"

[ "$POL_OS" = "Mac" ] && WINEVERSION="1.2.3-16bits"
[ "$POL_OS" = "Linux" ] && WINEVERSION="1.2.3"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "Adibou 2" "Coktel" "" "Tinou" "Adibou2"

POL_RequiredVersion 4.0.18 || POL_Debug_Fatal "This program requires $APPLICATION_TITLE 4.0.18"

POL_Wine_SelectPrefix "Adibou2"
POL_Wine_PrefixCreate "$WINEVERSION"


POL_SetupWindow_cdrom
POL_SetupWindow_cdrom_MountPC "setup.exe"
POL_SetupWindow_check_cdrom "setup.exe"

POL_Wine_WaitBefore "$TITLE"
mkdir -p "$WINEPREFIX/drive_c/Adibou2"
cd "$WINEPREFIX/drive_c/Adibou2" || POL_Debug_Fatal "Directory not found $WINEPREFIX/drive_c/Adibou2"
cp -r "$CDROM"/* ./ & pid="$!"

POL_SetupWindow_DirectoryProgress "$WINEPREFIX/drive_c/Adibou2" "1126616" "$pid"

POL_SetupWindow_cdrom_UmountPC

POL_Shortcut "WLOADER.EXE"  "Adibou 2"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+sHh0ACgkQ5TH6yaoTykfLpwCdF7mNLofrir19iHmj94OwBDsI
QloAn3M8YbwQ7s5tdbbJH4Ys13a8t0fK
=a0D6
-----END PGP SIGNATURE-----
