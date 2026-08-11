#!/bin/bash
# Date : (2012-04-22 14-16)
# Last revision : (2013-05-15 19-47)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="fallout_tactics"
PREFIX="FalloutTactics_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Fallout Tactics"
SHORTCUT_NAME="Fallout Tactics"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1139
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Micro Forté / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "135be2469429feb1febf48337cf00caf" "41e861cf49576994231d5afd28ffde82" "89953850fce88a182fcefceb9a2ed24d"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

# The need for this is not totally proven
POL_Wine_Direct3D "DirectDrawRenderer" "gdi"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "BOS.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Fallout Tactics/MANUAL.PDF"
# C:\GOG Games\Fallout Tactics\readme.txt
# C:\GOG Games\Fallout Tactics\FT Tools.exe
# C:\GOG Games\Fallout Tactics\EDITOR_README.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGT6CUACgkQ5TH6yaoTykedkACglJon7xIt6HQc6IAuGwCCvrvX
CWsAnRaBNyPXKakqDSzH5QGirespPyPG
=RI2F
-----END PGP SIGNATURE-----
