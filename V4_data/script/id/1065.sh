#!/bin/bash
# Date : (2012-02-19 00-28)
# Last revision : see changelog
# Wine version used : 1.5.18, 1.6.1, 1.7.6, 3.0.3
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-02-19 00-28)
#   First script
# [Dadu042] (2020-01-01)
#   Wine 1.7.6 (outdated) -> 3.0.3. Maybe POL_install_d3dx9_36 + 43 and not necessary anymore.
#   Add SetVideoDriver
#   Update POL_Shortcut_Document
#
# KNOWN ISSUES:
#   1.6.x better performance
#   1.7.x health gauge
#   1.7.0-1.7.5 no music

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_witcher"
PREFIX="TheWitcher_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - The Witcher Enhanced Edition Directors Cut"
SHORTCUT_NAME="The Witcher Enhanced Edition DC"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1065
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "CD Projekt RED" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "66ffe865f34e71ef2beb961748873459" "6d24dcb24f4776889e03715044ca8da0" "3060962cd3ef2ec68a9c02fdeb5ce839" "602a920d5e2c05437f70c5600911aca8" "296605a9b5e7acba6a59cd17b98a84c6" "a820dc0f09afefead9e06a9c37491c1b" "e5261e0eff49b83f48a384ece3050106"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Default interface leaks winprocs and crashes under Wine
POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

# Fix black screen
POL_Call POL_install_d3dx9_36
# Fix large dark polygons, (in rain and more)
POL_Call POL_install_d3dx9_43

################
#      GPU     #
################
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS "128"
  
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx


# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "launcher.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "manual.pdf"
# C:\GOG Games\The Witcher Enhanced Edition Director's Cut\readme.rtf

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg2SigAKCRDlMfrJqhPK
R6RuAJ9SF3Acy2GtBiuxiomwHEww0FxxewCglCA/4Z/Op+7MVqCnW79KBtAgjcs=
=Qrj8
-----END PGP SIGNATURE-----
