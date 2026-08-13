#!/bin/bash
# Date : (2009-06-25 13-14)
# Last revision : see changelog.
# Wine version used : 2.22
# Distribution used to test : N/A
# Author : NSLW

# CHANGELOG
# [SuperPlumus] (2012-04-10 19-01)
#   Rewritting
# [Dadu042] (2020-01-27 19:30)
#   Wine 1.2 -> 2.22
#

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Need for Speed III : Hot Pursuit"
PREFIX="NeedForSpeed3_HotPursuit"
WORKINGVERSION="2.22"
 
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "EA Games" "N/A" "NSLW" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "win98"

POL_SetupWindow_InstallMethod "CD,LOCAL"

if [ "$INSTALL_METHOD" = "CD" ]
then

POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "nfs3.exe"

cd "$CDROM"
POL_SetupWindow_menu "Choose the game language you want" "$TITLE" "english~german~spanish~italian~swedish~french" "~"
POL_Wine_WaitBefore "$TITLE"
if [ ! -e "$CDROM/setup/$APP_ANSWER/setup.exe" ]; then
POL_Debug_Warning "$CDROM/setup/$APP_ANSWER/setup.exe not found ! Use $CDROM/setup/english/setup.exe"
POL_Wine start /unix "$CDROM/setup/english/setup.exe"
else
POL_Wine start /unix "$CDROM/setup/$APP_ANSWER/setup.exe"
fi
POL_Wine_WaitExit "$TITLE"

elif [ "$INSTALL_METHOD" = "LOCAL" ]
then

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

fi

POL_Shortcut "nfs3.exe" "$TITLE" "" "-d3d0" "Game;"
 
POL_SetupWindow_Close
 
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjH1ZwAKCRDlMfrJqhPK
Rwh3AKCPrXmz5Dx7PmLDqgKndP3Upcpf7gCfUFQ/+ircIU6Br/vpL8djtKBkcAo=
=pO+A
-----END PGP SIGNATURE-----
