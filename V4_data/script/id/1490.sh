#!/bin/bash
# Date : (2012-09-01)
# Last revision : 
# Wine version used : 1.4
# Distribution used to test : Linux Mint 12 x32
# Author : Ruzven
# Licence : Retail
#
# CHANGELOG
# [Ruzven] (2012-09-01)
#   Initial script.
# [Dadu042] (2020-01-22 13:30)
#   Wine 1.4 -> 2.22.
#   Improve shortcut

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Unrealtounament3"
PREFIX="Unrealtounament3"
WINEVERSION="2.22"
EDITOR="Midway"
GAME_URL="http://www.unrealtournament.com/"
AUTHOR="Ruzven"
GAME_VMS="256"

# Starting the script
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/....../top.jpg" "http://files.playonlinux.com/resources/setups/....../left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINEVERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam

fi
        POL_Call POL_Install_corefonts
        POL_Call POL_Install_dotnet20
        POL_Call POL_Install_dotnet30

        POL_Wine_Direct3D "UseGLSL" "disabled"
        POL_Wine_Direct3D "OffscreenRenderingMode" "fbo"
        POL_Wine_Direct3D "PixelShaderMode" "enabled"
        POL_Wine_Direct3D "VertexShaderMode" "hardware" 

        POL_Wine_DirectSound "DefaultSampleRate" "44100"
        POL_Wine_DirectSound "EmulDriver" "N"
        POL_Wine_DirectSound "HardwareAcceleration" "Full"
 
# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "SetupUT3.exe"
        POL_Wine start /unix "$CDROM/SetupUT3.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/13210
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi

# Asking about memory size of graphic card
        POL_SetupWindow_VMS $GAME_VMS
 
# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/13210"
fi
if [ "$INSTALL_METHOD" == "DVD" ]; then
        POL_Shortcut "UT3.exe" "$TITLE" "" "" "Game;"
fi


POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjNScwAKCRDlMfrJqhPK
R0EyAJ47Wp17B7+rm3SwXhyAdb1x6tKzjgCcD4+wKi9yBBjMFkYriGe/Fldze2E=
=B3qL
-----END PGP SIGNATURE-----
