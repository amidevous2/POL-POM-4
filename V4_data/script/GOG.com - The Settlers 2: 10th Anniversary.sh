#!/bin/bash
# Date : (2013-05-21 22-00)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Fedora 17
# Author : TonyFlow
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [TonyFlow] (2013-05-21 22-00)
#   First script.
# [Dadu042] (2019-12-30)
#   Wine 1.9.4 (1.4.1 a day ago) -> 2.22
#
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="the_settlers_2_10th_anniversary"
PREFIX="SettlersII_10thAnniversary_gog"
WORKING_WINE_VERSION="2.22"
 
TITLE="GOG.com - The Settlers 2: 10th Anniversary"
SHORTCUT_NAME="The Settlers II - 10th Anniversary"
#SHORTCUT_EDITOR="$SHORTCUT_NAME - $(eval_gettext 'Editor')"
SHORTCUT_EDITOR="$SHORTCUT_NAME - Editor"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1703
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Blue Byte / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "TonyFlow" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" "9d460a721ac514126f2cdfa171dc95f2"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install
 
# GoG work!
Set_OS winxp
 
# Install DirectX9
POL_Call POL_Install_d3dx9_29
 
POL_SetupWindow_VMS "64"
 
# Doesn't hurt ;)
POL_Wine_reboot
 
GOGPATH="$GOGROOT/The Settlers II - 10th Anniversary"
POL_Shortcut "S2DNG.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut "S2DNGEditor.exe" "$SHORTCUT_EDITOR" "$SHORTCUT_EDITOR.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGPATH/Manual.pdf"
POL_Shortcut_Document "$SHORTCUT_EDITOR" "$GOGPATH/EditorManual.pdf"
 
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgtOdAAKCRDlMfrJqhPK
RxaLAJ9o0sfWUtA+tEdxgtQclKcffczrAQCgoZy6Sw1XCmBDcdNuEunJvHTAJwE=
=y6DS
-----END PGP SIGNATURE-----
