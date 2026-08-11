#!/bin/bash
# Date : (2019-09-26)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : KUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED EDITION: DDV 2019, june 2019.
#
# Middlewares used by this software : DirectX 11, vcrun2015.
#
# CHANGELOG
# [Dadu042] (2019-09-26)
#   First script.
#
#
# KNOWN ISSUES:
#  - Wine amd64 4.0.2, 4.8, 4.15: noise is crackling (OS Kubuntu 18.04. Note: did not occured on Xubuntu 19.04). Workaround: Wine 4.8-staging.
#  - Wine amd64 4.0.2, 4.8, 4.15: black screen and a error window if DirectX 11 is not detected. Tried: POL_Install_d3dx11, iGPU/Nvidia GPU. OS: Xubuntu 19.04 x64. Fix?: set Intel GPU as default in the BIOS.
#
# Idea to improve this script: select archive, then detect if the file extension is RAR or ZIP or 7Z...
 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Journey"
PREFIX="Journey"
EDITOR="Annapurna Interactive"
GAME_URL="https://en.wikipedia.org/wiki/Journey_(2012_video_game)"
AUTHOR="Dadu042"
STEAM_ID=""
WORKING_WINE_VERSION="4.8-staging"
GAME_VMS="256"
SHORTCUT_FILENAME="Journey.exe"
SOFTWARE_CATEGORIES="Game;AdventureGame;"
 
# Starting the script
POL_SetupWindow_Init
    
# Starting debugging API
POL_Debug_Init
   
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"
 
# POL_SetupWindow_message "$(eval_gettext 'This game requires a fast 3D GPU (ie: Intel HD Graphics 4440 is not enough).')" "$TITLE"
  
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
   
# Determine Architecture
POL_System_SetArch "amd64"
   
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
Set_OS "win7"
 
    
# Installing mandatory dependencies

POL_Call POL_Install_corefonts

# POL_Call POL_Install_d3dx11

# Not sure if this function reliable (as of 2019-09) and the game seems to run without.
# POL_Call POL_Install_vcrun2015
 
# POL_Call POL_Install_mono210
 
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
 
# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "DVD,LOCAL"
 
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
  
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"
 
POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a big useless POL/POM log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"
 
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXYymewAKCRDlMfrJqhPK
R3OdAJ0VxQlGaJlN4pIk5I/YkLZunkfwsQCcDB1hSAlpFwfnpPGhu0nflvMkfao=
=GS2y
-----END PGP SIGNATURE-----
