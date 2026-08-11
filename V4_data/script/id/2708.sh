#!/bin/bash
# Date : (2015-01-09 20-06)
# Wine version used : 1.6.2
# Distribution used to test : OpenSUSE 13.2
# Author : Benjamin Hardy

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="GOG.com - Randal's Monday"
PREFIX="RandalsMonday_gog"
WINEVERSION="1.6.2"
SHORTCUT_NAME="Randal's Monday"
GOGID="randals_monday"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2708
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Nexus Game Studios / Daedalic Entertainment" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "51df0c2be722c8ba4b3d6c97be6a3e51"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_GoG_install

POL_Wine_reboot

POL_Shortcut "Randals.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Randal's Monday/Readme.txt"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlabQC8ACgkQ5TH6yaoTykdRGQCggyjjmjuXn66zxee16vtNtClE
qDYAoJRdfqwE3wfChEjTwz9WMGbLOSx4
=UiyD
-----END PGP SIGNATURE-----
