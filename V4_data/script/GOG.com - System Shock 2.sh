#!/bin/bash
# Date : (2013-03-31)
# Last Revision : (2015-12-21 03-41)
# Wine version used : 1.7.55
# Distribution used to test : Debian Sid (Unstable)
# Author : VisitntX visitntx@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [VisitntX] (2013-09-07)
#   Initial script.
# [Yepoleb] (2015-12-21)
#   Fix crash of GOG installer.
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.7.55 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="system_shock_2"
PREFIX="SystemShock2_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - System Shock 2"
SHORTCUT_NAME="System Shock 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1817
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Irrational Games and Looking Glass / Night Dive Studios" "http://www.gog.com/en/gamecard/$GOGID" "VisitntX" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "d2aeff3075e5b099d353bd4610d9da3d"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# Setting the Windows Version
Set_OS win98

# Cleaning Wine by rebooting
POL_Wine_reboot

POL_Shortcut "Shock2.exe" "$SHORTCUT_NAME" "" "" "Game;RolePlaying;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/System Shock 2/Manual.pdf"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx6hQAKCRDlMfrJqhPK
RzPhAKCnDn+vwe7z+BJYXiOdbAMeYCau2ACeIxmyPfPKFncDyMkGGzj5aOXHMcg=
=MXLU
-----END PGP SIGNATURE-----
