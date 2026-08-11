#!/bin/bash
# Date : (2012-05-20 10-47)
# Last revision : (2013-11-29 00-31)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# CHANGELOG
# [Pierre Etchemaite] (2012-05-20 10-47)
#   Initial script.
#   Wine 1.4.1 -> 1.6.2 ?
# [Dadu042] (2020-04-09 19:30)
#   Wine 1.4.1 (outdated) -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="evil_genius"
PREFIX="EvilGenius_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Evil Genius"
SHORTCUT_NAME="Evil Genius"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1228
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Elixir Studio / Rebellion" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "48878a45318f120393e5763ccbbcbe0f"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "EvilGeniusExeStub-Release.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"

POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Evil Genius/manual.pdf"
# C:\GOG Games\Evil Genius\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXo9gIwAKCRDlMfrJqhPK
R5TQAKCD5Q/lhBNmH9TtU8yYuIhOPBe5yQCgrv4CLpJ19MXwc7A65vv1mOh2Uug=
=oLZJ
-----END PGP SIGNATURE-----
