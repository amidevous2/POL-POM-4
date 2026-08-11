#!/usr/bin/env playonlinux-bash
# Date : (2019-01-07 23-45)
# Last revision : (2019-01-20 19-56)
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="V-Rally 3"
PREFIX="v-rally3"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Atari"
GAME_URL="https://en.wikipedia.org/wiki/V-Rally_3"

POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
# d3dx9_43

# POL_SetupWindow_InstallMethod "LOCAL,CD,STEAM"
 
POL_SetupWindow_InstallMethod "LOCAL,CD"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
        
elif [ "$INSTALL_METHOD" == "STEAM" ];then
# V Rally 3 on Steam: maybe one day ?  (2018)
# https://steamcommunity.com/app/658700/discussions/0/1698293703765955248/

        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/297920
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Vr3.ICO"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
 
 
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/297920"
else
        POL_Shortcut "VRally3.exe" "$TITLE" "" "Game;RacingGame;"
 
fi
 
# Disable intro videos in order to let the game menu appear (Wine 3.0.3)
mv "$WINEPREFIX/drive_c/Program Files/Atari/VRally3/Euro/Bnk/Video" "$WINEPREFIX/drive_c/Program Files/Atari/VRally3/Euro/Bnk/Video_disabled"
 
#
# Trick from :
# 'Game crashes after title screen' : Remove "Videos" folder from "Euro\Bnk" in game installation directory. They will not play, but they aren't essential.
# https://pcgamingwiki.com/wiki/V-Rally_3#Game_crashes_after_title_screen
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPKqtAAKCRDlMfrJqhPK
R1T7AJ0fSqJCt6YVwbGuw60KJjvtnpYZWACfZJtLNSVVSO+dAOBuUdxUxUO5jFE=
=XIF/
-----END PGP SIGNATURE-----
