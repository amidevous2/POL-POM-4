#!/usr/bin/env playonlinux-bash

# Date : (2015-05-25 18:15 UTC+7)
# Last revision : (2015-05-26 13:00 UTC+7)
# Wine version used : 3.0.3, 1.7.43
# Distribution used to test : Ubuntu 14.04
# Author : Visatouch Deeying (xerodotc)
# Script licence : GPLv3
# Program licence : Proprietary
# Depend : xact, vcrun2012, devenum, quartz, wmp9, wmpcodecs
#
# CHANGELOG
# [Visatouch Deeying (xerodotc)] (2015-05-25 18:15 UTC+7)
#   Initial script.
# [Dadu042] (2020-01-16 23:50)
#   Wine 1.7.43 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Hyperdimension Neptunia ReBirth1"
PREFIX="NeptuniaReBirth1"
WINEVERSION="3.0.3"
STEAM_APPID=282900

# Add setup images
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/NeptuniaReBirth1/top.png" "http://files.playonlinux.com/resources/setups/NeptuniaReBirth1/left.png" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Idea Factory International, Inc." "http://ideafintl.com" "xerodotc" "$PREFIX"

# Start installation
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Install dependencies (thanks to Jon Feldman at AppDB)
POL_Call POL_Install_xact
POL_Call POL_Install_vcrun2012
POL_Call POL_Install_devenum
POL_Call POL_Install_quartz
POL_Call POL_Install_wmp9
POL_Call POL_Install_wmpcodecs

# Install Steam and actual game
POL_Call POL_Install_steam
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "steam.exe" "steam://install/$STEAM_APPID"

# Minimum Video memory requirement is 1GB
POL_SetupWindow_VMS "1024"

# Creating a shortcut
POL_Shortcut "steam.exe" "$TITLE" "${TITLE}.png" "steam://rungameid/$STEAM_APPID"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDnjwAKCRDlMfrJqhPK
RyjvAKCRDN2UuGrQ1E7lTgDSPL7fYMWfiQCfQa3AiMBm1BujMWQkVMBLwLfXH7U=
=FAx6
-----END PGP SIGNATURE-----
