#!/bin/bash
# Date : (2012-05-17)
# Last revision : see changelog
# Wine version used : see script
# Distribution used to test : Linux Mint Debian Edition x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

## Begin Note (2013) ##
# Client may crash every few MB when downloading game, no crash when playing - see Bug #30511 - http://bugs.winehq.org/show_bug.cgi?id=30511
# Used Awesomium patch to fix Bug #27168 - http://bugs.winehq.org/show_bug.cgi?id=27168
## End Note ##
 
# CHANGELOG
# [GNU_Raziel] (2012-05-17)
#    Initial script.
#    Wine version used : 1.5.4, 1.5.9-raw3, 1.5.28-GuildWars2
# [RobLoach] (2015)
#    ...
# [Dadu042] (2019-07-03 16:24)
#    Upgrade 64bits download URL.
# [Dadu042] (2019-11-00)
#    Wine 1.7.35 -> 3.0.3 (because of the little windows install issue)
#    Add POL_RequiredVersion "4.2.12"
# [Dadu042] (2020-07-30)
#    [CHANGE] Wine 3.0.3 (outdated) -> 4.0.4
#    [CHANGE] POL_RequiredVersion "4.3.0"
   

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Guild Wars 2"
PREFIX="GuildWars2"
FILENAME="Gw2.exe"
EDITOR="ArenaNet"
GAME_URL="http://www.guildwars2.com"
AUTHOR="GNU_Raziel"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/gw2/top.jpg" "http://files.playonlinux.com/resources/setups/gw2/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1126
  
# Starting debugging API
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting Wine Version
WORKING_WINE_VERSION="4.0.4"
 
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
  
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Choose a 32-Bit or 64-Bit architecture
POL_SetupWindow_menu_list "$(eval_gettext 'Select architecture')" "$TITLE" "auto~x86~amd64" "~" "auto"
ARCHITECTURE="$APP_ANSWER"
  
# Downloading wine if necessary and creating prefix
POL_System_SetArch "$ARCHITECTURE"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# (Added by Tinou, 2014 ?) Seems to help with random crash issue
Set_OS "win7"
  
# Choose between Downloading client or using local one
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL,CD"
  
# Look if the GPU has the minimum RAM required
POL_SetupWindow_VMS "512"
  
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
  
# Fix for this game
POL_Wine_X11Drv "GrabFullscreen" "Y"
  
# Downloading client or choosing existing one
mkdir -p "$WINEPREFIX/drive_c/$PROGRAMFILES/ArenaNet/Guild Wars 2"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
        # Donwloading client
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/ArenaNet/Guild Wars 2"
        if [ "$ARCHITECTURE" = "amd64" ]; then
                POL_Download "https://s3.amazonaws.com/gw2cdn/client/branches/Gw2Setup-64.exe"
                FILENAME="Gw2Setup-64.exe"
        else
                POL_Download "https://cloudfront.guildwars2.com/client/Gw2.exe"
                FILENAME="Gw2.exe"
        fi
elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
        # Asking for client exe
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cp "$SETUP_EXE" "$WINEPREFIX/drive_c/$PROGRAMFILES/ArenaNet/Guild Wars 2/Gw2.exe"
 
elif [ "$INSTALL_METHOD" = "CD" ]; then
        POL_Call POL_Wine_InstallCDROM "1" "w" "GW2Setup.exe"
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine start /unix "$CDROM/Gw2Setup.exe"
        POL_Call POL_Wine_InstallCDROM "2" "w" "Gw2.js2"
        POL_Wine_WaitExit "$TITLE"
fi
  
# Registry (trick for mouse cursor)
regfile=$(mktemp --suffix=.REG)
echo "REGEDIT4" > "$regfile"
echo "" >> "$regfile"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\DirectInput]" >> "$regfile"
echo '"MouseWarpOverride"="enable"' >> "$regfile"
POL_Wine regedit "$regfile"
  
# Making shortcut
POL_Shortcut "$FILENAME" "$TITLE" "$TITLE.png" "-dx9single -autologin" "Game;RolePlaying;"
  
# Begin installation
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/ArenaNet/Guild Wars 2"
POL_Wine start /unix $FILENAME -repair -image
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXyKoOwAKCRDlMfrJqhPK
RyH8AKCyK+g8kmIS4+A9cJGf781U+qnliwCgkFm6tJJsBm+bnunm1aSyFZeAEwE=
=149+
-----END PGP SIGNATURE-----
