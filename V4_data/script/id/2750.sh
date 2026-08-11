#!/bin/bash
# Date : (2016-03-04 15:00)
# Last revision : (2016-03-04 15:00)
# Wine version used : 1.2, 1.2.3, 1.3.37, 1.4
# Distribution used to test : Mint 17.3 x64
# Author : clow56
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Monkey Island Special Edition Collection"
PREFIX="MISE_Collection"
EDITOR="Lucasarts"
GAME_URL="http://www.lucasarts.com/games/monkeyisland/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="1.4"
GAME_VMS="256"
 
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/mi_se/top.jpg" "http://files.playonlinux.com/resources/setups/mi_se/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose installer launcher
POL_SetupWindow_InstallMethod "LOCAL"
 
# Installing mandatory dependencies
POL_Call POL_Install_vcrun2005

POL_Call POL_Install_dxfullsetup
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
        rm -rf "$WINEPREFIX/drive_c/windows/temp/"*
        chmod -R 777 "$POL_USER_ROOT/tmp/"
        rm -rf "$POL_USER_ROOT/tmp/"*
fi
 
# Begin game installation
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
  
# Making shortcut

POL_Shortcut "Launcher.exe" "$TITLE" "$TITLE.png" ""
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUSW/AAKCRDlMfrJqhPK
R2P0AKCpFFyFYLODetnO1rCQ5RUizdbXtQCfXa72cXnfjhmrl+upwWyTZGYGv9c=
=Hu2V
-----END PGP SIGNATURE-----
