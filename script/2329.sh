#!/bin/bash
# Date : (2014-04-04 18:56)
# Last revision : x
# Wine version used : x
# Distribution used to test : Ubuntu 14.04
# Author : kibo17
# Script licence : GPLv3
# Program licence: Proprietary

#
# CHANGELOG
# [kibo17] (2014-04-04 18:56)
#   Initial script (Wine 1.7.24-LeagueOfLegendsCSMT ).
# [Dadu042] (2020-03-23 12:30)
#   Wine 2.19-staging (outdated) -> 3.0.3
#

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="The Legend of Korra"
PREFIX="Korra"
 
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Platinum Games" "http://platinumgames.com/games/the-legend-of-korra/" "$PREFIX"
# POL_Call POL_Function_NoCDWarning
POL_Wine_SelectPrefix "$PREFIX"
# POL_SetupWindow_wait "$(eval_gettext "Please wait while the wine prefix is created.")" "$TITLE"
POL_Wine_PrefixCreate "3.0.3"
 
POL_SetupWindow_InstallMethod "LOCAL,DVD"
 
if [ "$INSTALL_METHOD" = "DVD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "icon.ico"
    POL_Wine "$CDROM/setup.exe"
    POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext "Please select the setup file to run.")" "$TITLE"
    POL_Wine "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
fi
 
# fix a bug on Nvidia where the screen becomes bluer and bluer with each bullet fired in slow motion
POL_Wine_DetectCard
[ "$DRVID" = "NVIDIA" ] && POL_Wine_Direct3D "UseGLSL" "disabled"
 
POL_Wine_Direct3D "CSMT" "enabled"
 
POL_SetupWindow_VMS $GAME_VMS
POL_Shortcut "LoK.exe" "$TITLE" "The Legend of Korra.png" "" "Game;"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXn5TzQAKCRDlMfrJqhPK
RxbgAJ4mENo01pcYWG8py5u6ydw8A9siLwCdECNy4Y5uG5ZOlFwMFV48UBBIlEo=
=qOl5
-----END PGP SIGNATURE-----
