#!/bin/bash
# Date : (2013-01-30 19-01)
# Last revision : see changelog
# Wine version used : 1.4.1, 1.6.2, 1.7.5
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-01-30 19-01)
#   Initial script.
# [Pierre Etchemaite] (2014-06-04 00-00)
#   Script updated for GOG's installer v2.
#   Upgrade Wine to 1.7.5, improves performance and fixes squarish "left hand smoke"
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.7.5 (outdated) -> 3.0.3 (not tested)
#   POL_Install_d3dx9_36 -> POL_Install_d3dx9_43


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="tales_of_monkey_island"
PREFIX="TalesOfMonkeyIsland_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Tales of Monkey Island"
SHORTCUT_NAME1="ToMI S1E1: Launch of the Screaming Narwhal"
SHORTCUT_NAME2="ToMI S1E2: The Siege of Spinner Cay"
SHORTCUT_NAME3="ToMI S1E3: Lair of the Leviathan"
SHORTCUT_NAME4="ToMI S1E4: The Trial and Execution of Guybrush Threepwood"
SHORTCUT_NAME5="ToMI S1E5: Rise of the Pirate God"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1555
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Telltale Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "063aae082dbdb87399f33e891ab2b688"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_Call POL_Install_d3dx9_43

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "MonkeyIsland101.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME1"

POL_Shortcut "MonkeyIsland102.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME2"

POL_Shortcut "MonkeyIsland103.exe" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME3"

POL_Shortcut "MonkeyIsland104.exe" "$SHORTCUT_NAME4" "$SHORTCUT_NAME4.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME4"

POL_Shortcut "MonkeyIsland105.exe" "$SHORTCUT_NAME5" "$SHORTCUT_NAME5.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME5"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx5eAAKCRDlMfrJqhPK
R8WhAJ4pqqFAs6+uTJMZ5MSOP8ATar/uvwCgiRECvnQw29BHs+z8qgTQruJRKA0=
=I8DQ
-----END PGP SIGNATURE-----
