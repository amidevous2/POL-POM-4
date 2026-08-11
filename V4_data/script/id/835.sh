#!/bin/bash
# Date : (2011-14-03 21-00)
# Last revision : (2013-05-15 20:52)
# Wine version used : 1.3.17, 1.3.23, 1.3.26, 1.5.28
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Desura"
PREFIX="Desura"
WORKING_WINE_VERSION="1.5.28"
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/desura/top.jpg" "http://files.playonlinux.com/resources/setups/desura/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Desura" "http://www.desura.com" "GNU_Raziel" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Downloading latest Desura
cd "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/"
POL_Download "http://www.desura.com/DesuraInstaller.exe" ""

# Installing mandatory dependencies
POL_Wine_InstallFonts
POL_Function_FontsSmoothRGB

# Installing Desura
cd "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/"
POL_Wine start /unix "DesuraInstaller.exe"
POL_Wine_WaitExit "$TITLE"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Making shortcut
POL_Shortcut "Desura.exe" "$TITLE" "$TITLE.png" ""

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHBoAkACgkQ5TH6yaoTykdNwwCaA8SK+eb8qiMoPrGG2scLhKCR
uU0AnjDKuP+5ML1RjQeXdk14AZ5R362F
=3FRw
-----END PGP SIGNATURE-----
