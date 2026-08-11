#!/bin/bash
# Date : (2019-03-28 10-04)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Ubuntu 19.10 amd64
# Script licence : GPL3
# Program licence : Retail
#
# CD-ROM french (v1.0 or v1.1 ?). Latest file: /Setup/data2.cab  16/02/2004.
#
#
# CHANGELOG
# [Dadu042] (2019-08-19)
#   First script.
# [Dadu042] (2019-12-19)
#   Little changes.
# [Dadu042] (2020-02-26)
#   Fix VMS.
#   Wine 4.4 -> 4.21
#
# KNOWN ISSUES:
# - Wine 4.4, 4.21, 5.0, 5.2: Anti copy protection prevent the game to start ('Please insert CD'). Fix: apply a NoCD.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Castle Strike"
PREFIX="castle_strike"
WORKING_WINE_VERSION="4.21"
AUTHOR="Dadu042"
EDITOR="Data Becker"
GAME_URL="https://www.metacritic.com/game/pc/castle-strike"
   
Set_OS "winxp"
 
POL_SetupWindow_Init
POL_Debug_Init
   
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_Call POL_Function_NoCDWarning

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 

# POL_Call POL_Install_d3dx9


POL_SetupWindow_VMS "32"
      
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Do not install "GameSpy Arcade".
 
# In order to avoid: "Error_VGARESOLUTION - entry not found in the string table" when the setup.exe start (Wine 4.4).
POL_Call POL_Function_SetResolution
 
###############
# Go          #
###############
   
POL_SetupWindow_InstallMethod "LOCAL,CD"
   
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Setup/CaSt.ICO"
        POL_Wine start /unix "$CDROM/Setup/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
   
POL_Shortcut "Castlestrike.exe" "$TITLE" "" "" "Game;StrategyGame;"
 
# French file name: Manuel.pdf
POL_Shortcut_Document "$TITLE" "Manuel.pdf"
 
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXlbXvQAKCRDlMfrJqhPK
R0NyAJ9QlKmLbaSAceWa25NczZ5It1077QCgkLdqP94MPY6uJvuFLfkjgPnrJUY=
=xO3/
-----END PGP SIGNATURE-----
