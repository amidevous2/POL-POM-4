#!/bin/bash
# Date : (2013-02-01 21-35)
# Last revision : 
# Wine version used :
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-02-01 21-35)
#   Initial script.
# [Pierre Etchemaite] (2013-11-12 23-50)
#   ?
# [Dadu042] (2020-04-22 21:00)
#   Script updated for GOG's installer v2.
#   Wine 1.4.1 (outdated) -> system

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="silent_storm_gold"
PREFIX="SilentStorm_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - S2: Silent Storm Gold Edition"
SHORTCUT_NAME1="Silent Storm"
SHORTCUT_NAME2="Silent Storm Sentinels"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1560
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Nival Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "257847b0c39a66c490396170cadcf3cf"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "game.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Silent Storm Gold/Silent Storm/Manual.pdf"

POL_Shortcut "Sentinels.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Silent Storm Gold/Silent Storm Sentinels/UserManual/index.html"

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCfRgAKCRDlMfrJqhPK
RxWYAJ4kBGA1OOtZF8tbY0Kh8tv9n+SsqACgkGUsp996ljrMf6BNRlyimLc8O0o=
=OUEK
-----END PGP SIGNATURE-----
