#!/bin/bash
# Date : (2019-08-06)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : Early access build v0.4.250 (2015)
#
# Game based on (ie: middlewares): DirectX 9.
#
#
# CHANGELOG:
# [Dadu042] (2019-08-06)
#   First script.
#   To Add ?: .EXE install support
#
# KNOWN ISSUES:
#  - Wine 3.0.3, 4.0.1 : closes after launching because of a 'FATAL ERROR in Vertex Shader compilation'. Fix: install d3dx9.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="All Guns On Deck"
PREFIX="All_Guns_On_Deck"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR=""
GAME_URL=""

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"
  
Set_OS "win7"

# POL_Call POL_Install_corefonts
  
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
else
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
        POL_Wine "steam.exe" steam://install/315330
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom ""
        POL_Wine start /unix "$CDROM/install.exe"
        POL_Wine_WaitExit "install.exe"
        cd "$POL_System_TmpDir"
fi
      
      
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/315330"
else         
        POL_Shortcut "All Guns On Deck.exe" "$TITLE" "" "" "Game;ActionGame;"
#       POL_Shortcut_Document "$TITLE" "readme.txt"
fi


#######################################
# Create a 'virtual desktop' (window) #
#######################################
 
POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"
   
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
 
Set_Desktop "On" "$WIDTH" "$HEIGHT"
 
Set_WineWindowTitle "$TITLE"

#######################################

POL_Call POL_Install_d3dx9_43
POL_Call POL_Install_d3dcompiler_43
  
# GPU selection. Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
# POL_Call POL_Install_VideoDriver

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUirbAAKCRDlMfrJqhPK
R8vEAKCf1X711Ybv8cChjQ4uYkTpvV2uNQCdFIVlWl4vjcPH1EO67xz2l5rH+PI=
=+bHl
-----END PGP SIGNATURE-----
