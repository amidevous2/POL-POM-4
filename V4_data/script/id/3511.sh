#!/usr/bin/env playonlinux-bash
# Date : (2019-05-12 13-44)
# Last revision : (2019-05-12 13-44)
# Wine version used : see below
# Distribution used to test : Ubuntu 19.04
# Author : Dadu042
# Licence : Retail
#
# Media used to write the script: Windows CD-ROM french (files date: september 2011, mistake in the file name: 'bany' instead of 'bang').
# Note: This game exist in native Linux version.
 
[ "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="The tiny bang story"
PREFIX="tiny_bang_story"
WORKING_WINE_VERSION="4.1"
AUTHOR="Dadu042"
EDITOR="PlayFirst"
GAME_URL="https://colibrigames.com/"
  
POL_SetupWindow_Init
POL_Debug_Init
   
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"
 
# Really indispensable ? (Dadu042)
POL_SetupWindow_VMS "64"
 
# Seems useless (with Wine 4.1)
# POL_Call POL_Install_d3dx9
  
POL_SetupWindow_InstallMethod "LOCAL,CD,STEAM"
   
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
          
elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/96000
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "the_Tiny_Bany_Story-1.bin"
        POL_Wine start /unix "$CDROM/the_Tiny_Bany_Story.exe"
        POL_Wine_WaitExit "the_Tiny_Bany_Story.exe"
        cd "$POL_System_TmpDir"
fi
   
   
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/96000"
else
        POL_Shortcut "game.exe" "$TITLE" "" "Game;PuzzleGame;"
fi
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiO0AAKCRDlMfrJqhPK
R2LKAJ4n3PUsOT2vcrYOipfa0yfd3YzOggCgmNQVqzSTLzk88IFZ4zvFRRX5gIk=
=n8EB
-----END PGP SIGNATURE-----
