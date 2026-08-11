#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Adibou 3"
  
[ "$POL_OS" = "Mac" ] && WINEVERSION="1.2.3-16bits"
[ "$POL_OS" = "Linux" ] && WINEVERSION="6.0.3"
  
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "Adibou 3" "Coktel" "" "Tinou" "Adibou3"
  
POL_RequiredVersion 4.0.18 || POL_Debug_Fatal "This program requires $APPLICATION_TITLE 4.0.1.8"
  
POL_Wine_SelectPrefix "Adibou3"
POL_Wine_PrefixCreate "$WINEVERSION"
  
  
POL_SetupWindow_cdrom
POL_SetupWindow_cdrom_MountPC "autorun.exe"
POL_SetupWindow_check_cdrom "autorun.exe"
  
POL_Wine_WaitBefore "$TITLE"
mkdir -p "$WINEPREFIX/drive_c/Adibou3"
cd "$WINEPREFIX/drive_c/Adibou3" || POL_Debug_Fatal "Directory not found $WINEPREFIX/drive_c/Adibou3"
cp -r "$CDROM"/* ./ & pid="$!"
  
POL_SetupWindow_DirectoryProgress "$WINEPREFIX/drive_c/Adibou3" "1785928" "$pid"
  
POL_SetupWindow_cdrom_UmountPC
  
POL_Shortcut "LOADER7.EXE"  "Adibou 3"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZDQQHQAKCRDlMfrJqhPK
R3/JAJ9thsgDwVSkZnxJaS0HXIdjruwtbACfaW24e9A3AyNMppaKKXSlxzZM2w0=
=8z1o
-----END PGP SIGNATURE-----
