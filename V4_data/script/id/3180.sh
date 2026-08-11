#!/bin/bash
# Date : (2017-05-18 2:35)
# Last revision : (2017-11-17 13:19)
# Wine version used : 2.8-staging
# Distribution used to test : Ubuntu 17.04 64bit
# Author : palas
# Script licence : GPLv3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Starcraft"
PREFIX="Starcraft1.18"
EDITOR="Blizzard"
AUTHOR="palas"
GAME_URL="http://eu.blizzard.com/pl-pl/games/sc/"
WORKING_WINE_VERSION="2.8-staging"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_System_TmpCreate "$TITLE"
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"

POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then

cd "$POL_System_TmpDir" 
POL_Download https://www.battle.net/download/getInstallerForGame?os=win&version=LIVE&gameProgram=STARCRAFT
POL_Wine start /unix "$POL_System_TmpDir/StarCraft-Setup.exe"
#POL_Wine_WaitExit "StarCraft-Setup.exe"
 
else
 
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"

fi
 
POL_SetupWindow_message "Please, click next when the installation process has finshed."
 
POL_System_TmpDelete
 
POL_Shortcut "StarCraft.exe" "Starcraft - BroodWar"
POL_Shortcut "StarEdit.exe" "Starcraft Map Editor"
 
POL_SetupWindow_Close
 
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNViFQAKCRDlMfrJqhPK
RzfFAJ99Pdw6SEZ6lRCWiSKT+YifMGVMuACgrTDZrGnROPMeKwTc7lwbcEs1/Dg=
=Blck
-----END PGP SIGNATURE-----
