#!/bin/bash
# Date : (2013-05-09 18-45)
# Last revision : (2013-05-09 20-45)
# Distribution used to test : Ubuntu 12.10 using Unity and Gnome
# Author : Manuel Vögele
# Script licence : GPLv3

# Installed on Ubuntu 12.10 using Unity and Gnome. Played through the military campaign and some scenarios.
#
# I couldn't get the multiplayer mode to work and there were minor graphical glitches in the mission overview. Apart from that everything worked fine.
#
# I didn't test the map editor and playing custom maps.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
POL_SetupWindow_Init

TITLE="Stronghold"
WORKING_WINE_VERSION="1.4.1"
PREFIX="Stronghold"
CD_FILE_TO_CHECK="disk1/Stronghold.exe"
CD_INSTALL_FILE="disk1/Setup.exe"

POL_SetupWindow_presentation "Stronghold" "Firefly Studios" "http://www.fireflyworlds.com/" "Manuel Vögele" "$TITLE"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "$CD_FILE_TO_CHECK"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Check the disc again since the user could have removed it at this point
POL_SetupWindow_check_cdrom "$CD_FILE_TO_CHECK"
POL_Wine start /unix "$CDROM/$CD_INSTALL_FILE"
POL_Wine_WaitExit

POL_Shortcut "Stronghold.exe" "Stronghold"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGMFCgACgkQ5TH6yaoTykc0aQCfVhQZFRjk2HwVzZF3sFr28tE5
I6kAn3USe1xJ2q32ul16Co6UwWUS290q
=Pxhm
-----END PGP SIGNATURE-----
