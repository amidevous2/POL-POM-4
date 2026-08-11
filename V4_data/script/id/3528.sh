#!/usr/bin/env playonlinux-bash
# Date : (2019-05-28)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script: rr0_24.zip
# Software based on: 
#
# CHANGELOG
# [Dadu042] (2019-05-28 09-03)
#   Initial writting.
#
# Known issues:
# - Crash when exit (0009:fixme:wgl:X11DRV_wglChoosePixelFormatARB unused pfAttribFList) Wine 4.0.1

  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
      
TITLE="rRootage"
PREFIX="rRootage"
WORKING_WINE_VERSION="4.0.1"
AUTHOR="Dadu042"
EDITOR="ABA Games"
GAME_URL="http://www.asahi-net.or.jp/~cs8k-cyu/"
   
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
  
Set_OS "win7"
  
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43
# POL_Call POL_Install_d3dx10
# POL_Call POL_Install_d3dx11
  
# Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
# POL_Call POL_Install_VideoDriver
#
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS
  
###############
# Go          #
###############
 
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        # POL_Wine start /unix "$SETUP_EXE"
        # POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
 
    # TARGET_DIR="$WINEPREFIX/drive_c/$PREFIX"
    # mkdir -p "$TARGET_DIR"
    # cd "$TARGET_DIR"
  
    POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
    POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
     
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
    cd "$WINEPREFIX/drive_c"
    POL_Download "http://abagames.sakura.ne.jp/windows/rr0_24.zip"
    unzip rr0_24.zip
    POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
 
fi
 
POL_Shortcut "rr.exe" "$TITLE" ""
    
POL_Shortcut_Document "$TITLE" "README.md"
  
  
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOzgCAAKCRDlMfrJqhPK
R402AJ40/EPWilhZat+fbTDElT6oHEjy5wCfT1GANw0hYGWV7m7q5HsU85JilvE=
=6Ipq
-----END PGP SIGNATURE-----
