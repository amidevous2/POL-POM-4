#!/bin/bash
# Date : (2019-09-17)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : XUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Edition: local v1.4.
#
# Middlewares used by this software : VC++ 2010, d3dx9.
#
# CHANGELOG
# [Dadu042] (2019-09-17)
#   First script.
#
#
# KNOWN ISSUES:
#  - Wine amd64 4.0.2: the program for the multiplayer and singleplayer have the same names (but different folders). Workaround: create a second shortcun to 'sir.exe'
#
# Ideas to improve this script: select archive, then decide if extension is RAR or ZIP or 7Z...
  
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Sir, You Are Being Hunted"
PREFIX="Sir_Hunted"
EDITOR="Big Robot Ltd"
GAME_URL="https://en.wikipedia.org/wiki/Sir,_You_Are_Being_Hunted"
AUTHOR="Dadu042"
STEAM_ID="242880"
WORKING_WINE_VERSION="5.0.3"
GAME_VMS="256"
SHORTCUT_FILENAME="Sir.exe"
SOFTWARE_CATEGORIES="Game;ActionGame;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
 
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
 
# POL_Call POL_Install_riched30
  
# POL_Call POL_Install_corefonts
 
POL_Call POL_Install_d3dx11
  
# POL_Call POL_Install_mono210
  
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
  
# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "DVD,LOCAL,STEAM"
 
# POL_SetupWindow_message "Note: at the end of the installation, please do not run the game, and do not install DirectX 9." "$TITLE"
 
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
  
elif [ "$INSTALL_METHOD" == "DVD" ]; then
        POL_SetupWindow_cdrom
  
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
 
        # Restore screen resolution (game's default is 800x600)
 #       POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
 
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
  
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
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

# POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"
  
POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid let POL/POM a huge log file, you should type \ninto 'Debug flags' : 'fixme-all'.')" "$TITLE"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYBo/awAKCRDlMfrJqhPK
RzqPAJ9IJCxAkz8NwhPPKFaJG7cWe77dSgCgpLFQvvjuYOQhN9zQeeYAJ8htjGE=
=0aIM
-----END PGP SIGNATURE-----
