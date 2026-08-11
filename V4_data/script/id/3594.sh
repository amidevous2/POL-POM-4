#!/bin/bash
# Date : (2019-08-19)
# Last revision : see Changelog below.
# Wine version used : see Changelog
# Distribution used to test : XUbuntu 18.04
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED (with succcess): FlowScape.exe creation time 2019-01-17 12:40:09. File Version 2017.4.19.4705591 
#
# Middlewares used by this software : Unity, d3d11.
#
# CHANGELOG
# [Dadu042] (2019-08-19)
#   First script.
# [Dadu042] (2019-08-20)
#   Fix: Let app icon's appear in POL.
#   Add link to a eventual doc file.
#
#
# Ideas to improve this script: error window if unrar missing. Select archive, then decide if extension is RAR or ZIP or 7Z...
#
# KNOWN ISSUES:
# - Wine 4.0.1, 4.8: on the main screen, in the center, some parts of the vegetation (ie: leafs) does blink. Tried: install d3d9_43 + compiler.
#   It's related to the trigger 'Shadow distance' (to find in the settings menu, top left of the main screen), when it is to 0, there is no blinking.
#   Occurs on Intel HD Graphics 4400, not a on a Intel HD Graphics 530.
#
# KNOWN ISSUES FIXED:
# - Wine 4.0.1: mouse disapear after doing ALT+TAB. Fix: creating a virtual desktop.
# - Wine 4.0.1: On the first (main) screen, some texts are missing. Fix: install corefonts.
# - Wine 4.0.1: no music/ambient sound -> it's because these are not enabled automatically (main screen : headphone icon).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="FlowScape"
PREFIX="FlowScape"
EDITOR="PixelForest"
GAME_URL="https://pixelforest.itch.io/flowscape"
AUTHOR="Dadu042"
STEAM_ID=""
WORKING_WINE_VERSION="4.0.4"
GAME_VMS="512"
SHORTCUT_FILENAME="FlowScape.exe"
SOFTWARE_CATEGORIES="Amusement;"
   
# Starting the script
POL_SetupWindow_Init
   
# Starting debugging API
POL_Debug_Init
  
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"
 
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Determine Architecture
POL_System_SetArch "amd64"
  
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_corefonts
   
# Installing mandatory dependencies
POL_Call POL_Install_d3dx11

# Useful for Nvidia GPUs
POL_Call POL_Install_physx
  
# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "LOCAL"
   
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
#	POL_Shortcut_Document "$TITLE" "Readme.txt"
         
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
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

#######################################
# Create a 'virtual desktop' (window) #
#######################################
  
# Workaround to fix the "No mouse nor keyboard on main menu":
  
POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1368x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"
    
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
  
Set_Desktop "On" "$WIDTH" "$HEIGHT"
  
Set_WineWindowTitle "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYDiJNQAKCRDlMfrJqhPK
R9dIAJ0Q2d3xQ4cGMkrycqk4itp2dpa7qwCghf8ni2xhjYZchLf5crFjQy9K6SQ=
=0KMg
-----END PGP SIGNATURE-----
