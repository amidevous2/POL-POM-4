#!/bin/bash
# Date : (2019-09-16)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64 (Linux kernel v5.4)
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script:
#        - .exe (2020-09-16): not tested because not downlodable anymore.
#        - CrusasersOfLight_release_v2.zip (2020-11-12).
#
# Software based on: DirectX 9 v43.
#
#
#
# CHANGELOG
# [Dadu042] (2019-09-16 14-00)
#   Initial writting.  Currently the download link for PC it break.
# [Dadu042] (2020-11-12 16-00)
#   Change install process (.EXE -> .ZIP).
#
# KNOWN ISSUES:
#   Wine amd64 5.0.2: A part of the 3D world is black (the ground). Fix: d3dx9_43 + compiler.
#
#
# KNOWN ISSUES (FIXED):
  
  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="Crusaders of Light"
PREFIX="Crusaders_of_Light"
EDITOR="NetEase Games"
WORKING_WINE_VERSION="6.0.1"
AUTHOR="Dadu042"
GAME_VMS="512"
GAME_URL="https://www.pcgamingwiki.com/wiki/Crusaders_of_Light"
       
POL_SetupWindow_Init
POL_Debug_Init
      
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
      
POL_RequiredVersion 4.3.0 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
      
POL_Wine_SelectPrefix "$PREFIX"
# POL_System_SetArch "auto"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
  
Set_OS "win7"
  
#######################################
#  Installing mandatory dependencies  #
#######################################
 
POL_Call POL_Install_d3dx9_43
POL_Call POL_Install_d3dcompiler_43
 
################
#      GPU     #
################
            
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS
             
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
              
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
  
  
#######################################
#  Main part of this script           #
#######################################
 
POL_SetupWindow_InstallMethod "LOCAL"
# POL_SetupWindow_InstallMethod "LOCAL"
  
# POL_SetupWindow_message "IMPORTANT: Do finish the installation before to try to play." "$TITLE"
  
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
        cd "$HOME"
        # POL_SetupWindow_message "$(eval_gettext '\n\nWARNING: the file name must not have SPACES in its name !.')" "$TITLE"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
            
#        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
          
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
        cd "$POL_System_TmpDir"
        POL_Download "https://static.gc.my.games/RevelationOnlineLoader_en.exe"
#        INSTALLER="$POL_System_TmpDir/RevelationOnlineLoader_en.exe"
        POL_Wine start /unix "RevelationOnlineLoader_en.exe"
        POL_Wine_WaitExit "$TITLE"
fi
     
POL_Shortcut "col.exe" "$TITLE" "" "" "Game;RolePlaying;"
# POL_Shortcut_Document "$TITLE" "$DOCUMENT_FILE"


# POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to get a huge log file, you should type \ninto Debug flags: fixme-all')" "$TITLE"
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYjX5GwAKCRDlMfrJqhPK
R7fdAJ46wQTOCfsOAXlMaOsZKnoapOx+fwCfUiuJsHNclisbuZH6lE47j/lO5+Q=
=lq+v
-----END PGP SIGNATURE-----
