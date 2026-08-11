#!/bin/bash
# Date : (2020-01-07)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : macOS 
# Author : Quentin PARIS
# Licence : Retail
#
# 

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
          
TITLE="Among US"
PREFIX="among_us"
EDITOR=""
AUTHOR="Quentin PARIS"
GAME_VMS="128"

SOFTWARE_CATEGORIES="Game;ActionGame;"
     
# Starting the script
POL_SetupWindow_Init
             
# Starting debugging API
POL_Debug_Init
            
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
       
POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
      
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
            
# Determine Architecture
# POL_System_SetArch "amd64"
POL_System_SetArch "x86"
       
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate
               

POL_SetupWindow_InstallMethod "STEAM"
  
# POL_SetupWindow_message "Warning: do not install DirectX." "$TITLE"
  
# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
      
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
		  
        POL_SetupWindow_message "$(eval_gettext 'Wait until $TITLE is downloaded by Steam. Do not click next before, or the installation will fail')" "$TITLE"
    	
		 
        # Shortcut done before install for steam version
        POL_Shortcut "Among Us.exe" "$TITLE"
fi

  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYAs/LwAKCRDlMfrJqhPK
RwayAJwPwiiUK6Vr/012gLIIu+4QLzAAMgCfbOMb5dFG1cxNc7kgDXgSS5mmG+w=
=V8Tc
-----END PGP SIGNATURE-----
