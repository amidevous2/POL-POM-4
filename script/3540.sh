#!/bin/bash
# Date : (2019-06-11 15-02)
# Last revision : (2019-06-11 15-02)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.2.12
#
# Tested : version unknown, latest files date on DVD : dec 2009.
#
# Game based on Flash Player 10 (for the cutscenes) and DirectX 9.
#
# KNOW ISSUES :
# - Cutscenes videos are not displayed.
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Herod's Lost Tomb"
PREFIX="herod-lost-tomb"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Several"
GAME_URL="https://pcgamingwiki.com/wiki/Herod%27s_Lost_Tomb"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
   
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"
  
# Not necessary:
# POL_Call POL_Install_d3dx9
   
###############
# Go          #
###############
     
POL_SetupWindow_InstallMethod "LOCAL,DVD"
 
# Game tested with POL and Flash Player v32 (installed with POL function).
POL_SetupWindow_message "Note: at the end of the installation, DO NOT install the Flash player 10 provided with the game. And do not launch the game automatically." "$TITLE"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "AUTORUN.INI"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
  
POL_Shortcut "herod.exe" "$TITLE" ""
POL_Shortcut_Document "$TITLE" "*.pdf"
 
 
# Not really necessary to play the game
POL_Call POL_Install_flashplayer
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXRJFhgAKCRDlMfrJqhPK
R8wjAKCDJK9w3lnFuOG6svLf5bX4dQSrMwCglUDowKryWLnE1wqbbQN19AmhYE0=
=m6el
-----END PGP SIGNATURE-----
