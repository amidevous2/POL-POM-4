#!/bin/bash
# Date : (2012-01-04 21-13)
# Last revision : 
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-01-04 21-13)
#   Initial script, for the GOG release.
# [Pierre Etchemaite] (2013-05-20 12-48)
#   Gog v2.
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.4.1 -> 3.0.3
#   Force Arch x86.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="giants_citizen_kabuto"
PREFIX="CitizenKabuto_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Giants: Citizen Kabuto"
SHORTCUT_NAME="Giants: Citizen Kabuto"
SHORTCUT_SERVER="$SHORTCUT_NAME - $(eval_gettext 'Dedicated Server Editor')"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1061
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Planet Moon Studios / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "3b45e431472dc7a91d9cc1ab8b149246" "b34907a93089d396d6ccfe55037cba3d"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Giants.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Giants - Citizen Kabuto/MANUAL.PDF"
# C:\GOG Games\Giants - Citizen Kabuto\ReadMe.txt
# C:\GOG Games\Giants - Citizen Kabuto\dedicated.exe
# C:\GOG Games\Giants - Citizen Kabuto\readme_dedicated.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwpagAKCRDlMfrJqhPK
RxKKAJ9o9R1RgUsr+aSYqoHuko8KoHoP4ACfREsRxk3i63PbY4PBkL/0rnDnMXA=
=Bgz8
-----END PGP SIGNATURE-----
