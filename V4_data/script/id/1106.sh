#!/bin/bash
# Date : (2012-03-25 21:00)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 16.04 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG:
# [GNU_Raziel] (2012-03-25 21:00)
#   First script.
# [?] (2016-03-01 16:14)
#   ?
# [Dadu042] (2019-12-23 20:55)
#   Wine 1.9.4 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Rayman Origins"
TITLE_DEMO="Rayman Origins (Demo)"
PREFIX="RaymanOrigins"
EDITOR="Ubisoft"
GAME_URL="http://raymanorigins.uk.ubi.com"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="3.0.3"
 
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/RaymanOrigins/top.jpg" "http://files.playonlinux.com/resources/setups/RaymanOrigins/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "STEAM_DEMO,DVD,STEAM,LOCAL"
 
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
        POL_Call POL_Install_steam
fi
POL_Call POL_Install_dxfullsetup
 
# Mandatory settings for Digital version
[ "$INSTALL_METHOD" == "STEAM_DEMO" ] && { STEAM_ID="207510"; SHORTCUT_NAME="$TITLE_DEMO"; }
[ "$INSTALL_METHOD" == "STEAM" ] && { STEAM_ID="207490"; SHORTCUT_NAME="$TITLE"; }
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
## Fix for this game
POL_Wine_Direct3D "Multisampling" "disabled" # less slowdowns
 
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##
 
# Begin installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Rayman.ico"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM_DEMO" ] || [ "$INSTALL_METHOD" == "STEAM" ]; then
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$TITLE.png" "steam://rungameid/$STEAM_ID"
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
 
# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM_DEMO" ] && [ "$INSTALL_METHOD" != "STEAM" ]; then
        POL_Shortcut "Rayman Origins.exe" "$TITLE" "$TITLE.png" "" "Game;"
fi
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgI8MwAKCRDlMfrJqhPK
R1/vAJ9CILpkuwH2cokLQQ62vO7jjtYo6wCdFPvFBlbb4EeoNYVVkxMglxJoyeM=
=/i9u
-----END PGP SIGNATURE-----
