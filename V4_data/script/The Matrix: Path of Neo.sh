#!/bin/bash
# Date : (2014-04-04 18:56)
# Last revision : (2014-04-05 11:27)
# Wine version used : 2.22
# Distribution used to test : Arch Linux
# Author : Alexander Borysov
# Script licence : GPLv3
# Program licence: Proprietary
#
# CHANGELOG
# [Alexander Borysov] (2014-04-04)
#   First script.
# [Dadu042] (2019-12-11)
#   Wine 1.7.10-CSMT-a632585 -> 2.22


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Matrix: Path of Neo"
PREFIX="MatrixPathOfNeo"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1991
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Atari" "http://atari.com" "Alexander Borysov" "$PREFIX"
# POL_Call POL_Function_NoCDWarning
POL_Wine_SelectPrefix "$PREFIX"
# POL_SetupWindow_wait "$(eval_gettext "Please wait while the wine prefix is created.")" "$TITLE"
POL_Wine_PrefixCreate "2.22"

POL_SetupWindow_InstallMethod "LOCAL,DVD"

if [ "$INSTALL_METHOD" = "DVD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "PoN.ico"
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

POL_SetupWindow_VMS "128"
POL_Shortcut "Matrix3.exe" "$TITLE" "The Matrix: Path of Neo.png" "" "Game;"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXfFFGQAKCRDlMfrJqhPK
RxwfAJ0WiWdAIXRlhltLohPcnrMHQonTdwCeN56m8SI2t6UNxMm4P81FRnsmwtI=
=bRbc
-----END PGP SIGNATURE-----
