#!/bin/bash
# Version : 1.0
# Last revision date : 2013-06-02
# Wine version used : 1.4 (work also with 1.0)
# Distribution used to test : Kubuntu 13.04
# Author : iotaka

# CHANGELOG
# [SuperPlumux] (2013-06-17 18-37)
#   gettext
#   clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="BLAZE - mechforces"
PREFIX="BLAZEmechforces"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"


POL_SetupWindow_Init
POL_SetupWindow_SetID 1731
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "iotaca team" "http://blaze.iotaca.net/" "iotaka" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://blaze.iotaca.net/download/BLAZE-mechforces.exe"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$POL_System_TmpDir/BLAZE-mechforces.exe"
fi

POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete

POL_Shortcut "Blaze.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlG/POUACgkQ5TH6yaoTykeXlwCcCvaUWcHSyr/5ZpDcGKRVhEUS
bh8An3xQnf+u44l8Gsqht8r+nA9gajB7
=tqKv
-----END PGP SIGNATURE-----
