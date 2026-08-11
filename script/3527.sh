#!/usr/bin/env playonlinux-bash
# Date : (2019-05-27 18-20)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script: genetos-v1_00.zip
# Software based on d3dx8
#
# CHANGELOG
# [Dadu042] (2019-05-27 18-20)
#   Initial writting.
#
# Known issues:
# - No music nor sound (and error about '87fc0268-9a55-4360-95aa-004a1d9de26c'). Tried: Alsa, dsound + directmusic. Wine 3.0.3, 3.20, 5.0.2, ...
# - Crash when exit.
  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
      
TITLE="Genetos"
PREFIX="genetos"
WORKING_WINE_VERSION="4.0.4"
AUTHOR="Dadu042"
EDITOR="Tatsuya Koyama"
GAME_URL="http://www.tatsuya-koyama.com/"
   
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
  
Set_OS "winxp"
  
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43
# POL_Call POL_Install_d3dx10
# POL_Call POL_Install_d3dx11
  
# Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
# POL_Call POL_Install_VideoDriver
#
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS

#############################################
#  Sound problem fix - pulseaudio related   #
#############################################
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
  
###############
# Go          #
###############
 
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the ZIP file containing the game.')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/game/"
     
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
    cd "$WINEPREFIX/drive_c"
    POL_Download "http://www.tatsuya-koyama.com/games/genetos-v1_00.zip"
    unzip genetos-v1_00.zip
    POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
 
fi
 
POL_Shortcut "GENETOS.exe" "$TITLE" "" "" "Game;"
    
POL_Shortcut_Document "$TITLE" "GENETOS_manual_eng.html"
  
  
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX6hHzAAKCRDlMfrJqhPK
RzEuAKCIKzd0Y8y66uVesKm+lrZ04xwhoQCfSGpeLkPLzMbpX+8y2gNWbvN68P0=
=tUle
-----END PGP SIGNATURE-----
