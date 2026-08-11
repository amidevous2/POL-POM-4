#!/bin/bash
# Date : (2009-05-23 12-14)
# Last revision : (2016-05-08 13:33)
# Wine version used : 1.3.5, 1.3.10, 1.3.23, 1.4, 1.8.2
# Distribution used to test : Debian Testing x64,Mint 17.3
# Author : NSWL & GNU_Raziel,Nicolas HOUDELOT
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [?] (2009-05-23 12-14)
#   Initial script.
# [Nicolas HOUDELOT] (2016-05-08 13:33)
#   Wine 1.4 -> 1.8.2
#   ...
# [Dadu042] (2020-02-14 22:41)
#   Wine 1.8.2 (outdated) -> 2.22
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Bioshock"
PREFIX="bioshock"
EDITOR="2kgames"
GAME_URL="www.bioshockgame.com"
AUTHOR="NSLW & GNU_Raziel"
WORKING_WINE_VERSION="2.22"
GAME_VMS="256"
MD5_DVD_AUTORUN="a04a243b858b18ca4e40d7f12837d573"
MD5_DVD_SETUP="ba30773120175ee6a40c261f9de7fcd3"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/bioshock/top.jpg" "http://files.playonlinux.com/resources/setups/bioshock/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Setup method and md5 detection
if [ "$POL_SELECTED_FILE" ]; then
        SETUP_EXE="$POL_SELECTED_FILE"
        if [ "$POL_SELECTED_MD5" == "$MD5_DVD_AUTORUN" ] || [ "$POL_SELECTED_MD5" == "$MD5_DVD_SETUP" ]; then
                INSTALL_METHOD="DVD"
        fi
else
        # Choose between DVD, Steam and Digital Download version
        POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"
fi
 
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        STEAM_ID="7670"
fi

#Configuration de wine
Set_OS "winxp" #minimum requirement for this game is WinXP
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver
 
# Fix for mouse problem
POL_Wine_X11Drv "GrabFullscreen" "Y"
 
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
        POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi

#Disable DirectX 10 detection
POL_Wine reg.exe ADD "HKEY_CURRENT_USER\Software\Wine\AppDefaults\BioShock.exe\DllOverrides" "/v" "d3d10" "/t" "REG_SZ" "/d" ""
 
# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
        POL_Shortcut "Bioshock.exe" "$TITLE" "" ""
fi
 
# Game protection warning
if [ "$INSTALL_METHOD" == "DVD" ]; then
        POL_SetupWindow_message "$(eval_gettext 'You must disable anti-piracy protections of this game\nif you want to play it with wine')" "$TITLE"
fi
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXkcGiAAKCRDlMfrJqhPK
R8lkAJwPZ/3BLLbbaQNg5XKstjlj56E3TgCfW/T8XBvi2+MvEwbhVTd3BnDl6eM=
=AOxh
-----END PGP SIGNATURE-----
