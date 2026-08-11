#!/bin/bash

## Note for the future: Could also be installed with XP SP2 

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Microsoft Pinball"
WINEVERSION="1.7.37"
EDITOR="Microsoft"
EDITOR_URL="http://www.microsoft.com"
PREFIX="MicrosoftPinball"

POL_SetupWindow_Init
POL_Debug_Init


POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

cd "$WINEPREFIX/drive_c/" || POL_Debug_Fatal "Unable to change directory"

POL_Call POL_Install_LunaTheme
POL_Download "https://www.dropbox.com/s/2qgtjp7lyegps1w/3d_pinball_for_windows_-_space_cadet.exe?dl=1" "2670a7ecdab26460f5217ffe43ba4279"
mv "3d_pinball_for_windows_-_space_cadet.exe?dl=1" "3d_pinball_for_windows_-_space_cadet.exe"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "3d_pinball_for_windows_-_space_cadet.exe"

POL_Shortcut "PINBALL.EXE"  "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlViXR4ACgkQ5TH6yaoTykeZlgCfc3TTIaIaXwDExz5fMtaYULdz
BEAAoI/o7eIV7NbGHSJSxo7QkZ0PU+Xk
=V8Uv
-----END PGP SIGNATURE-----
