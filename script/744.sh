#!/bin/bash
# Date : (2010-11-22 21-00)
# Last revision : (2013-09-30 09-42)
# Wine version used : 1.3.7, 1.3.8, 1.3.23
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-09-30 09-42)
#   Update gettext messages
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Assassin's Creed Patch 1.02"
TITLE_REQUIRED="Assassin's Creed"
PREFIX="AssassinsCreed"
WORKING_WINE_VERSION="1.3.23"
PVERSION="1.02"

# Starting the script
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION Installer for $TITLE_REQUIRED')"

if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "False" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')"
    POL_SetupWindow_Close
    exit
fi

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

POL_System_TmpCreate "$PREFIX"

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
    POL_SetupWindow_Close
    exit
fi

# Using specific Wine
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_System_TmpDir"
    POL_Download "http://patches.ubi.com/assassins_creed/assassins_creed_1.02.exe" "769f1ca01fac15df35154199e1571eac"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "assassins_creed_1.02.exe"
    POL_Wine_WaitExit "$TITLE"
fi

POL_System_TmpDelete

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJJLvkACgkQ5TH6yaoTykeqOwCfeYfdcv1SxPxC7ezIe1hFWEj6
vjAAn2Ubm1n6VyGn+kVs7XT0tRoVQRn5
=WvE/
-----END PGP SIGNATURE-----
