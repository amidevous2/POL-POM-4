#!/usr/bin/env playonlinux-bash
# Date : (2019-03-07 09-33)
# Last revision : (2019-03-07 09-33)
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 18.10 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Game v1.0 (DVD 2012)
# Not tested: online update.
 
[ "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Angry Birds Star Wars"
PREFIX="angrybirds_sw"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Rovio"
GAME_URL="https://en.wikipedia.org/wiki/Angry_Birds_Star_Wars"
 
Set_OS win7
 
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
###############
# Go          #
###############
 
POL_SetupWindow_InstallMethod "LOCAL,CD"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "ABSW.ico"
        POL_Wine start /unix "$CDROM/AngryBirdsStarWars.exe"
        POL_Wine_WaitExit "AngryBirdsStarWars.exe"
        cd "$POL_System_TmpDir"
fi
  
POL_Shortcut "AngryBirdsStarWars.exe" "$TITLE" ""
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNgeSwAKCRDlMfrJqhPK
R6ftAKCxG4k395Bv5zZdOGogdwGumnpaIgCePrp/npTJ/mmPwXG1u2dKT842PzY=
=cdbu
-----END PGP SIGNATURE-----
