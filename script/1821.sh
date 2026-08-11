#!/bin/bash
# Date : (2013-09-07)
# Last Revision : (2013-12-24 11:31)
# Wine version used : 1.4.1
# Distribution used to test : Debian Jessie (Testing repositories)
# Author : VisitntX visitntx@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [VisitntX] (2013-09-07)
#   First script
# [Dadu042] (2020-01-01)
#   Wine 1.4.1 (outdated) -> 2.22.
#

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="clive_barkers_undying"
PREFIX="CliveBarkersUndying_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Clive Barker's Undying"
SHORTCUT_NAME="Clive Barker's Undying"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Dreamworks Interective / Electronic Arts" "http://www.gog.com/en/gamecard/$GOGID" "VisitntX" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "70531606d4aa51d20d628f6af50cb38c"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# Setting Windows Version
Set_OS winxp

# Cleaning Wine by rebooting
POL_Wine_reboot

POL_Shortcut "Undying.exe" "$SHORTCUT_NAME" "" "" "Game;ActionGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Clive Barker's Undying/Clive Barkers Undying - Manual.pdf"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg2eagAKCRDlMfrJqhPK
R15uAJ9v4nDLGED1Uttpew6sl7nRtfZ12ACfYyb4X4A7/P5ljsqAckfo7nvuAuE=
=gF1W
-----END PGP SIGNATURE-----
