#!/bin/bash
#
# Date : (2016-08-02 19-43)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Manjaro Linux 16.06.1
# Author : OdzioM
# Licence : Retail
#
# CHANGELOG
# [OdzioM] (2016-08-02 19-43)
#   Initial script.
# [Dadu042] (2020-01-29)
#   1.9.15-staging -> 3.0.3
#

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Castlevania: Lords of Shadow"
INFO1="Konami"
INFO2="https://www.konami.com/castlevania/"
AUTHOR="OdzioM"
PREFIX="CastlevaniaLofS"
WORKING_WINE_VERSION="3.0.3"
WINE_ARCH="x86"
GAME_VMS="64"


POL_GetSetupImages "http://odziomek.pl/playonlinux/$PREFIX/top.jpg" "http://odziomek.pl/playonlinux/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$INFO1" "$INFO2" "$AUTHOR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"

POL_System_SetArch "$WINE_ARCH"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_InstallMethod "LOCAL"

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_VMS $GAME_VMS

POL_Shortcut "Castlevania.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_message "Installation complete!\n\nTo run $TITLE please select $TITLE icon from your desktop." "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjFeswAKCRDlMfrJqhPK
R3sdAJ9H06giCE/iRuKtNSqCTQ2S94Ec0wCdFu39xVLfVwPXmhZ8ryLv4BtHlt4=
=rEAk
-----END PGP SIGNATURE-----
