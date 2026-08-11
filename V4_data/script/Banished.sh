#!/bin/bash
# Date : (2014-07-12 11:00)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : KUbuntu 18.04
# Author : Foz
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED (with succcess): 
#  - v1.0.0 standalone installer + Wine 2.22.
#  - v1.0.0 + patch v1.0.1 (note: still show v1.0.0 in the main menu).
#
#
# CHANGELOG
# Foz (2014-07-12)
#   First script.
# [Dadu042] (2019-07-30 13:02)
#   Wine 1.7.55 -> 2.22.
#   Add support for installing from .RAR or .ZIP files.
#
# KNOWN ISSUES
#  - v1.0.7 Build 170910 (Steam) + Wine 1.7.55, 2.22, 3.0.3, 4.0.1: crash when loading.
#  - v1.0.0 + patch v1.0.4 (BanishedPatch_Any_To_1.0.4.141103.zip) + Wine 2.22: once patched, when game launched a new window appear (buttons: Options, Video Options, Play), game freeze when 'Play' is clicked. Log last line: 'err:seh:setup_exception_record stack overflow'
#  - v1.0.0 + patch v1.0.3 (Banished_1.0.3_Beta_140531) + Wine 2.22, 3.0.3, 4.0.1: after the Loading animation, the screen goes black and only the mouse cursor is show. POL's error window: 'Fatal error in wined3d.dll'.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Banished"
PREFIX="Banished"
EDITOR="Shining Rock Software"
GAME_URL="http://www.shiningrocksoftware.com/"
AUTHOR="Foz"
STEAM_ID="242920"
WORKING_WINE_VERSION="2.22"
GAME_VMS="512"
  
# Starting the script
POL_SetupWindow_Init
  
# Starting debugging API
POL_Debug_Init
 
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Determine Architecture
POL_System_SetArch "x86"
 
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# Installing mandatory dependencies
POL_Call POL_Install_d3dx9
POL_Call POL_Install_xact

# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "STEAM,LOCAL"

# Disable Steam In Game Overlay
POL_Wine_OverrideDLL "" "gameoverlayrenderer" # To disable the DLL
  
# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"


elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
 
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"

if [ "$APP_ANSWER" == ".EXE" ]; then

        # Asking then installing local copy of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        # Making shortcut
        rm "$HOME/Desktop/Banished 32-bit.lnk"

        POL_Shortcut "Banished-x32.exe" "$TITLE (Banished-x32)" "$TITLE.png" ""
        POL_Shortcut "Application-x32.exe" "$TITLE (Application-x32)" "$TITLE.png" ""
        
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
 
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
        
        POL_Shortcut "Application-steam-x32.exe" "$TITLE" "$TITLE.png" ""
        
elif [ "$APP_ANSWER" == "$(eval_gettext '.RAR')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
 
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/"
        
        POL_Shortcut "Application-steam-x32.exe" "$TITLE" "$TITLE.png" ""
fi
fi

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXb4B/QAKCRDlMfrJqhPK
R4IPAJ0fgtNYMdnGc9xlc8TNhBAl1dvchwCgl08PjVfWnKi7/FaBQmWGP3uzjps=
=Bz5h
-----END PGP SIGNATURE-----
