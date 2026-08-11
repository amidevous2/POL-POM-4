#!/usr/bin/env playonlinux-bash
# Date : (2019-05-30)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script: 
# Software based on: Multimedia Fusion (Clickteam).
#
# CHANGELOG
# [Dadu042] (2019-05-30 11-23)
#   Initial writting.
# [Dadu042] (2020-01-02)
#   Wine 4.0.1 -> 3.0.3 (for POL v4.2.x users)
#   POL_Function_SetResolution seems useless.
#
# Known issues:
# - Window size is very small: game seems to not support resolutions over 320x200 pixels.
   
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
       
TITLE="Alex Adventure"
PREFIX="Alex_Adventure"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Alexandre Szybiak"
GAME_URL="https://alexandreszybiak.itch.io/alexs-adventure"
    
POL_SetupWindow_Init
POL_Debug_Init
   
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
   
POL_RequiredVersion 4.2.12 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
   
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
   
###############
# Go          #
###############
  
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
  
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the ZIP game file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        # POL_Wine "$SETUP_EXE" 
        # POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing...')" "$TITLE"
        ## POL_Wine start /unix "$SETUP_EXE"
        ## POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
      
    # TARGET_DIR="$WINEPREFIX/drive_c/$PREFIX"
    # mkdir -p "$TARGET_DIR"
    # cd "$TARGET_DIR"
   
    POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
    POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/alex/"
 
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
    cd "$WINEPREFIX/drive_c"
    POL_Download "http://tomvert.free.fr/Alex-Adventure.zip"
    POL_System_unzip "Alex-Adventure.zip" -d "$WINEPREFIX/drive_c/alex/"
    POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
#         POL_Wine "$SETUP_EXE" 
#        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing...')" "$TITLE"
 
fi
 
POL_Shortcut "alexsadventure.exe" "$TITLE" "" "" "Game;ActionGame;"
     
# POL_Shortcut_Document "$TITLE" "README.md"
 
# To avoid wrong screen resolutions (ie: on 1280x1024)
POL_Call POL_Function_SetResolution
   
   
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg3bXQAKCRDlMfrJqhPK
R08XAJwOw5sMJ6bmh4/U740PG09xYvq/lgCfcz/8/tpsXu9QkRj0wFzVSa+cf9E=
=GIjT
-----END PGP SIGNATURE-----
