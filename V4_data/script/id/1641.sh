#!/bin/bash

# CHANGELOG
# [SuperPlumus] (2013-06-27 11-59)
#   Clean code
# [petch] (2013-08-09 03-35)
#   Update md5

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Shape3D X"
PREFIX="Shape3D"
WORKING_WINE_VERSION="1.4.1"

EDITOR="Shape3D"
EDITOR_URL="http://www.shape3d.com/"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "Tinou" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

cd "$WINEPREFIX/drive_c"

POL_Download "http://www.shape3d.com/Shape3d/InstallX/sh3dX.exe" "8fc227ae4eb6ee81adbb968ab3216e67"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "sh3dX.exe"

POL_Call POL_Install_gdiplus

POL_Shortcut "Shape3d.exe"  "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlIQ/YsACgkQ5TH6yaoTykcc6ACbBUET4a0a7bHk8JkcL0AGjxN7
DPgAn2JW376fLFYH8+oeZ84Gyk1mga0+
=6w+b
-----END PGP SIGNATURE-----
