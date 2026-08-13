#!/bin/bash
# Date : (2009-05-23 14-30)
# Last revision : (see changelog)
# Wine version used : 2.22
# Distribution used to test : Kubuntu 18.04 x64
# Author : Tr4sK & GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [Tr4sK or GNU_Raziel] (2009)
#   First script.
# [Dadu042] (2019-10-05)
#   Wine 1.7.35 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Grand Theft Auto : San Andreas"
PREFIX="GTA_SA"
WORKING_WINE_VERSION="2.22"
GAME_VMS="256"
 
# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Rockstar Game" "http://www.rockstargames.com/grandtheftauto/" "Tr4sK & GNU_Raziel" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"
 
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
fi
 
# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "12120"
 
# Begin game installation 
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/12120
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
 
# Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
# End Fix
  
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
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/12120"
else
        POL_Shortcut "gta_sa.exe" "$TITLE" "" "" "Game;ActionGame;"
fi
  
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXZ5L7gAKCRDlMfrJqhPK
R689AKCX6IY5xyUwNyBnt0k7xfoHj8c5iwCdHiueY+HiO3FRTC2kJvSBEBpoVdM=
=/ync
-----END PGP SIGNATURE-----
