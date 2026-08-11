#!/bin/bash
# Date : (2012-17-02 21-00)
# Last revision : (2013-05-19 13-06)
# Wine version used : 1.5.21
# Distribution used to test : Debian GNU/Linux Testing
# Author : Vladimír "Thang" Kincl
#    updated : petch
# Script licence : GNU GPLv3
# Program licence : Proprietary

# CHANGELOG
# [SuperPlumus] (2013-05-19 13-06)
#   clean gettext messages

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="OnLive"
PREFIX="OnLive"
WORKING_WINE_VERSION="1.5.21"
#GAME_VMS="1024"

# Starting the script
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "OnLive Inc." "http://www.onlive.com/" "Thang" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose if you have already downloaded the game or you want to download it
POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"


# Begin game installation
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then #We handle download from the official website
    cd "$POL_System_TmpDir"
    POL_Download "http://www.onlive.com/d/windows/OnLive_Setup.exe"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "OnLive_Setup.exe"
    POL_Wine_WaitExit "$TITLE"
else
    # Asking then installing the app from the given file
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$SETUP_EXE"
    POL_Wine_WaitExit "$TITLE"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Making shortcut
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/OnLive"
POL_Shortcut "OnLive.exe" "$TITLE" "" ""

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGYs3EACgkQ5TH6yaoTykeuSACeK9nUPQPH5T0xcFLgJMYfYEF3
1b0AnRjnJfH4mrKKwY61C2ProvOYC/c5
=/fc/
-----END PGP SIGNATURE-----
