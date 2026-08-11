#!/bin/bash
# Date : (2013-06-08 15-10)
# Last revision : (2015-07-5 year, month, day)
# Wine version used : 1.5.1
# Distribution used to test : Xubuntu 13.04
# Author : Pascal Reinhard dev@ovocean.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="rayman_origins"
PREFIX="RaymanOrigins_gog"
WORKING_WINE_VERSION="1.7.46-staging"

TITLE="GOG.com - Rayman Origins"
SHORTCUT_NAME="Rayman Origins"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1756
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Xodetaetl" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" "1" "8bdf6d75eee8cf930b9c41e43d984314"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Fix: less slowdowns
POL_Wine_Direct3D "Multisampling" "disabled"

POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_xact

POL_Call POL_GoG_install

POL_Shortcut "Rayman Origins.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ArcadeGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Rayman Origins/Support/Manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwxsQAKCRDlMfrJqhPK
R9anAJ4v4NFcR3wq6gP23jv/rYn4yEA0zgCgl3kFekCwlnlo/SbTkTYtlBSxSgo=
=+rYd
-----END PGP SIGNATURE-----
