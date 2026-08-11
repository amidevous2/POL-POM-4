#!/usr/bin/env playonlinux-bash
# Date : (2019-07-13)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : 2019.
#
# Game based on (ie: middlewares): Unity engine.
#
#
# CHANGELOG
# [Dadu042] (2019-07-13)
#   First script.
#
# KNOWN ISSUES (Wine 3.0.3 and 3.0.5)
# - No display (black screen). Sounds are OK and menus too (ie: press Z). Workaround: Wine 4.0.1

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Just Sleep - Meditate, Focus, Relax"
PREFIX="just_sleep_1"
WORKING_WINE_VERSION="4.0.1"
AUTHOR="Dadu042"
EDITOR="Ghulam Jewel"
GAME_URL=""
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"
 
# This software was not released on CD/DVD.
# POL_SetupWindow_InstallMethod "LOCAL,STEAM,CD" 
POL_SetupWindow_InstallMethod "LOCAL,STEAM"
  
if [ "$INSTALL_METHOD" == "LOCAL" ]; then

	POL_SetupWindow_menu "$(eval_gettext 'What is the type of the archive file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
  
if [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"

        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
else
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"

        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/"
fi

elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/1093150
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "pidgen.dll"
        POL_Wine start /unix "$CDROM/install.exe"
        POL_Wine_WaitExit "install.exe"
        cd "$POL_System_TmpDir"
fi
   
   
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/1093150"
else
        POL_Shortcut "Just Sleep.exe" "$TITLE" "" "" "Game;PuzzleGame;"
#        POL_Shortcut_Document "$TITLE" "readme.txt"
fi

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXSmUnQAKCRDlMfrJqhPK
R5qBAJ9ynj8wfQUsff4yllWVseAGw5bnOgCgsWoEf3UPv1EhGXORk4VOnT8Sntg=
=+Arz
-----END PGP SIGNATURE-----
