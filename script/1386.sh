#!/bin/bash
# Date : (2012-09-01 22-32)
# Last revision : (2013-10-26 10-31)
# Wine version used : 
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-09-01 22-32)
#   Initial script.
# [Dadu042] (2020-04-09 19:30)
#   Wine 1.41 (outdated) -> 3.0.3 (not tested).

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="torchlight"
PREFIX="Torchlight_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Torchlight"
SHORTCUT_NAME="Torchlight"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1386
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Runic Games Inc." "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "4b721e1b3da90f170d66f42e60a3fece"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_vcrun2008
# Got one random crash without it...?
# POL_Call POL_Install_d3dx9

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Torchlight.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Torchlight/TorchlightManual.pdf"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXo96hAAKCRDlMfrJqhPK
R8dSAJ9kndqabzEhl/uMwn/Op76ldJ2PrQCgrAPwI6ZQOfiG+ugswrvP4/D58XM=
=EtQJ
-----END PGP SIGNATURE-----
