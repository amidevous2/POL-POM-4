#!/bin/bash
# Date : (2018-05-05 14:00)
# Last revision : See changelog
# Wine version used : 3.7
# Distribution used to test : Ubuntu 16.04
# Author : Simoms
# Licence : Retail
#
# CHANGELOG
# [Simoms] (2018-05-05 14:00)
#   Initial script.
# [Dadu042] (2020-01-30 13:30)
#   Wine 3.7 -> 3.20.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
PREFIX="WarcraftIII"
WINEVERSION="3.20"
TITLE="Warcraft III"
EDITOR="Blizzard Entertainment"
GAME_URL="https://www.blizzard.com/"
AUTHOR="Simoms"
 
# PlayOnLinux Setup
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Get installer file
if [ "$POL_SELECTED_FILE" ];  then
    INSTALLER="$POL_SELECTED_FILE"
else
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    INSTALLER="$APP_ANSWER"
fi
 
[ "$INSTALLER" = "" ] && exit 0
 
# Create prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Install game
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"
 
# Ask about GPU memory size
POL_SetupWindow_VMS
 
# Create shortcuts
POL_Shortcut "$TITLE.exe" "$TITLE"
POL_Shortcut "$TITLE Launcher.exe" "$TITLE Launcher"
POL_Shortcut "World Editor.exe" "$TITLE - World Editor"
POL_Shortcut_QuietDebug "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjNTrgAKCRDlMfrJqhPK
R4PkAJ9QczHeNWt6DY6MOn3UCLzF5imPjQCfU1nIEdUDUkg1gFQaxAx3t64LYi8=
=nye9
-----END PGP SIGNATURE-----
