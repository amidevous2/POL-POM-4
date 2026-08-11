#!/bin/bash
# Date : (2011-11-07 20-54)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test :
# Author : Tinou & Tutul (update)
 
# CHANGELOG
# [Quentin] (2011-11-07 20-54)
#   Initial script
# [SuperPlumus] (2013-06-23 20-38)
#   gettext
#   clean code
# [Dadu042] (2020-01-08 13-15) (tested with IZArc v3.81, 2007)
#   Improve POL_Shortcut
#   Wine 1.2.2 -> 3.0.3
 
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
 
TITLE="IZArc"
PREFIX="IZArc"
WORKING_WINE_VERSION="3.0.3"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/izarc/top.jpg" "http://files.playonlinux.com/resources/setups/izarc/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "mirc" "http://www.izarc.org/" "Tinou" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_System_TmpCreate "$PREFIX"
 
cd "$POL_System_TmpDir"
POL_Download "$SITE/divers/IZArc_Setup.exe" "6b5bb047423c5b21808a27d8d7da7030"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "IZArc_Setup.exe"
POL_Wine_WaitExit "$TITLE"
 
# POL_Wine_SetVideoDriver
 
POL_System_TmpDelete
 
POL_Shortcut "IZArc.exe" "$TITLE" "" "" "Utility;"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhXKywAKCRDlMfrJqhPK
R+ZWAKCgNuHMK+PEE5WvfU4cwGHHEjhV5wCeLhnzKAkhVDdU7v9LEP6BS4Yfvz0=
=A7QL
-----END PGP SIGNATURE-----
