#!/bin/bash
# Date : (2011-07-12 15-20)
# Last revision : (2013-07-17 20-41)
# Distribution used to test : openSUSE 11.4 x64
# Author : Crendgrim
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-07-17 20-41)
#   Clean code
#   Update $TITLE variable

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="CivCity Rome Patch 1.1"
TITLE_REQUIRED="CivCity Rome"
PREFIX="CivCityRome"
PVERSION="1.1"

# Starting the script
POL_SetupWindow_Init

# For POL_System_unrar
POL_RequiredVersion "4.1.4" || POL_Debug_Fatal "$APPLICATION_TITLE 4.1.4 is required to install $TITLE"

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION installer for $TITLE_REQUIRED')"

if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "False" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Please install $TITLE_REQUIRED first')"
    POL_SetupWindow_Close
    exit
fi

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

POL_System_TmpCreate "$PREFIX"

#Check if it's Steam version
STEAM=`find "$WINEPREFIX" -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
    POL_SetupWindow_Close
    exit
fi

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_System_TmpDir"
    POL_Download "http://downloads.2kgames.com/civcityrome/CivCity_Rome_Update_v1.1.rar" "8356cdb4780b6287d212a6e144e4de42"
    POL_System_unrar e "CivCity_Rome_Update_v1.1.rar"
    POL_Wine start /unix "CivCity_Rome_Roma_Rom_Update_v1.1.exe"
    POL_Wine_WaitExit "$TITLE"
fi

POL_System_TmpDelete

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHm+pQACgkQ5TH6yaoTykcRHwCcDcqR6Qvjfwo2oH8s7whzm7xn
KLoAniVcfIcI0BkMxA0Xo9D4o5uBZ1t+
=/lce
-----END PGP SIGNATURE-----
