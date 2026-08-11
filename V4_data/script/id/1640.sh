#!/bin/bash
# Date : (2013-03-31)
# Last Revision : (2013-09-06 07:12)
# Wine version used : 1.5.10
# Distribution used to test : Debian Wheezy (Testing repositories)
# Author : VisitntX visitntx@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# Tested on Debian Testing branch. The game install fine and plays well. Using an Intel HD Graphics on an Acer Aspire 5742z.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="balls_of_steel"
PREFIX="BallsOfSteel_gog"
WORKING_WINE_VERSION="1.5.10"

TITLE="GOG.com - Balls of Steel"
SHORTCUT_NAME="Balls of Steel"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1640
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "3D Realms Entertainment / 3D Realms" "http://www.gog.com/en/gamecard/$GOGID" "VisitntX" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "0312064c1b834c0bbb7d091ebc85fdc6"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# Setting up Windows OS version Emulation
Set_OS winxp

# Cleaning up by rebooting Wine
POL_Wine_reboot

POL_Shortcut "bos.exe" "$SHORTCUT_NAME" "" "" "Game;Simulation;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com/Balls of Steel/manual.pdf"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlIqHggACgkQ5TH6yaoTykcUFgCgm7aWvq/Pgh+qrPOUOascOxIV
llAAniGLa8H1xO5j/t0jK26xKa2Tfj68
=EtzG
-----END PGP SIGNATURE-----
