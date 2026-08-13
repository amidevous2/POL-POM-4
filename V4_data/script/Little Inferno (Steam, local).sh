#!/bin/bash
# Date : (2019-08-03)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : v2.0.0.1 (2015) from GOG.com
#
# Game based on (ie: middlewares): .
#
#
# CHANGELOG:
# [Dadu042] (2019-08-03 20:28)
#   First script.
# [Dadu042] (2019-08-14)
#   Littles improvements.
#
# KNOWN ISSUES:
#  - When installing locally (GOG installer): 'Run Error' (x 4), but it seems to install fine.



[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
         
TITLE="Little Inferno"
PREFIX="little_inferno"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR=""
GAME_URL="http://tomorrowcorporation.com/littleinferno"
    
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
  
## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
# End Section ##

# This web game was not released on CD/DVD.
# POL_SetupWindow_InstallMethod "LOCAL,STEAM,CD" 
POL_SetupWindow_InstallMethod "LOCAL,STEAM"
     
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
   
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"

#	POL_SetupWindow_message "We recommend to uncheck all checkboxes (ie: about DirectX, VC++ ..." "$TITLE"

        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"

elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/221260
        POL_Wine_WaitBefore "$TITLE"

elif [ "$INSTALL_METHOD" == "CD" ];then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom ""
        POL_Wine start /unix "$CDROM/install.exe"
        POL_Wine_WaitExit "install.exe"
        cd "$POL_System_TmpDir"
fi
      
      
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/221260"
else         
       POL_Shortcut "Little Inferno.exe" "$TITLE" "" "" "Game;ActionGame;"
       POL_Shortcut_Document "$TITLE" "readme.html"
fi
  
# GPU selection. Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
POL_Call POL_Install_VideoDriver

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXVRFCAAKCRDlMfrJqhPK
R9uZAJ4wiGcqa6WWrmOVzpO7TpiaTNKfjgCfbI4sEExW7tz4CRl/YyFyZftZaJ8=
=IyDk
-----END PGP SIGNATURE-----
