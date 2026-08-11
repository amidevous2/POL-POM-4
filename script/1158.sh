#!/bin/bash
# Date : (2012-05-01 21-26)
# Last revision : 
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-01 21-26)
#   Initial script.
# [Pierre Etchemaite] (2013-05-17 21-01)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="tom_clancys_ghost_recon"
PREFIX="GhostRecon_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Tom Clancy's Ghost Recon"
SHORTCUT_NAME="Tom Clancy's Ghost Recon"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1158
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Red Storm Entertainment / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "3806bd4b410dacaf811c22bd0a77ea6b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "GhostRecon.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Ghost Recon/manual.pdf"
# C:\GOG Games\Ghost Recon\ReadMe.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxJjwAKCRDlMfrJqhPK
R3CqAKCX9+jIMsxehe10vMl8hP6E213SzACfYzhWQQT80yZj6FaftnUVIDZDbNc=
=ZqGP
-----END PGP SIGNATURE-----
