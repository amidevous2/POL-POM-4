#!/bin/bash
 
# CHANGELOG
# [Tinou] (2009 ?)
#   Initial script.
# [Dadu042] (2020-01-15 22:50)
#   Wine version unknown (system's ?) -> 3.0.3
#   Force arch x86.
# [Dadu042] (2020-01-17 11:50)
#   Script tested with CD.
#   Add POL_Shortcut_Document

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GEX 1.0"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "GEX 1.0" "Microsoft Games" "" "Tinou" "Gex1"
 
POL_RequiredVersion 4.0.18 || POL_Debug_Fatal "This program requires $APPLICATION_TITLE 4.0.18"
 
POL_Wine_SelectPrefix "Gex1"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "3.0.3"
 
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Loader.exe"
 
POL_Wine_WaitBefore "$TITLE"
mkdir -p "$WINEPREFIX/drive_c/Gex"
 
POL_System_CopyDirectory "$CDROM" "$WINEPREFIX/drive_c/Gex"
Set_Desktop On 800 600
POL_Wine_Direct3D "DirectDrawRenderer" "gdi"
 
POL_Shortcut "Loader.exe" "$TITLE - Loader" "" "" "Game;"
POL_Shortcut_Document "$TITLE" "Readme.txt"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiGQ3QAKCRDlMfrJqhPK
R5pLAKCIYkfEoMYIqcEjI65NFmwqlTelkgCZAdNGhvosVXQBlOTPgXtQa2DewXE=
=fSos
-----END PGP SIGNATURE-----
