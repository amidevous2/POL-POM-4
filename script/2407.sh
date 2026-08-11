#!/bin/bash
#
# CHANGELOG:
# [RobLoach] (2015)
#   First script. 
# [Dadu042] (2019-12-24)
#   Wine 2.12-staging -> 3.0.3
#   POL_RequiredVersion "4.2.12"

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Configuration
TITLE="Quake Live"
WEBSITE="http://www.quakelive.com"
DEVELOPER="id Software"
AUTHOR="PlayOnLinux"
PREFIX="quakelive"
WINE_VERSION="3.0.3"

# Start up PlayOnLinux
POL_SetupWindow_Init
POL_SetupWindow_SetID 2407
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$DEVELOPER" "$WEBSITE" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Create the Wine Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINE_VERSION"

# Dependencies
Set_OS "win7"

POL_Call POL_Install_steam
SHORTCUT="Steam.exe"
SHORTCUT_IMAGE=""
SHORTCUT_ARGS="-applaunch 282440"

# Create the Shortcut to the program
POL_Shortcut "$SHORTCUT" "$TITLE" "$SHORTCUT_IMAGE" "$SHORTCUT_ARGS" "Game;"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgI4GAAKCRDlMfrJqhPK
Rz47AKCeybP4DYivl+XkVZSB4MkIjkMIowCeJsaeTg7GQHP6hKgSiDq2uisv/1Y=
=+bHc
-----END PGP SIGNATURE-----
