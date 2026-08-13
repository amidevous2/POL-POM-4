#!/bin/bash
# Date : (2016-04-17 ??-??)
# Last revision : (2016-04-17 ??-??)
# Wine version used : 1.8.2
# Distribution used to test : Linux Mint 17.3 x64
# Author : plata
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Mirror's Edge (Steam)"
PREFIX="Mirrors_Edge"
WORKING_WINE_VERSION="1.8.2"
EDITOR="DICE"
GAME_URL="http://www.mirrorsedge.com/"
AUTHOR="plata"
  
# start the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
# set prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# download wine if necessary and create prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# make sure that game window shows up
Set_Managed "Off"
  
# install dependencies
POL_Call POL_Install_corefonts
POL_Call POL_Install_d3dx9
POL_Call POL_Install_Physx
POL_Call POL_Install_tahoma
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_steam
  
# begin game installation
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe" steam://install/17410
POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
POL_Wine_WaitExit "$TITLE"
  
# Making shortcut
POL_Shortcut "MirrorsEdge.exe" "$TITLE"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUSDOQAKCRDlMfrJqhPK
RzCfAJ4qw4ZOhf5+3FErdIuvjwIHG+oeBgCgsZpn1hCE+x5HqhEFMr9U16Depaw=
=FRp8
-----END PGP SIGNATURE-----
