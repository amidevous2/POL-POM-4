#!/bin/bash
# Date : (2010-02-09 12-00)
# Last revision : (2013-05-20 15-08)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-05-20 15-08)
#   gettext
#   POL_SetupWindow_download -> POL_Download

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Far Cry 2 Patch 1.03"
TITLE_REQUIRED="Far Cry 2"
PREFIX="FarCry2"
PVERSION="1.03"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/top.jpg" "http://files.playonlinux.com/resources/setups/FarCry2/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION installer for $TITLE')"

POL_SetupWindow_checkexist()
{
    if [ ! -e "$POL_USER_ROOT/wineprefix/$1" ]; then
        POL_SetupWindow_message "$(eval_gettext 'Please install $TITLE_REQUIRED first')" "$TITLE"
        POL_SetupWindow_Close
        exit 0
    fi
}

POL_SetupWindow_checkexist "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system')" "$TITLE"
    POL_SetupWindow_Close
    exit 0
fi

# Asking about patch local or not
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_USER_ROOT/tmp"
    POL_Download "http://static3.cdn.ubi.com/far_cry_2/far_cry_2_1.03.exe" "055b151e834cccd6c5da8d468b26a86d"
    POL_Wine start /unix "far_cry_2_1.03.exe"
    POL_Wine_WaitExit "$TITLE"
    rm "far_cry_2_1.03.exe"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGaIkoACgkQ5TH6yaoTykcv8wCgn6gCQtDu6FQWjEXJ5TNf/Raz
x9IAoI0Z3GlUeS/uhGE/watxFmxGBqqm
=TVyr
-----END PGP SIGNATURE-----
