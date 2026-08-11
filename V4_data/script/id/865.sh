#!/bin/bash
# Date : (2011-07-12 17-00)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : openSUSE 11.4 x64
# Author : Crendgrim
# Only For : http://www.playonlinux.com

# CHANGELOG
# [Crendgrim] (2011-07-12 17-00)
#   Initial script.
# [SuperPlumus] (2013-07-17 08-49)
#   Clean code
# [Dadu042] (2020-01-22 21:30)
#   Wine 1.3.24 -> 3.0.3
#   Improve POL_Shortcut

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="CivCity Rome"
PREFIX="CivCityRome"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="64"

# Starting the script
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Firefly Studios + Firaxis Games" "http://www.2kgames.com/civcityrome/civcity.html" "Crendgrim" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # Forcing x86 to avoid any possible x64 related bugs with this "old" game
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "CD,STEAM"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" = "STEAM" ]; then
    POL_Call POL_Install_steam
else
    # Fix for button's labels, CD version
    POL_Wine_InstallFonts
    POL_Call POL_Function_FontsSmoothRGB
fi

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "3980"

# Begin game installation
if [ "$INSTALL_METHOD" = "CD" ]; then
    # Asking for CDROM and checking if it's correct one
    POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "setup.exe"
    # Setting cdrom path to wine
    cd "$WINEPREFIX/dosdevices"
    ln -s "$CDROM" d:
    POL_SetupWindow_message "$(eval_gettext 'Warning: GameShadow wont work.\nPlease de-select during installation.')" "$TITLE"
    POL_Wine start /unix "$CDROM/setup.exe"
    POL_Wine_WaitExit "$TITLE"
else
    POL_SetupWindow_message "$(eval_gettext 'Do not forget to close Steam when downloading\nis finished, so that $APPLICATION_TITLE can continue\nto install your game.')" "$TITLE"
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine start /unix "steam.exe" steam://install/3980
    POL_Wine_WaitExit "$TITLE"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##

# Making shortcut
if [ "$INSTALL_METHOD" = "STEAM" ]; then
    POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/3980"
else
    POL_Shortcut "CivCity Rome.exe" "$TITLE" "" "" "Game;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjFhPgAKCRDlMfrJqhPK
R+XOAKCkdh3HI8fDJ+4pH6k4s32oVyPxdwCeM4b1NGLVi8oKVDO/MxOxb7bcU5s=
=WEfR
-----END PGP SIGNATURE-----
