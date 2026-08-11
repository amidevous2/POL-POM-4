#!/bin/bash
# Date : (2012-06-03 18-35)
# Last revision : 
# Wine version used : 1.4.1, 1.5.4
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-06-03 18-35)
#   Initial script.
# [Pierre Etchemaite] (2013-11-01 18-46)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="ufo_afterlight"
PREFIX="UfoAfterlight_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - UFO: Afterlight"
SHORTCUT_NAME="UFO: Afterlight"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1243
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Altar Interactive / 1C Publishing" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "5ae01cf10378020fc492a53655c063a2" "0ef944c8daf01338db8ac4ccce854cbc" "0389fdfd732fff2067c3abf538d6962c"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "UFO.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/UFO Afterlight/manual.pdf"
# C:\GOG Games\UFO Afterlight\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxGagAKCRDlMfrJqhPK
RzEtAJ4k6iNtEdgeWEpfCBIVCf6x2jmw3gCeLbQc0OsxbXan5aBp4falGjBmOxM=
=3bXQ
-----END PGP SIGNATURE-----
