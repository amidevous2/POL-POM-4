#!/bin/bash
# Date : (2012-12-6 18:56)
# Last revision : (2013-05-30 01-35)
# Wine version used : 1.4.1, 1.5.5
# Distribution used to test : OpenSuSE 12.2 64-bit
# Author : hmdai (Based on Deponia DC script by Kweepeer)
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [hmdai (Based on Deponia DC script by Kweepeer)] (2012-12-6 18:56)
#   Initial script.
# [?] (2013-05-30 01-35)
#   ?
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_book_of_unwritten_tales_critter_chronicles"
PREFIX="TheBookofUnwrittenTalesCritterChronicles_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - The Book of Unwritten Tales: The Critter Chronicles"
SHORTCUT_NAME="The Book of Unwritten Tales: The Critter Chronicles"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1503
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "King Art/Nordic Games" "http://www.gog.com/gamecard/$GOGID" "hmdai" "$PREFIX"
POL_Call POL_GoG_setup "$GOGID" "e4cfb3634ece936c291ef86d506ecb91"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_d3dx9_43

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "CritterChronicles.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx2ZAAKCRDlMfrJqhPK
R8t0AKCy/g+adq6Jao4HveSfl046B+VF7QCgqLChShhUTVqjHsmYRlVWmQQtjW8=
=nruu
-----END PGP SIGNATURE-----
