#!/bin/bash
# Date : (2012-12-03 20-53)
# Last revision :
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-12-03 20-53)
#   Initial script.
# [Pierre Etchemaite] (2013-07-18 19-53)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="thief_3"
PREFIX="Thief3_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Thief 3: Deadly Shadows"
SHORTCUT_NAME="Thief 3: Deadly Shadows"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1501
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ion Storm Inc. / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "e5b84de58a1037f3e8aa3a1bb2a982be"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

POL_Wine_X11Drv "GrabFullScreen" "Y"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "t3.exe" "$SHORTCUT_NAME" "" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Thief 3 - Deadly Shadows/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxKwgAKCRDlMfrJqhPK
RwVRAJ4iZHdvuxnFXW2LzLqY3ztwUWpb7ACaAg4zJRQKFsLC+D58dORlk+nv8zY=
=k8Sv
-----END PGP SIGNATURE-----
