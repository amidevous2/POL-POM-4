#!/bin/bash

# Date : (2015-10-02 14-00)
# Wine version used : 3.0.3
# Distribution used to test : Debian Testing x64
# Author : RvL & NSWL & GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [RvL & NSWL & GNU_Raziel] (2015-10-02 14-00)
#   Initial script.
# [Dadu042] (2020-01-19 22:50)
#   Wine 1.7.45 -> 3.0.3
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Assassin's Creed"
PREFIX="AssassinsCreed_gog"
GOGID="assassins_creed_directors_cut"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"

# Starting the script
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ubisoft" "http://assassinscreed.uk.ubi.com" "RvL & NSLW & GNU_Raziel" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_dxfullsetup

POL_Call POL_GoG_setup "$GOGID" "1ab20046e23e509206c950bc2fc2c7b5" "b3545ba5b5ea455d489541d84e9607f3" "4fcb30b467540d0b0a2a088d4c44613c"
POL_Call POL_GoG_install

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
POL_Wine_Direct3D "DirectDrawRenderer" "opengl"

# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Making shortcut
POL_Shortcut "AssassinsCreed_Dx9.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYh5wAKCRDlMfrJqhPK
R3E+AJ9Jpr0qNoEZqwnwkqZ9Hl/YCZTWTQCfeYu66DYxRtPWUmRPuDF+QTL0knQ=
=zjrB
-----END PGP SIGNATURE-----
