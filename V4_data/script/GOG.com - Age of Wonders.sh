#!/bin/bash
# Date : (2012-09-09 15-50)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-09-09 15-50)
#   Initial script.
# [Pierre Etchemaite] (2013-10-27 09-38)
#   ?
# [Dadu042] (2020-01-19 22:00)
#  Wine 1.4.1 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="age_of_wonders"
PREFIX="AgeOfWonders1_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Age of Wonders"
SHORTCUT_NAME="Age of Wonders"
SHORTCUT_EDITOR="$SHORTCUT_NAME - $(eval_gettext 'Editor')"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1397
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Triumph Studios" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "9ee2ccc5223c41306cf6695fc09a5634"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

POL_Call POL_Install_iv50

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Launcher.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "AoWCompat" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Age of Wonders/QuickStart.pdf"
# C:\GOG Games\Age of Wonders\Readme.txt
# C:\GOG Games\Age of Wonders\AoWEd.exe

#POL_Shortcut "AoWEd.exe" "$SHORTCUT_EDITOR" "$SHORTCUT_NAME - Editor.png" "" "Game;StrategyGame;"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYZEQAKCRDlMfrJqhPK
R4y+AJ978VHJ/o1v4tGY9nv6SsjXKUMspACgsNArGdtE0TTat/8kcqZRYIwGsrY=
=Qhyg
-----END PGP SIGNATURE-----
