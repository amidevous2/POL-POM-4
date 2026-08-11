#!/bin/bash
# Date : (2019-09-11)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64 (Linux kernel v5.4)
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script:
#        - LifeAfter_20200410.zip
#
# Software based on: DirectX 9 (v43) only ? -> for lifeafter_t.exe
#                    OpenGL only ?          -> for lifeafter_bw.exe
#
#
#
# CHANGELOG
# [Dadu042] (2019-09-11 16-00)
#   Initial writting.
#
# KNOWN ISSUES:
#   Wine amd64 5.0.2: after upgrading (from LifeAfter_20200410.zip'), the game (launcher) does not runanymore. Workaround: run lifeafter_bw.exe
#
#
# KNOWN ISSUES (FIXED):
 
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="LifeAfter"
PREFIX="LifeAfter"
EDITOR="NetEase Games"
WORKING_WINE_VERSION="6.0.1"
AUTHOR="Dadu042"
GAME_VMS="512"
GAME_URL="http://www.lifeafter.game/"
      
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
     
POL_RequiredVersion 4.3.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
     
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
# POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"
 
#######################################
#  Installing mandatory dependencies  #
#######################################

# Requiered to display the user licence agreement (game: LifeAfter)
# POL_Call POL_Install_corefonts

# POL_Call POL_Install_d3dx9
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
POL_Call POL_Install_physx
 
 
#######################################
#  Main part of this script           #
#######################################

# POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD" 
POL_SetupWindow_InstallMethod "LOCAL"
 
POL_SetupWindow_message "IMPORTANT: Do finish the installation before to try to play." "$TITLE"
 
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
        POL_Download ""
        INSTALLER="$POL_System_TmpDir/setup.exe"
fi
    
POL_Shortcut "lifeafter.exe" "$TITLE (Launcher)" "" "" "Game;Shooter;"
POL_Shortcut "lifeafter_t.exe" "$TITLE (lifeafter_t.exe)" "" "" "Game;Shooter;"
POL_Shortcut "lifeafter_bw.exe" "$TITLE (lifeafter_bw.exe)" "" "" "Game;Shooter;"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to get a huge log file, you should type \ninto Debug flags: fixme-all')" "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYkQfCgAKCRDlMfrJqhPK
R7dNAKCnneu1JGRKLJlR6isdIJ6KWjLhxACfZJ4P4TFPWconSqqPeI8OdG77plY=
=QfpW
-----END PGP SIGNATURE-----
