#!/bin/bash
# Date : (2019-08-03)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : v1.0.0 (retail 2x DVDs, western europe)
#
# Game based on (ie: middlewares): .
#
#
# CHANGELOG:
# [Dadu042] (2019-08-14)
#   First script.
# [Dadu042] (2019-08-16)
#   Add Known issues.
#
# KNOWN ISSUES:
# - Wine 4.01, 4.11: DRM does not recognize the original DVD #1 (but is OK with #2).
# - Wine 4.01, 4.11: Once clicked from POL, the game only launch (ie: intro videos) after 3 minutes (CPU used: Intel I3-4130).



[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
         
TITLE="Frontlines: Fuel of War"
PREFIX="Frontlines_FOW"
WORKING_WINE_VERSION="4.0.1"
AUTHOR="Dadu042"
EDITOR=""
GAME_URL=""
    
POL_SetupWindow_Init
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
    
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
    
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"
  
Set_OS "vista"
  
# POL_Call POL_Install_corefonts
  
## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
# End Section ##

# This web game was not released on CD/DVD.
# POL_SetupWindow_InstallMethod "LOCAL,STEAM,CD" 
POL_SetupWindow_InstallMethod "LOCAL,DVD,STEAM"
     
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
        POL_Wine "steam.exe" steam://install/9460
        POL_Wine_WaitBefore "$TITLE"

elif [ "$INSTALL_METHOD" == "DVD" ];then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "dotnetfx.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
      
      
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/9460"
else         
       POL_Shortcut "FFOW.exe" "$TITLE" "" "" "Game;Shooter;"
       POL_Shortcut_Document "$TITLE" "FFOW_Manual.pdf"
fi
  
# GPU selection. Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
POL_Call POL_Install_VideoDriver

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXWASAgAKCRDlMfrJqhPK
R2hJAJ44x5k/sXWAeDrjvKwMiqsZ8/nywACfYrFyS06/dj9m8+roemK+CoCcjYM=
=1X2K
-----END PGP SIGNATURE-----
