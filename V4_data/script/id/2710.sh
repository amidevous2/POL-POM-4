#!/bin/bash
# Date : (2016-17-01 11-13)
# Wine version used : 2.22
# Distribution used to test : OpenSUSE 13.2
# Author : Benjamin Hardy
#
# CHANGELOG
# [Benjamin Hardy] (2016-17-01 11-13)
#   Initial script.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.8 (outdated) -> 2.22 (not tested)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="GOG.com - The Moment Of Silence"
PREFIX="TheMomentOfSilence_gog"
WINEVERSION="2.22"
SHORTCUT_NAME="The Moment Of Silence"
GOGID="the_moment_of_silence"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2710
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "House of Tales / Nordic Games" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "60328af88c5f2c1acf5b054ca2de1087"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_GoG_install

POL_Wine_reboot

POL_Shortcut "mos.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxNmQAKCRDlMfrJqhPK
R/PTAJ4iwRQLCcNA5BTH/bnDLF97wS4D1gCdFsH4rwk3HjGPbRJaGxsXzC5JxI4=
=ZE3D
-----END PGP SIGNATURE-----
