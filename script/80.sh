#!/bin/bash
# Date : (????-??-?? ??-??)
# Last revision : (2013-05-19 21-40)
# Wine version used : 1.2.3
# Distribution used to test :
# Author : Zoloom

# CHANGELOG
# [SuperPlumus] (2011-10-30 05-55)
#   Updated for pol 4
#   Change Wine version 1.1.42 -> 1.2.3
#   Add installation methods Steam and Local
# [SuperPlumus] (2013-05-19 21-40)
#   clean code + gettext

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Age of Wonders"
PREFIX="AgeOfWonders"
WORKING_WINE_VERSION="1.2.3"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Triumph Studio" "http://www.triumphstudios.com/" "Zoloom" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "CD,LOCAL,STEAM"

if [ "$INSTALL_METHOD" = "CD" ]
then

POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$CDROM/Setup.exe"
POL_Wine_WaitExit "$TITLE"

fi
if [ "$INSTALL_METHOD" = "LOCAL" ]
then

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

fi
if [ "$INSTALL_METHOD" = "STEAM" ]
then

POL_Call POL_Install_steam
POL_Call POL_Install_steam_flags "61500"
POL_Wine_WaitBefore "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "Steam.exe" "steam://install/61500"
POL_Wine_WaitExit "$TITLE"

fi

POL_Call POL_Install_directplay

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Triumph Studios/Age of Wonders/Images/Scenes" || POL_Debug_Error "Not found game directory"
mv "Intro.avi" "IntroDISABLE.avi"
#POL_SetupWindow_message "$(eval_gettext 'The introdution movie was renamed because it doesn't appear\ncorrectly with Wine.\nYou can watch it in the Images/Scenes of\nthe game's directory.')" "$TITLE"

POL_Wine_SetVideoDriver

POL_System_TmpDelete

if [ "$INSTALL_METHOD" = "STEAM" ]; then
POL_Shortcut "Steam.exe" "$TITLE" "" "steam://rungameid/61500"
else
POL_Shortcut "AoWSetup.exe" "$TITLE"
fi

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGZLI4ACgkQ5TH6yaoTykdtfgCfflEUkZAETnmfj52qmBWNCY2O
c3wAn3hvYofRbx6+2qEiwEYIpQwPDxSk
=QyfM
-----END PGP SIGNATURE-----
