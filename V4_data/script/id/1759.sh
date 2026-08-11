#!/bin/bash
# Date : (2014-05-07 09-32)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Wheezy (Stable) - LXDE
# Author : 3limin4t0r
# Program licence : Retail
# Depend :

# CHANGELOG
# [Dadu042] (2020-10-30 20-00).
#   Initial script.
# [Dadu042] (2020-12-17 20-00).
#   Wine 1.6.2 -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="unreal_tournament_goty"
PREFIX="UnrealGOTY_gog"
WORKING_WINE_VERSION="3.0.3"
PATCH_ARCHIVE="utglr36.zip"

TITLE="GOG.com - Unreal Tournament GOTY"
SHORTCUT_NAME="Unreal Tournament GOTY"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1759
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Epic Games" "http://www.gog.com/gamecard/$GOGID" "3limin4t0r" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "0d25ec835648710a098aff7106187f38"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install

# GoG work
Set_OS winxp

POL_SetupWindow_VMS "8"

# Default OpenGL renderer crashes on exit, pick a better one
# Source http://www.cwdohnal.com/utglr/
POL_Download "http://files.playonlinux.com/$PATCH_ARCHIVE" "72f83fa389f7ba26f67103df7f4e255f"

POL_System_ExtractSingleFile "$PATCH_ARCHIVE" "OpenGLDrv.dll" "$GOGROOT/Unreal Tournament GOTY/System/OpenGlDrv.dll"

# Doesn't hurt
POL_Wine_reboot

POL_Shortcut "UnrealTournament.exe" "$SHORTCUT_NAME" "" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Unreal Tournament GOTY/Manual/Manual.pdf"
# C:\GOG Games\Unreal Tournament GOTY\Help\ReadMe.htm

# OpenGL tip
POL_SetupWindow_message "$(eval_gettext 'On first run the game will autodetect available renderers.\nIt is likely that you will get better performance out of the OpenGL renderer;\nYou can select it after clicking on "Show all devices".')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX9sNcwAKCRDlMfrJqhPK
R843AJ0Zhh/xWP2W16lx5vwOihUUKXXPVACeKw5NenNN4vS2zznpC3FXRrAouRM=
=Ww2W
-----END PGP SIGNATURE-----
