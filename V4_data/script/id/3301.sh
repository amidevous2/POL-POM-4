#!/bin/bash
# Date : (2019-06-07)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script: ros_publish_244_publish_1.278513.283332-1c
#                                             ros_publish_358_publish_1.451991.453174 (2020)
#
# Software based on: DirectX 9.
#
# CHANGELOG
# [Dadu042] (2019-06-07 01-35)
#   Initial writting.
# [Dadu042] (2020-06-03 20-00)
#   Wine 4.0.1 -> 5.0
# [Dadu042] (2020-06-10 20-00)
#   Wine 5.0.0 -> 5.0.1
# [Dadu042] (2020-09-11 20-00)
#   Wine 5.0.1 -> 5.0.2
#   Add shortcut to ros_launcher.exe (it freeze 100% of my tries)
#
# KNOWN ISSUES:
#   Wine amd64 5.0, 5.0.1 (2020-09): the embedded web browser does crash when trying to login via Gmail. Workaround: click 'Open browser' quick at the top right of the window. Note: installing Gecko did not help.
#
# KNOWN ISSUES (FIXED):
#   Wine amd64 4.0.1: this script does not allow to pass the login screen !... (as of june 2019).


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Rules of Survival"
PREFIX="rules-of-survival"
EDITOR="NetEase Games"
WORKING_WINE_VERSION="5.0.3"
AUTHOR="Dadu042"
GAME_VMS="512"
GAME_URL="https://en.wikipedia.org/wiki/Rules_of_Survival"
     
POL_SetupWindow_Init
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
    
POL_RequiredVersion 4.3.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
    
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "win7"

#######################################
#  Installing mandatory dependencies  #
#######################################
  
# Required ?: (no as of 2020-09-12).
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43
# POL_Call POL_Install_d3dx10
# POL_Call POL_Install_d3dx11

################
#      GPU     #
################
          
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
           
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
            
# Useful for Nvidia GPUs
POL_Call POL_Install_physx


#######################################
#  Main part of this script           #
#######################################

POL_SetupWindow_InstallMethod "LOCAL"

# POL_SetupWindow_message "IMPORTANT: do finish the installation before to try to play." "$TITLE"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
        cd "$HOME"
        POL_SetupWindow_browse "Please select the .EXE file:" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"

elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
        cd "$POL_System_TmpDir"
        POL_Download "... .exe"
        INSTALLER="$POL_System_TmpDir/setup.exe"
fi
   
POL_Shortcut "ros.exe" "$TITLE" "" "" "Game;Shooter;"
POL_Shortcut "ros_launcher.exe" "$TITLE - Launcher (unreliable)" "" "" "Game;Shooter;"
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX+PAEgAKCRDlMfrJqhPK
RwDfAJ96khCNdODD+fSPd95jALbTsfPJRwCfe61wqjDfEntcFCkEMuBInE6ckUc=
=l7Ok
-----END PGP SIGNATURE-----
