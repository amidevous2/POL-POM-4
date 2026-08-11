#!/bin/bash
# Date : (2011-08-28 16:38)
# Last revision : N/A
# Wine version used : system
# Distribution used to test : Xubuntu 18.04 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
# CHANGELOG
# Berillions (2011-08-13)
#   First script.
# Dadu042 (2019-08-01)
#   I used the retail DDV .EXE (limbo.exe: november 2011, File Version 1,0,0,1). Steam demo did not install (failure in POL's Steam ?).
#   Upgrade Wine 1.3.0 (2010) -> 3.0.3 (2018), work with success.
#   Remove WORKING_WINE_VERSION in order to use Sytems's Wine version.
#   Remove POL_Install_d3dx9 (not necessary anymore).
# Dadu042 (2019-09-04)
#   Fix icon.
#
# KNOWN ISSUES:
#   Installer window fail to appear (standalone demo file). Occurred with Wine 1.9.24, 2.22, on Xubuntu 18.04 x64 (GPU Intel).
 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="LIMBO"
TITLE_DEMO="LIMBO (Demo)"
PREFIX="limbo"
# WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"
  
# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/limbo/top.jpg" "http://files.playonlinux.com/resources/setups/limbo/left.jpg" "$TITLE"
POL_SetupWindow_Init
  
# Starting debugging API
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Playdead" "http://limbogame.org/" "GNU_Raziel" "$PREFIX"
  
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
# POL_Wine_PrefixCreate
# POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# Choose between Steam and other Digital Download version
POL_SetupWindow_InstallMethod "STEAM_DEMO,STEAM,LOCAL"
  
#Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
        POL_Call POL_Install_steam
fi
 
# Useless since Wine 3.0.3
# POL_Call POL_Install_d3dx9 # Fix "missing d3dx9_43.dll" issue
  
# Mandatory pre-install fix for steam
if [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
        POL_Call POL_Install_steam_flags "48010"
else
        POL_Call POL_Install_steam_flags "48000"
fi
  
# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/48010
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/48000
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi
  
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
  
## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
  
## PlayOnMac Section
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section
  
# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
        rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
        chmod -R 777 "$POL_USER_ROOT/tmp/"
        rm -rf "$POL_USER_ROOT/tmp/*"
fi
  
# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
        POL_Shortcut "Steam.exe" "$TITLE_DEMO" "" "steam://rungameid/48010"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "Steam.exe" "$TITLE_DEMO" "" "steam://rungameid/48000"
else
        POL_Shortcut "limbo.exe" "$TITLE" "" ""
fi
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXXAZpAAKCRDlMfrJqhPK
RyRdAJ9QeCWm/TXO27r5tAsqcxDvfEUuBwCgjb4hpRthCMKPW2zBGlzC8trKaO4=
=PhZS
-----END PGP SIGNATURE-----
