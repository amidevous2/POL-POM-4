#!/bin/bash

# Date : (2014-09-23 20-11)
# Wine version used : 1.7.26
# Distribution used to test : Mint 17
# Author : Fake Shemp

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Burning Cars"
PREFIX="BurningCars"

# Latest working Wine version
WORKING_WINE_VERSION="1.7.26"
 
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "Polynetix Studio" "http://polynetix.com/" "Fake Shemp" "$PREFIX"

# Select installation file
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select your installation file.')" "$TITLE"
SETUP_EXE="$APP_ANSWER"

# Configure Wine
POL_System_SetArch "amd64"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
Set_OS "win7"

# Install dependencies
POL_Call POL_Install_physx
POL_Call POL_Install_dxfullsetup

# Install program
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"

# Create shortcut
POL_Shortcut "Burning Cars Launcher.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlQiUhYACgkQ5TH6yaoTykcllwCfZ0H/MDnJLSGN6nXBYIQHZWwY
S/cAn0ZUIbXu1jG+I5Sk+Up1SY2T2Zju
=gGwI
-----END PGP SIGNATURE-----
