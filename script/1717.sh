#!/bin/bash
# Date : (2013-03-28 19-56)
# Last revision : (2014-04-23 00-17)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="zork_grand_inquisitor"
PREFIX="ZorkGI_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Zork Grand Inquisitor"
SHORTCUT_NAME="Zork Grand Inquisitor"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1717
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "e358d02336503b0275e6cd66c1bcea49"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

# High-color 640x480, however since it's not the original engine that's used, 
# it's probably even more meaningless
POL_SetupWindow_VMS "1"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Zengine.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "-f" "Game;AdventureGame;"
# See: http://wiki.winehq.org/Sound ("SDL applications").
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'unset SDL_AUDIODIVER'

POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Zork Grand Inquisitor/manual.pdf"
# C:\GOG Games\Zork Grand Inquisitor\README.rtf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNYNqoACgkQ5TH6yaoTykc0jgCfQI58VEEWdwpFVs1IbnuBMTKR
4ZcAn0h+6f3srE7uj+yRhTSZItZunSnW
=YKZ9
-----END PGP SIGNATURE-----
