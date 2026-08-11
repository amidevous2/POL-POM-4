#!/bin/bash
# Date : (2019-08-12)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : KUbuntu 18.04
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED (with succcess): 
#
# Game based on : Mono, Unity.
#
# CHANGELOG
# [Dadu042] (2019-08-12)
#   First script.
# [Dadu042] (2019-08-22)
#   Fix icon for POL.
#
# KNOWN ISSUES


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="BonVoyage!"
PREFIX="BonVoyage"
EDITOR="Boris Zapotocky"
GAME_URL=""
AUTHOR="Dadu042"
STEAM_ID="1081890"
WORKING_WINE_VERSION="4.0.4"
GAME_VMS="512"
  
# Starting the script
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init
 
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Determine Architecture
POL_System_SetArch "amd64"
 
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# Installing mandatory dependencies
# POL_Call POL_Install_d3dx11
# POL_Call POL_Install_physx

# POL_Call POL_Install_xact

# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "LOCAL,STEAM"

# Disable Steam In Game Overlay
# POL_Wine_OverrideDLL "" "gameoverlayrenderer" # To disable the DLL
  
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
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine "VHSetup.exe" "/SILENT"
        
        POL_Shortcut "BonVoyage!.exe" "$TITLE" "" "" "Game;LogicGame"

elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
 
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"

if [ "$APP_ANSWER" == ".EXE" ]; then

        # Asking then installing local copy of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"

        POL_Shortcut "BonVoyage!.exe" "$TITLE" "" "" "Game;LogicGame"
        
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
 
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
        
        POL_Shortcut "BonVoyage!.exe" "$TITLE" "" "" "Game;LogicGame"
        
elif [ "$APP_ANSWER" == "$(eval_gettext '.RAR')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
 
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/"
        
        POL_Shortcut "BonVoyage!.exe" "$TITLE" "" "" "Game;LogicGame"
fi
fi

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZYXUGQAKCRDlMfrJqhPK
R8mwAJ4wGveUSuW9sJLvsGSoORcVlxBSCACdHkEOFeDfWe7aoyzfhJ26TSOktSk=
=esEm
-----END PGP SIGNATURE-----
