#!/bin/bash
# Date : (2012-11-18 16-24)
# Last revision : (2014-02-02 19-44)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Ubuntu 12.10 64-bit
# Author : Kweepeer (Based on Broken Sword DC script by Pierre Etchemaite)
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# Known issues:
# - The game freezes sometimes during gameplay. After a few seconds, the game continues.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="deponia"
PREFIX="Deponia_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Deponia"
SHORTCUT_NAME="Deponia"

POL_GetSetupImages "" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1467
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Daedalic Entertainment" "http://www.gog.com/gamecard/$GOGID" "Kweepeer" "$PREFIX"
POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 \
  "2ce339e5a03f61ac1bbddd553216e66b" \
  "a379e713fbed5b6455d2fc5eab24a904" \
  "5b37bb639b9c09975a44ea10b811c55c" \
  "73619a4389c6d56bec65e047b68abeda"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install /nogui


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "256"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Deponia.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Deponia/Manual.pdf"

# Fix missing sound issue in cutscenes.
# See: http://wiki.winehq.org/Sound ("SDL applications").
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'unset SDL_AUDIODIVER'

# Fix savegame issue.
# http://bugs.winehq.org/show_bug.cgi?id=31251
mkdir "$WINEPREFIX/drive_c/tmp"

POL_SetupWindow_Close

# Note on configurator:
# VisionaireConfigurationTool.exe requires .NET 4.0
# You can set advanced options by editing $WINEPREFIX/drive_c/GOG Games/Deponia/config.ini.
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlLumVsACgkQ5TH6yaoTykfBMACeMCbpo4DtKPzFWiirhJr6a1Bd
72YAmwTpmuGTxKPqY0mjSLoIyGsFqsd5
=rzmK
-----END PGP SIGNATURE-----
