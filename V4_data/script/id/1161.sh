#!/bin/bash
# Date : (2012-05-03 18-24)
# Last revision : (2014-03-09 18-23)
# Wine version used : 1.5.3, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# 1.5.2 fixes too large font http://bugs.winehq.org/show_bug.cgi?id=23513

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="dark_fall_lights_out"
PREFIX="DarkfallLightsOut_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Dark Fall: Lights Out"
SHORTCUT_NAME="Dark Fall: Lights Out"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1161
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "XXv Productions / Nordic Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "ee38a88891d21640e9c0778719bcaa73"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "DarkFall2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Dark Fall - Lights Out/manual.pdf"
# C:\GOG Games\Dark Fall - Lights Out\Readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEUEABECAAYFAlMeF04ACgkQ5TH6yaoTykfRTwCXQtwdSOEDw3hnjjATGmQ2RsQ7
ewCghXdLXkOaANNl3TeJmD6tzjd7K54=
=qdmu
-----END PGP SIGNATURE-----
