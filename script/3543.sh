#!/bin/bash
# Date : (2019-06-12 22-02)
# Last revision : (2019-06-12 22-02)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.2.12
#
# Tested : On DVD-ROM the latest files date is october 2012.
#
# Game based on DirectX 9,
#
# KNOWN ISSUES (with Set_OS "vista" and "win7"):
# - Blitzkrieg 2 (+ wine 3.0.3): game does start but does not display (display is 'empty').
# - Blitzkrieg 2 (+ wine 4.0.1): first splash screen is OK but with error message "Failed to initialize Direct3D9."
# - Blitzkrieg 2 (+ wine 4.10): crash when starting.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Blitzkrieg Anthology"
PREFIX="Blitzkrieg_Anthology"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Nival"
GAME_URL="https://pcgamingwiki.com/wiki/Blitzkrieg_Anthology"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "winxp"
 
# Necessary ?:
# POL_Call POL_Install_d3dx9

# Necessary ?:
# POL_Call POL_Install_mfc42
  
###############
# Go          #
###############
    
POL_SetupWindow_InstallMethod "LOCAL,DVD"


if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "BKA_Setup_UK.exe"
        POL_Wine start /unix "$CDROM/BKA_Setup_UK.exe"
        POL_Wine_WaitExit "Setup - Blitzkrieg Anthology"
        cd "$POL_System_TmpDir"
fi
 
POL_Shortcut "Blitzkrieg 1/Run/game.exe" "$TITLE - Blitzkrieg 1" "" "Game;StrategyGame;"
POL_Shortcut_Document "$TITLE - Blitzkrieg 1" "Blitzkrieg 1/Manual.pdf"

POL_Shortcut "Blitzkrieg 1 Burning Horizon - Rolling Thunder/Run/game.exe" "$TITLE - Blitzkrieg 1 Burning Horizon and Rolling Thunder" "" "Game;StrategyGame;"
POL_Shortcut_Document "$TITLE - Blitzkrieg 1 Burning Horizon and Rolling Thunder" "Blitzkrieg 1 Burning Horizon - Rolling Thunder/Blitzkrieg_Burning_Horizon.PDF"

POL_Shortcut "Blitzkrieg 2/bin/Game.exe" "$TITLE - Blitzkrieg 2" "" "Game;StrategyGame;"
POL_Shortcut_Document "$TITLE - Blitzkrieg 2" "Blitzkrieg 2/Manual.pdf"

POL_Shortcut "Blitzkrieg 2 - Fall of the Reich/bin/Game.exe" "$TITLE - Blitzkrieg 2 - Fall of the Reich" "" "Game;StrategyGame;"

POL_Shortcut "Blitzkrieg 2 - Liberation/Bin/Game.exe" "$TITLE - Blitzkrieg 2 - Liberation" "" "Game;StrategyGame;"

#######################################
# Create a 'virtual desktop' (window) #
#######################################
 
POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"
   
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
 
Set_Desktop "On" "$WIDTH" "$HEIGHT"
 
Set_WineWindowTitle "$TITLE"

#######################################
# Setup GPU                           #
####################################### 

# Really necessary ? (Dadu042)
POL_SetupWindow_VMS "64"

POL_Call POL_Install_VideoDriver


POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXQKZiQAKCRDlMfrJqhPK
R4OoAJ0eMVV39f8p5qT+i7vQiloY1M9LoACfVPQufXBed/A9AvjaZxY5XTJSHGw=
=mpuJ
-----END PGP SIGNATURE-----
