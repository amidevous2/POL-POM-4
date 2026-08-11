#!/bin/bash
# Date : (2010-03-09 19-00)
# Last revision : (2013-09-30 09-20)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-05-20 13-58)
#   gettext
#   POL_SetupWindow_download -> POL_Download
# [SuperPlumus] (2013-09-30 09-20)
#   Update gettext messages

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Assassin's Creed 2 Patch 1.01"
TITLE_REQUIRED="Assassin's Creed 2"
PREFIX="AssassinsCreed2"
PVERSION="1.01"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/AC2/top.jpg" "http://files.playonlinux.com/resources/setups/AC2/left.jpg" "$TITLE"
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

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system')" "$TITLE"
    POL_SetupWindow_Close
    exit
fi

# Using specific Wine
cd "$HOME"
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_USER_ROOT/tmp"
    PATCH_URL="http://static3.cdn.ubi.com/assassins_creed_2/assassins_creed_2_1.01_us.exe"
    PATCH_EXE="assassins_creed_2_1.01_us.exe"
    POL_Download "$PATCH_URL" "56e3492e8a20cc1856c9532d2ec7dada"
    POL_Wine start /unix "$PATCH_EXE"
    POL_Wine_WaitExit "$TITLE"
    rm "$PATCH_EXE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJJKFQACgkQ5TH6yaoTykd/wgCcCS10wSF8BhWWEKs5Cad9U5dr
ZxEAoJ+z4WxojEwAzFFTaVAoT7oojMwT
=6W0Z
-----END PGP SIGNATURE-----
