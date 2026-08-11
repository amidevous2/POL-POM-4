#!/bin/bash
# Date : (2019-08-03)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : v1.3 (2019-07-10 Steam)
#
# Game based on (ie: middlewares): DirectX 9 v47, OpenAL, Visual C++ 2010.
# 
#
# CHANGELOG:
# [Dadu042] (2019-08-03 22:47)
#   First script.
# [Dadu042] (2019-08-23)
#  deadcells.exe -> deadcells_gl.exe (OpenGL)
#
#
# KNOWN ISSUES:
#   Wine 3.0.3: lots of entries in the log file ('0009:fixme:dxgi:dxgi_swapchain_Present Unimplemented sync interval 1'). Fix: write '-fixme' in 'Debug flags'.


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
         
TITLE="Dead Cells"
PREFIX="Dead_Cells"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Motion Twin"
GAME_URL="https://motion-twin.com/"
    
POL_SetupWindow_Init
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
    
POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
    
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"
  
Set_OS "win7"
  
# POL_Call POL_Install_corefonts
  
# This web game was not released on CD/DVD.
# POL_SetupWindow_InstallMethod "LOCAL,STEAM,CD" 
POL_SetupWindow_InstallMethod "LOCAL,STEAM"
     
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the archive file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
     
if [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
   
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
elif [ "$APP_ANSWER" == "$(eval_gettext '.RAR')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
   
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/"
fi
   
elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/588650
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom ""
        POL_Wine start /unix "$CDROM/install.exe"
        POL_Wine_WaitExit "install.exe"
        cd "$POL_System_TmpDir"
fi
      
      
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/588650"
else         
        POL_Shortcut "deadcells_gl.exe" "$TITLE" "" "" "Game;ActionGame;"
#       POL_Shortcut_Document "$TITLE" "PatchNotes.txt"
fi
  
# GPU selection. Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
POL_Call POL_Install_VideoDriver

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXWAYPQAKCRDlMfrJqhPK
Rwj4AJ0Slffv4oVXVxm4PqQSI/P1Cz37mwCbB0tt3b/gzKqAkjOWKAkUXvU0NyQ=
=sgP9
-----END PGP SIGNATURE-----
