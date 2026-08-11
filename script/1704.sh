#!/bin/bash
# Date : (2013-05-21 20-47)
# Last revision : (2013-10-22 02-48)
# Wine version used : 1.5.30
# Distribution used to test : Xubuntu 13.04
# Author : Pascal Reinhard dev@ovocean.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="populous_the_beginning"
PREFIX="Populous3TheBeginning_gog"
WORKING_WINE_VERSION="1.5.30"

TITLE="GOG.com - Populous 3: The Beginning"
SHORTCUT_NAME="Populous 3: The Beginning"
SHORTCUT_NAME_SOFTWARE="Populous 3: The Beginning (software rendering)"
SHORTCUT2_NAME="Populous 3: Undiscovered Worlds"
SHORTCUT2_NAME_SOFTWARE="Populous 3: Undiscovered Worlds (software rendering)"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1704
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bullfrog Productions / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Xodetaetl" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "7e4545d04a3d00193507aa82dea14e50"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# The Beginning shortcut
POL_Shortcut "D3DPopTB.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut "popTB.exe" "$SHORTCUT_NAME_SOFTWARE" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"

# Undiscovered Worlds shortcut
POL_Shortcut "D3DPopTBUW.exe" "$SHORTCUT2_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut "popTB.exe" "$SHORTCUT2_NAME_SOFTWARE" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Populous 3/Manual.pdf"

POL_Shortcut_Document "$SHORTCUT_NAME_SOFTWARE" "$GOGROOT/Populous 3/Manual.pdf"
POL_Shortcut_Document "$SHORTCUT2_NAME" "$GOGROOT/Populous 3/Manual.pdf"
POL_Shortcut_Document "$SHORTCUT2_NAME_SOFTWARE" "$GOGROOT/Populous 3/Manual.pdf"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMwY30ACgkQ5TH6yaoTykeBwQCfU/wqQE8W9wx0uWW7kVgXC/bD
nj4AmgJgqidN75NzXo/MtqbfNbB/LgZi
=5QuW
-----END PGP SIGNATURE-----
