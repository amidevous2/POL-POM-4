#!/bin/bash
# Date : (2011-09-03 21-00)
# Last revision : (2013-07-24 17-54)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-07-24 17-54)
#   Update gettext messages

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Dragon Age 2 - DLC"
TITLE_REQUIRED="Dragon Age 2"
PREFIX="DA2"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/da2/top.jpg" "http://files.playonlinux.com/resources/setups/da2/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the DLCs Installer for $TITLE_REQUIRED')"

if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "False" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Please install $TITLE_REQUIRED first')"
    POL_SetupWindow_Close
    exit
fi

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Asking DLC location
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE" ""
SETUP_EXE="$APP_ANSWER"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHv+YsACgkQ5TH6yaoTyke4oQCeP0Gmtt+Y2u688P73PXLG/M3u
v+EAoK+OX4LUWhLkr2C9qCDejRIbmokV
=Smtm
-----END PGP SIGNATURE-----
