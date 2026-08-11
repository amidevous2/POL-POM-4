#!/bin/bash
# Date : (2011-12-03 20-32)
# Last revision : see cangelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2011-12-03 20-32)
#   Initial script.
# [Pierre Etchemaite] (2013-12-24 11-48)
#   ? Wine 1.3.36 -> 1.4.1 ?
# [Dadu042] (2020-01-19 13:50)
#   Wine 1.4.1 -> 2.22

# KNOWN ISSUES (2013):
# Supposed to be "Gold" on WineHQ with 1.3.23, but I crash it with middle-click + drag
# - Same for 1.3.27-rawinput2,
# - very easily with 1.3.33
# - couldn't crash it with 1.3.34-rawinput2
# - 1.3.34 ok

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="ground_control_2_operation_exodus"
PREFIX="GrndCtrl2_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Ground Control 2"
SHORTCUT_NAME="Ground Control 2"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1016
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Massive Entertainment / Rebellion" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "db42c0a6e8c5b4c75f3969bb0d084292"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Wine_InstallFonts

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Helps at least when windowed
POL_Wine_X11Drv "GrabFullScreen" "Y"

# Remove the "beta DirectX version" warning upon first run
cat <<_EOFREG_ > "$POL_USER_ROOT/tmp/dxtested.reg"
[HKEY_LOCAL_MACHINE\Software\Massive Entertainment AB\Ground Control II]
"HardwareChecks"=dword:00000010
"HardwareCheckVersion"=dword:00000009
_EOFREG_
POL_Wine regedit "$POL_USER_ROOT/tmp/dxtested.reg"
rm "$POL_USER_ROOT/tmp/dxtested.reg"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "gcii.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Ground Control II/Manual.pdf"
# C:\GOG Games\Ground Control II\readme.txt

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiWCdQAKCRDlMfrJqhPK
R9g2AKCGeC/l2vdlXEXtEz1cT4plQpTuXwCgkeHPXKHySNaHG+jiJJ+O8+dRiDY=
=RgS9
-----END PGP SIGNATURE-----
