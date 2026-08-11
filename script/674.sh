#!/bin/bash
# Date : (2010-08-15 21:00)
# Last revision : see changelog
# Wine version used : 1.2, 1.2.3, 1.3.37, 1.4
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [GNU_Raziel] (2010-08-15 21:00)
#   Initial script.
# [?] (2012-05-04 21:00)
#   ?
# [Augier] (2020-07-09 16-00)
#   Disable Alsa audio (because it makes crackling noises), and add Xaudio
# [Dadu042] (2020-07-09 16-00)
#   Add changelog.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Monkey Island 2 : LeChuck's Revenge Special Edition"
PREFIX="MI2_SE"
EDITOR="Lucasarts"
GAME_URL="http://www.lucasarts.com/games/monkeyisland/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="3.20"
GAME_VMS="256"
 
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/mi2_se/top.jpg" "http://files.playonlinux.com/resources/setups/mi2_se/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between Steam and other Digital Download version
POL_SetupWindow_InstallMethod "STEAM,LOCAL"
 
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        STEAM_ID="32460"
fi
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_dxfullsetup
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Add required XAudio2_6 DLL
POL_Wine_OverrideDLL "native,builtin" "xaudio2_6"
 
# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
        rm -rf "$WINEPREFIX/drive_c/windows/temp/"*
        chmod -R 777 "$POL_USER_ROOT/tmp/"
        rm -rf "$POL_USER_ROOT/tmp/"*
fi
 
# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
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
 
# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
        POL_Shortcut "Monkey2.exe" "$TITLE" "$TITLE.png" ""
fi
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXwd06QAKCRDlMfrJqhPK
Ryc0AJwOLuIo5YE8vxqecP2tvmrEVD1tjgCfTbrOq4btHsxVs4eQjDAjv+o1sSg=
=LlDN
-----END PGP SIGNATURE-----
