#!/bin/bash
# Date : (2012-09-16 11-43)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-10-27 16-45)
#   Initial script.
# [Dadu042] (2020-01-19 22:00)
#  Wine 1.4.1 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="age_of_wonders_2_the_wizards_throne"
PREFIX="AgeOfWonders2_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Age of Wonders 2: The Wizard's Throne"
SHORTCUT_NAME="Age of Wonders 2: The Wizard's Throne"
SHORTCUT_EDITOR="$SHORTCUT_NAME - $(eval_gettext 'Editor')"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1402
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Triumph Studios" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "1bdcc812fc84e7e5f587bd7c07990b97"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Launcher.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "AoW2Compat" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Age of Wonders 2/QuickStart.pdf"
# C:\GOG Games\Age of Wonders 2\Readme.html
# C:\GOG Games\Age of Wonders 2\aow2Setup.exe

#POL_Shortcut "AoW2Ed.exe" "$SHORTCUT_EDITOR" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYZywAKCRDlMfrJqhPK
RyqTAJ43zszL9rvyJTOhnu5Ih+kT+YdeWQCgrxIj2ALwsVjAde7mx6hwZHjDaAk=
=s0Jj
-----END PGP SIGNATURE-----
