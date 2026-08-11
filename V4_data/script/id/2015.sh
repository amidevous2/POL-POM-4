#!/bin/bash
# Date : (2014-04-25)
# Last revision : see changelog
# Wine version used : 1.7.17
# Distribution used to test : Archlinux
# Author : Romain Hennuyer romain.hennuyer@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Romain Hennuyer] (2014-04-25)
#   Initial script, for the GOG release.
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.7.17 -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="hotline_miami"
PREFIX="Hotline_miami_gog"
WORKING_WINE_VERSION="3.0.3"
 
TITLE="GOG.com - Hotline miami"
SHORTCUT_NAME="Hotline miami"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 2015
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Dennaton Games / Devolver Digital" "http://www.gog.com/gamecard/$GOGID" "Romain Hennuyer" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" "f617d89c8f7c00f5407a694ec2e06b9b" # = 2.1.0.6
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install
 
POL_Shortcut "HotlineGL.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;Action;"
POL_Shortcut "HotlineLauncher.exe" "$SHORTCUT_NAME Launcher" "$SHORTCUT_NAME.png" "" "Game;Action;"

POL_SetupWindow_Close
 
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwqPgAKCRDlMfrJqhPK
RxOtAJ0dYToPEtgwC/R9dHcg8nBSmfGXuwCgofvWyFcVHPlWK5B1Ai7JNABzs7A=
=y9OO
-----END PGP SIGNATURE-----
