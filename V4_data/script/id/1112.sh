#!/bin/bash
# Date : (2012-03-17 23-07)
# Last revision :
# Wine version used : 1.6
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# Wine
# 1.5.18 fixes lots of issues with fog and smoke, that could otherwise only be improved by disabling GLSL
# 1.6 fixes some maps that were rendered all black

# CHANGELOG
# [Pierre Etchemaite] (2012-03-17 23-07)
#   Initial script.
# [Pierre Etchemaite]  (2014-02-24 22-07)
#   ?
# [Dadu042] (2020-03-20 19:30).
#   Wine 1.6 (outdated) and OSX 1.7.13 (outdated) -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="xiii"
PREFIX="XIII_gog"
WORKING_WINE_VERSION="3.0.3"
[ "$POL_OS" = "Mac" ] && WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - XIII"
SHORTCUT_NAME="XIII"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1112
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ubisoft Paris Studios / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "7fd5bfa985aa67e83b39c6e3a4ee2a94" "c6432f023061d461e7d9875d1b9760ea" "ebee614f8b89718e10365c195d918fa0"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

POL_Wine_X11Drv "GrabFullScreen" "Y"
POL_Wine_DirectInput "MouseWarpOverride" "force"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "xiii.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/XIII/Manual.pdf"
# C:\GOG Games\XIII\Support\English\Readme.doc

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxElQAKCRDlMfrJqhPK
RyBtAKCxENlM4FAHnzI2iYrgZgHQwi09HgCffvW7n7wF84LR/hSoXowbq243R2I=
=lLJJ
-----END PGP SIGNATURE-----
