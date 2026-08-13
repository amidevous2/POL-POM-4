#!/usr/bin/env playonlinux-bash
# Date : (2019-07-12)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : 2010.
#
# Game based on (ie: middlewares): Adobe Shockwave Player.
#
#
# CHANGELOG:
# [Dadu042] (2019-07-12)
#   First script.
#
# KNOWN ISSUES:
 
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
      
TITLE="Samorost 1"
PREFIX="Samorost1"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Amanita Design"
GAME_URL="https://amanita-design.net/"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"

# This web game was not released on CD/DVD nor STEAM.
# POL_SetupWindow_InstallMethod "LOCAL,STEAM,CD"
POL_SetupWindow_InstallMethod "LOCAL"
  
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
        POL_Wine "steam.exe" steam://install/0000
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "pidgen.dll"
        POL_Wine start /unix "$CDROM/install.exe"
        POL_Wine_WaitExit "install.exe"
        cd "$POL_System_TmpDir"
fi
   
   
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/0000"
else
        POL_Shortcut "Samorost.exe" "$TITLE" "" "" "Game;PuzzleGame;"
#        POL_Shortcut_Document "$TITLE" "readme.txt"
fi

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXSmMYAAKCRDlMfrJqhPK
R9L1AKCScONh1qeDrmT89nKpe5PBYCu4MgCgk6NB3ArMSgsBX1SFRqAGkZNcNI8=
=FCdK
-----END PGP SIGNATURE-----
