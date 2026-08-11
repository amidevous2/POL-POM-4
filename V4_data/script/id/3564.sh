#!/bin/bash
# Date : (2019-07-10)
# Last revision : see Changelog below.
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04
# Author : GNU_Raziel and Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
#
# Medias used and tested: retail CD-ROM 1997, GOG.Com v1.05.
#
#
# CHANGELOG:
# [Dadu042] (2019-07-10)
#   Initial writting. I (Dadu042) used the script (2010-2012) of Worms Reloaded, wrote by GNU_Raziel.
#
#
# KNOWN ISSUE:
# - Game just launch but stop while displaying this window: "Microsoft Visual C++ Runtime L...     Runtime Error!   Program: C:\Team17\Worms2\worms2.exe    abnormal program termination. <OK>". Same issue with the original retail CD (2007) and with the GOG.com release (v1.0.5). Workaround: run frontend.exe instead of worms2.exe.
# - Game has a low resolution (640x480 ?). Workaround?: https://worms2d.info/ReSolution


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Worms 2"
TITLE_DEMO="Worms 2 (Demo)"
PREFIX="worms2"
EDITOR="Team 17"
GAME_URL="https://en.wikipedia.org/wiki/Worms_2"
AUTHOR="GNU_Raziel and Dadu042"
WORKING_WINE_VERSION="4.0.1"  # OK with Wine 2.22 too
GAME_VMS="32"
 
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/wormsreloaded/top.jpg" "http://files.playonlinux.com/resources/setups/wormsreloaded/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "winxp"

# STEAM,STEAM_DEMO: game is not available from, July 2019
# POL_SetupWindow_InstallMethod "CD,STEAM,LOCAL"
POL_SetupWindow_InstallMethod "CD,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then

        POL_Call POL_Install_steam

        # Mandatory settings for steam
        [ "$INSTALL_METHOD" == "STEAM_DEMO" ] && { STEAM_ID="0000"; SHORTCUT_NAME="$TITLE_DEMO"; }
        [ "$INSTALL_METHOD" == "STEAM" ] && { STEAM_ID="0000"; SHORTCUT_NAME="$TITLE"; }
fi

# POL_Call POL_Install_vcrun2005
# POL_Call POL_Install_dxfullsetup
 
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
# POL_Wine_SetVideoDriver

# POL_Call POL_Install_VideoDriver
 
## Fix for this game
# Sound problem fix - pulseaudio related
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Begin installation

if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$TITLE.png" "steam://rungameid/$STEAM_ID"
        POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"

elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
 
        # Shortcut done after install for local version
        POL_Shortcut "frontend.exe" "$TITLE" "$TITLE.png" ""
	POL_Shortcut_Document "$TITLE" "manual.pdf"

elif [ "$INSTALL_METHOD" == "CD" ]; then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Wininet.dll"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"

        # Restore screen resolution (game's default is 640x480)
        POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"

        POL_Shortcut "frontend.exe" "$TITLE" "$TITLE.png" ""
        POL_Shortcut_Document "$TITLE" "manual.pdf"
fi

################
# Patch update #
################
  
POL_SetupWindow_menu "$(eval_gettext 'Install a official patch-update ? (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
  
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXSYnpwAKCRDlMfrJqhPK
R40sAJ0XOBk4CHb/30kSBtWWB1HjaFlO9wCgn62Nvo6AIcGqfOar8yqHrVQQ228=
=gmnO
-----END PGP SIGNATURE-----
