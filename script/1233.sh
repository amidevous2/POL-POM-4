#!/bin/bash
# Date : (2012-05-28 00-58)
# Last revision : 
# Wine version used : 1.5.5, 1.5.15, 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-28 00-58)
#   Initial script.
# [Pierre Etchemaite] (2013-11-18 00-38)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.5.15 (outdated) -> 2.22 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_nations_gold_edition"
PREFIX="TheNationsGE_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - The Nations Gold Edition"
SHORTCUT_NAME="The Nations (Gold Edition)"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1233
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "JoWooD Productions Software / Nordic Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c5a025eab7d9516d32a2a3ac4dd3e96b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "game.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/The Nations Gold/manual.pdf"
# C:\GOG Games\The Nations Gold\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxNFwAKCRDlMfrJqhPK
R8vbAJ9CNhyJjl4YeWbvRs0Xb65acl3pewCaA9ImkbaV7b/MhRGd8K5vhFqqEIA=
=d0iH
-----END PGP SIGNATURE-----
