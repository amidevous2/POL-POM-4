#!/bin/bash
# Date : (2016-01-20 21-00)
# Wine version used : 1.8
# Distribution used to test : Xubuntu 15.10 x64
# Author : August Lindberg
# Program licence : Retail
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="GOG.com - Consortium: The Master Edition"
SHORTCUT_NAME="Consortium: The Master Edition"
PREFIX="Consortium_gog"
WORKING_WINE_VERSION="1.8"
GOGID="consortium_the_master_edition"
  
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/consortium/top.jpg" "http://files.playonlinux.com/resources/setups/consortium/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 2642
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Interdimensional Games Inc"\
 "http://interdimensionalgames.com" "August Lindberg" "$PREFIX"
  
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Forcing x86 to make wmp9 work
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# Choose setup file
POL_Call POL_GoG_setup "$GOGID"
 
# Warn for installer errors
POL_SetupWindow_message "$(eval_gettext "The installer will probably throw a\
 few errors during installation. This is nothing to worry about. Just press\
 'OK' when the errors appear and everything should work fine.\n\n\
 Also, be sure to use the default install path and to press 'Exit' instead\
 of 'Launch' when the game has finished installing.")" "$TITLE"
 
# Install game
POL_Call POL_GoG_install
 
## Fix for this game
# Create file to remove Consortiums static FX. Without this fix the screen
# will be black while playing.
GAME_PATH=$(cd "$(dirname "$(find "$WINEPREFIX" -name "consortium.exe")")"; pwd -P)
echo 'r_signal_fx "0"' > "$GAME_PATH"/consortium/cfg/autoexec.cfg
echo 'host_writeconfig' >> "$GAME_PATH"/consortium/cfg/autoexec.cfg
## End fix
 
# Create game shortcut. A launch argument is added that calls the
# file created in the previous step.
POL_Shortcut "consortium.exe" "$SHORTCUT_NAME" "" "+exec autoexec.cfg"
  
# Warn about broken ending
POL_SetupWindow_message "$(eval_gettext "IMPORTANT: The ending scene of the\
 game is broken in wine, and because of this the screen will be black during\
 this scene. For information on how to finish the game, please visit the page\
 for this installer on playonlinux.com or this forum thread:\
 https://steamcommunity.com/app/264240/discussions/0/613956964585243941/.")"\
 "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNXANwAKCRDlMfrJqhPK
R5f5AKCFX0VX8IObXbY7w6dk6CyitCj5cgCgkfNP92YXItTd6IYJjCBNJo6QzKU=
=PFSL
-----END PGP SIGNATURE-----
