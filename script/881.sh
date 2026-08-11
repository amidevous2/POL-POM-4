#!/bin/bash
# Date : (2019-08-22)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : XUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED (with success): Local version.
#
# Middlewares used by this software : .
# Game engine used : .
#
# CHANGELOG
# [Dadu042] (2019-08-22)
#   First script.
#
#
# KNOWN ISSUES:
#
#
#
# Ideas to improve this script: ask to select the archive file, then decide what is the file extension (ie: RAR or ZIP or 7Z...).
 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Sanctum"
PREFIX="Sanctum"
EDITOR="ActiVision"
GAME_URL=""
AUTHOR="Dadu042"
STEAM_ID="91600"
WORKING_WINE_VERSION="4.0.4"
GAME_VMS="256"
SHORTCUT_FILENAME="SanctumGame-Win32-Shipping.exe"
SOFTWARE_CATEGORIES="Game;ActionGame;"
    
# Starting the script
POL_SetupWindow_Init
    
# Starting debugging API
POL_Debug_Init
   
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"
  
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
   
# Determine Architecture
POL_System_SetArch "amd64"
   
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
Set_OS "win7"
 
# Fix sound issues
# POL_Call POL_Install_xact
 
 
# POL_Call POL_Install_corefonts
    
# Installing mandatory dependencies
# POL_Call POL_Install_d3dx11
 
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
   
# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "LOCAL,DVD,STEAM"
 
POL_SetupWindow_message "$(eval_gettext 'Note: please do not install DirectX if asked to.')" "$TITLE"
 
 
# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
        
        POL_Call POL_Function_OverrideDLL "" "gameoverlayrenderer"
 
elif [ "$INSTALL_METHOD" == "DVD" ];then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
 
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
        POL_Download "https://www.villagers-and-heroes.com/VHSetup.exe"
        POL_Wine "VHSetup.exe" "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
  
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
 
if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
#        POL_Shortcut_Document "$TITLE" "Readme.txt"
          
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
          
elif [ "$APP_ANSWER" == "$(eval_gettext '.RAR')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
fi
fi

## PlayOnMac Section
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
 
 
POL_SetupWindow_message "$(eval_gettext 'Installation is finished ! :)" "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYka02AAKCRDlMfrJqhPK
R/KfAJwI/iVIxdFRanxwmBRSnqcyIgaCEwCeJ/+Spf7VLmmWbk6W9O5fIpk19es=
=faaQ
-----END PGP SIGNATURE-----
