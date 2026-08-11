#!/bin/bash
# Date : (2012-05-16 21:00)
# Last revision : (2018-02-08 23:20)
# Wine version used : 1.4-Nostale, 3.0
# Distribution used to test : Linux Mint 12 x64, Ubuntu 18.04 x64
# Author : GNU_Raziel, LinuxScripter
# Licence : Retail
# Only For : http://www.playonlinux.com

## Begin Note ##
# Used patch to fix Bug #15232 - http://bugs.winehq.org/show_bug.cgi?id=15232
## End Note ##

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="NosTale"
PREFIX="nostale"
EDITOR="Gameforge"
GAME_URL="http://www.nostale.com"
AUTHOR="GNU_Raziel and LinuxScripter"
WORKING_WINE_VERSION="3.0"
GAME_VMS="128"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/nostale/top.jpg" "http://files.playonlinux.com/resources/setups/nostale/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Installing mandatory dependencies
POL_Call POL_Install_corefonts

# Begin installation
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Making shortcut
POL_Shortcut "Nostale.exe" "$TITLE" "$TITLE.png" ""

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOU5oAAKCRDlMfrJqhPK
R8UIAJsFg1SIxLoj2b7Pwfg72Dp2hPBQcgCfT/Tx9I7eAvDKutn6N0I/fb+dToA=
=AGsw
-----END PGP SIGNATURE-----
