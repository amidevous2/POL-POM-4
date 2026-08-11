#!/bin/bash
# Date : (2013-09-07)
# Last Revision : (2014-05-18 22:05)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable repositories)
# Author : VisitntX visitntx@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [VisitntX] (2013-09-07)
#   Initial script.
# [Pierre Etchemaite] (2014-05-18 22:05)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="the_chaos_engine"
PREFIX="ChaosEngineRemastered_gog"
WORKING_WINE_VERSION="3.0.3"
 
TITLE="GOG.com - The Chaos Engine Remastered"
SHORTCUT_NAME="The Chaos Engine Remastered"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1822
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Abstraction Games and The Bitmap Brothers / Mastertronic" "http://www.gog.com/en/gamecard/$GOGID" "VisitntX" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" "98e5a165b5ef3bdc9a9e4df23c2a447d"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install
 
# Setting Windows Version 
Set_OS winxp
 
# Cleaning Wine by rebooting 
POL_Wine_reboot
 
POL_Shortcut "The Chaos Engine - Remastered.exe" "$SHORTCUT_NAME" "" "" "Game;ActionGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/The Chaos Engine - Remastered/The Chaos Engine - Manual.pdf"
 
POL_SetupWindow_Close
 
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx0/wAKCRDlMfrJqhPK
R9F/AJ9OQ2JbJJRDeItiuZl/7h4FRgk0DACeLyZ91vplKdB4BOZSYMNh3DFeC8g=
=SCkQ
-----END PGP SIGNATURE-----
