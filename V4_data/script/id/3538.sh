#!/usr/bin/env playonlinux-bash
# Date : (2019-06-05)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script: v1.3 (2009)
# Game plateform used: Multimedia Fusion (v2 or v2.5).
#
# CHANGELOG
# [Dadu042] (2019-06-05 12-56)
#   Initial writting.
# [Dadu042] (2019-11-10 06:05)
#   Wine 3.0.5 -> 3.0.3 (for POL 4.2.12 users).
#   Fix categories.
#
# Known issues:
# - On 4/3 screens, run the Config.exe to set 'Screen mode: Fullscreen 2'.


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Noitu Love 2: Devolution"
PREFIX="noitu-love-2-devolution"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Konjak"
GAME_URL="http://konjak.org"
   
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_RequiredVersion 4.2.12 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
  
Set_OS "win7"

# Useless (because it's a 2D game):
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43
# POL_Call POL_Install_d3dx10
# POL_Call POL_Install_d3dx11
#
# Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
# POL_Call POL_Install_VideoDriver
#
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS
  
###############
# Go          #
###############
 
POL_SetupWindow_InstallMethod "LOCAL,STEAM"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        # POL_Wine start /unix "$SETUP_EXE"
        # POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
 
	# TARGET_DIR="$WINEPREFIX/drive_c/$PREFIX"
	# mkdir -p "$TARGET_DIR"
	# cd "$TARGET_DIR"
  
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
	POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"

elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/207530
        POL_Wine_WaitBefore "$TITLE"

# elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
	#    cd "$WINEPREFIX/drive_c"
	#    POL_Download "http://www.konjak.org/chalk.zip"
	#    unzip chalk.zip
	#    POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
 
fi

if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/207530"
else
	POL_Shortcut "Noitu Love 2 - Devolution.exe" "$TITLE" "" "" "Game;ActionGame;"
	POL_Shortcut "Config.exe" "$TITLE (Config)" "" "" "Game;ActionGame;"
	POL_Shortcut_Document "$TITLE" "Readme.txt"
fi
  
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcea5QAKCRDlMfrJqhPK
RwRoAJwIe3iVnDwkNWT/iT9amy93s8YPQgCfT/R6gZgQjmZSzXFErRNQZGR55Zg=
=AUH4
-----END PGP SIGNATURE-----
