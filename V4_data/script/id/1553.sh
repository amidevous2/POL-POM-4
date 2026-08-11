#!/bin/bash
# Date : (2013-01-26 12-16)
# Last revision : (2014-03-30 22-15)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="dark_reign_expansion"
PREFIX="DarkReign_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Dark Reign and Expansion"
SHORTCUT_NAME1="Dark Reign - The Future of War"
SHORTCUT_NAME2="Dark Reign - The Rise of the Shadowhand"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1553
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Auran / Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "4de0f0ee707da1a7139a33ea1548ff92"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

# Yeah
POL_SetupWindow_VMS "1"

# "Please GOG, Wine's explorer.exe is not as troublesome as XP Home's, don't kill it"
POL_Wine_UpdateRegistryPair 'HKEY_LOCAL_MACHINE\Software\GOG.com\GOGDARKREIGN' 'WINDOWSXPHOME' 'True'

# Scroll devilishly fast for me otherwise
cd "$GOGROOT/Dark Reign/" || POL_Debug_Fatal "Could not find game directory"
cp TACTICS.CFG TACTICS.CFG.orig
sed -e 's/^ScrollSpeed=[0-9]\+/ScrollSpeed=5/' TACTICS.CFG.orig > TACTICS.CFG
# If you think I should also drop GameSpeed, or any other tweak, just tell me

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Dark Reign - Original Game.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Dark Reign/Manual.pdf"
# C:\GOG Games\Dark Reign\readme.txt

POL_Shortcut "Dark Reign - Expansion.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;StrategyGame;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlM7IcYACgkQ5TH6yaoTykeIBgCfZqWi+DeyzTyjBO8HOKGBdsZ4
MRUAn3kL5cJqWcXTZ4L6YsDHbiAhb3Xf
=pPAS
-----END PGP SIGNATURE-----
