#!/bin/bash
# Date : (2012-08-06 19-20)
# Last revision : see changelog
# Wine version used : 1.5.5, 1.6.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# CHANGELOG:
# [Pierre Etchemaite] (2012-08-06 19-20)
#   First script.
# [?] (2013-12-13 20-08)
#   ?
# [Dadu042] (2019-12-10)
#   Wine 1.6.1 -> system version.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="dreamfall_the_longest_journey"
PREFIX="Dreamfall_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - Dreamfall: The longest journey"
SHORTCUT_NAME="Dreamfall: The longest journey"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1348
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Funcom" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "1aedb3e60d5e4e3739dd8d6c951250f5" "2040b19126c9876520c3eecd0cace163" "7bae442859f67a61e6e8b0b2f88579f6" "0f7d3fce34050205c191f676548d807d"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "dreamfall.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Dreamfall - The Longest Journey/manual.pdf"
# C:\GOG Games\Dreamfall - The Longest Journey/readme.rtf

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXfAJKgAKCRDlMfrJqhPK
RxYvAJ9Splehcjb+tuJl4N8AoBUdGnxfhwCgqRy2wRkEDVYcrM39VOUzMJdwARQ=
=v6dX
-----END PGP SIGNATURE-----
