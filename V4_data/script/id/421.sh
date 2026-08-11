#!/bin/bash
# Changelog
#
# [Quentin PARIS] (2011-10-29 19:09) Updated translations,
#   Changed prefix name
#   rm -rf "$POL_USER_ROOT/tmp/*" won't do anything. Removing it
#
# [Dadu042] (2019-05-12) Script did not allow to launch the game once installed (POL 4.3.4 + Wine 1.7.46 and 4.2).
#                        I did updates and rewrote. Tested with retail DVD v1.02 (french).
#
# Date : (2009-06-06 14-00)
# Last revision : (2019-05-13 14:49)
# Wine version used : 1.3.7, 1.3.8, 1.3.23, 1.3.27, 1.3.28, 1.7.46
# Distribution used to test : Debian Testing x64
# Author : NSWL and GNU_Raziel and Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# Game 32 bits, based on DirectX 9 (with Shaders 3.0).

 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Assassin's Creed"
PREFIX="AssassinsCreed"
WORKING_WINE_VERSION="4.1"
AUTHOR="NSLW and GNU_Raziel and Dadu042"
EDITOR="Ubisoft"
GAME_URL="https://pcgamingwiki.com/wiki/Assassin%27s_Creed"

# Minimum video memory size required (game spec on the retail box)
GAME_VMS="256"

# Starting the script
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "vista"
 
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"
 
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
fi

# Fail (2019)
# POL_Call POL_Install_dxfullsetup
 
# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "15100"
 
# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "System/AssassinsCreed_Game.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/15100
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Fix for this game
POL_Wine_Direct3D "DirectDrawRenderer" "opengl"
 
# Set Graphic Card informations keys for wine
POL_Call POL_Install_VideoDriver

# Useless with Wine v3+ ?
# Sound problem fix - pulseaudio related
 [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
 [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
## PlayOnMac Section
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section
 
# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/15100"
else
        POL_Shortcut "AssassinsCreed_Dx9.exe" "$TITLE"

        # This one crash with Wine 3.x and 4.x
        # POL_Shortcut "AssassinsCreed_Launcher.exe" "$TITLE"

        POL_Shortcut_Document "$TITLE" "AssassinsCreed.pdf"
fi

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNnVAgAKCRDlMfrJqhPK
R2HtAKCcOBoGil6fEpW9tqwwwdasF+v1GwCfXZcOpa0IAPwvQB3xlXZHUfG5YzY=
=jCGu
-----END PGP SIGNATURE-----
