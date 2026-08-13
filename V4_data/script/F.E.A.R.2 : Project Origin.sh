#!/bin/bash
# Date : (2019-08-18)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : v1.0.0 (retail, 2x DVDs, western europe)
#
# Game based on (ie: middlewares): .
#
#
# CHANGELOG:
# [Berillions] (2010-08-13)
#   First script.
# [Dadu042] (2019-08-18)
#   Cleanup, french -> english.
#   Wine 1.3.0 -> 2.22
#   Script (using DVD) currently blocks on the stage 'Updating Steam...'.
# [Dadu042] (2019-08-18)
#   Script rewrite. Don't work because Steam update process does fail (stuck, it don't start downloading).
#
# KNOWN ISSUES:
#   - 4.11  "Failed to run install script" (when Steam installation should start), fix: POL_Install_dotnet20



[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
         
TITLE="F.E.A.R.2 : Project Origin"
PREFIX="F.E.A.R.2_PO"
WORKING_WINE_VERSION="4.0.1"
AUTHOR="Dadu042"
EDITOR="Monolith Productions"
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

# steam : 'Fail to run install script'  (wine 4.12.1)
# POL_Call POL_Install_steam_flags
# POL_Call POL_Install_steam
# POL_Call POL_Install_vcrun2008


# Wine 4.11 : setup does crash before steam ! (miss msls?  -> same with)
POL_Call POL_Install_riched30
POL_Call POL_Install_vcrun2008

POL_Call POL_Install_msls31

POL_Call POL_Install_dotnet20
POL_Call POL_Install_vcrun2008

POL_Call POL_Install_d3dx9_43


# useless
# POL_Call POL_Install_wininet
# POL_Call POL_Install_winhttp

 
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
        POL_Wine "steam.exe" steam://install/16450
        POL_Wine_WaitBefore "$TITLE"

elif [ "$INSTALL_METHOD" == "DVD" ];then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Project Origin_disk1.sis"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi
      
      
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/16450"
else         
       POL_Shortcut "steam.exe" "$TITLE Steam" "" "" "Game;Shooter;"
       POL_Shortcut "F.E.A.R.exe" "$TITLE" "" "" "Game;Shooter;"
       POL_Shortcut_Document "$TITLE" "FFOW_Manual.pdf"
fi
  
# GPU selection. Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
POL_Call POL_Install_VideoDriver

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgspfQAKCRDlMfrJqhPK
R0NHAJwN/IXouw5CBMBIyl9bsgxwWxhW7QCfa+fjWkW6OyS8bOxHXCx3UG/zC8E=
=74Vj
-----END PGP SIGNATURE-----
