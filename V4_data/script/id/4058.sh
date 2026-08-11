#!/usr/bin/env playonlinux-bash
# Date : 2020-05-15 20:20 
# Last revision : 2020-05-15 20:39
# Wine version used : 5.0
# Distribution used to test : Pop!_OS 20.04 LTS
# Author : 0verk1ll
# PlayOnLinux : 4.3.4
# Script licence : GPL3
# Program licence : Retail

# CHANGELOG
# [0verk1ll] (2020-05-15 20:20)
#   Initial script.
# [Dadu042] (2020-05-26 18-00)
#   Add POL_RequiredVersion
#   Fix software category.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Where in the World Is Carmen Sandiego? Treasures of Knowledge"
PREFIX="CarmenSandiegoTreasuresOfKnowledge"
 
POL_SetupWindow_Init
PDL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "The Learning Company" "" "0verk1ll" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_SetupWindow_cdrom

SETUPFILE="Setup.exe"

OL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "5.0"
 
POL_Wine --ignore-errors "$CDROM/$SETUPFILE"
POL_Wine_WaitExit 
 
POL_Shortcut "Carmen.exe" "$PREFIX" "" "" "Game;KidsGame;"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXs1s8QAKCRDlMfrJqhPK
R3a4AJ98gCbT+TkswoowsNl8jHS3lhoangCaAmxdJ+Cbcc/rq1PArZ8wIJVCDwk=
=qFh3
-----END PGP SIGNATURE-----
