#!/bin/bash
# Date : (2019-09-08)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64 (Linux kernel v5.4)
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script:
#        - 'cyber_hunter_global_20200616.exe' (4 GB) + a 800 MB update autodownloaded. Version.txt: 1.201768.201136.201768
#
# Software based on: DirectX 9 (v43), vcrun2010.
#
# CHANGELOG
# [Dadu042] (2019-09-08 09-00)
#   Initial writting.
#
# KNOWN ISSUES:
#   Wine amd64 5.0.2, 4.0.4, 4.21: game (launcher.exe) fail to launch (nothing happens). Tried: bin/client.exe (same issue), d3dx9_43 + compiler, d3dx9, directx9, DXVK_171, d3dcompiler_46, d3dcompiler_47.
#   Wine amd64 5.12, 5.16, 5.17: game (launcher.exe) fail to launch (crash window, clicking the button Details does only close the window). Tried: bin/client.exe (same issue).
#
#   Same 'fail to launch' issue in 32 bits mode.
#
# KNOWN ISSUES (FIXED):
 
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Cyber Hunter"
PREFIX="CyberHunter"
EDITOR="NetEase Games"
WORKING_WINE_VERSION="6.0"
AUTHOR="Dadu042"
GAME_VMS="512"
GAME_URL="https://en.wikipedia.org/wiki/Cyber_Hunter"
      
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
     
POL_RequiredVersion 4.3.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
     
POL_Wine_SelectPrefix "$PREFIX"
# POL_System_SetArch "auto"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"
 
#######################################
#  Installing mandatory dependencies  #
#######################################

# TO try: set language english ?

POL_Call POL_Install_d3dx9

# POL_Call POL_Install_vcrun2010
# POL_Call POL_Install_wininet

################
#      GPU     #
################
           
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
            
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
             
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
 
 
#######################################
#  Main part of this script           #
#######################################
 
POL_SetupWindow_InstallMethod "LOCAL"
 
# POL_SetupWindow_message "IMPORTANT: End the installation before to try to play." "$TITLE"
 
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
        POL_Download "https://g94na.gdl.netease.com/cyber_hunter_global_20200616.exe"
        INSTALLER="$POL_System_TmpDir/setup.exe"
fi
    
POL_Shortcut "launcher.exe" "$TITLE" "" "" "Game;Shooter;"
# POL_Shortcut_Document "$TITLE" "readme.txt"

POL_Shortcut "bin\client.exe" "$TITLE - Bin\Client" "" "" "Game;Shooter;"
  
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYAVZXgAKCRDlMfrJqhPK
R7acAJ9zVCsrpHoU+cRrJaFDmtioq77CaQCeNBuJzeDLmhDla9mWXcrOBEg098A=
=mAR9
-----END PGP SIGNATURE-----
