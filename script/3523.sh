#!/bin/bash
# Date : (2019-05-23)
# Last revision : (2019-05-23)
# Wine version used : see below
# Distribution used to test : XUbuntu 19.04
# Author : Dadu042 (from the script of Casept)
# PlayOnLinux : 4.5.4
#
# CHANGELOG
# [dadu042] (2019-05-23)
#   Initial script.
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Ruckingenur 2"
PREFIX="Ruckingenur2"
WORKING_WINE_VERSION="2.22"
GAME_URL="http://www.zachtronics.com/ruckingenur-ii/"
PUBLISHER="Zachtronics"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$GAME_URL" "Dadu042" "RuckingenurCE"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$PREFIX"

POL_System_SetArch "x86"

POL_Call POL_Install_dotnet20

POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the setup file to run." "$TITLE"
    POL_SetupWindow_wait  "Please wait while $TITLE is installed." "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://www.zachtronics.com/images/ruckingenur2-installer.exe"
    POL_SetupWindow_wait "Please wait while $TITLE is installed." "$TITLE"
    POL_Wine start /unix "$POL_System_TmpDir/ruckingenur2-installer.exe"
    POL_Wine_WaitExit "$TITLE"
fi
 
POL_System_TmpDelete
POL_Shortcut "RuckingenurTwo.exe" "$TITLE" "Game;LogicGame;"
POL_Shortcut_Document "$TITLE" "readme.txt"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXObgEQAKCRDlMfrJqhPK
R57aAJoCt71u7LkCFmCLKNgDR+C7/3DTOwCglOgCMC1MNb44lH8lucvOFEFkeI8=
=/0HQ
-----END PGP SIGNATURE-----
