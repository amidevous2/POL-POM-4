#!/usr/bin/env playonlinux-bash
# Date : (2019-03-11 14-00)
# Last revision : (2019-03-11 14-00)
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Game installer v2.0.0 (2010)
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Angry Birds Seasons"
PREFIX="angrybirds_s"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Rovio"
GAME_URL="https://en.wikipedia.org/wiki/Angry_Birds_Seasons"
 
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
        POL_SetupWindow_check_cdrom "ABS.ico"
         POL_Wine start /unix "$CDROM/AngryBirdsSeasonsInstaller_2.0.0.exe"
#        POL_Wine_WaitExit "AngryBirdsSeasons.exe"
        cd "$POL_System_TmpDir"
fi
  
POL_Shortcut "AngryBirdsSeasons.exe" "$TITLE" "" "" "Game;"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXicxugAKCRDlMfrJqhPK
R0aSAKCuwiy97JepI9l02Ofl73EPbfHn1ACdHoJ/01t7ehvJvjPOWtww61+JIvc=
=SFdP
-----END PGP SIGNATURE-----
