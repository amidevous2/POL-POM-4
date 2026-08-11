#!/bin/bash
# Date : (2012-10-19 13-04)
# Last revision : 
# Wine version used : 
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-10-19 13-04)
#   Initial script.
# [Pierre Etchemaite] (2013-12-12 20-39)
#   Script updated for GOG's installer v2 ?.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested. It's the latest stable allowed by POL v4.2)
 

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="silver"
PREFIX="Silver_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Silver"
SHORTCUT_NAME="Silver"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1439
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Infogrames Europe SA / Atapi" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c6092b0fbc5f6bedd3ca71cb37f9d1a1"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


POL_Call POL_Install_devenum
POL_Call POL_Install_quartz

POL_Wine_DirectInput "MouseWarpOverride" "force"

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "2"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "silver.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Silver/manual.pdf"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCXVwAKCRDlMfrJqhPK
Rw7qAJ0SLdFsArcEPRwGR3ZmNYQsFriS0QCfZXAKvu96hUMoPrP7lbeWadfxPXI=
=DHbJ
-----END PGP SIGNATURE-----
