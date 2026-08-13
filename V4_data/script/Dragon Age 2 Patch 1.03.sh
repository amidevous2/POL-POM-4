#!/bin/bash
# Date : (2010-17-03 21-00)
# Last revision : (2013-07-24 15-00)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-07-24 15-00)
#   Update gettext messages
#   Clean code
#   Remove InstallMethod "DOWNLOAD", because lack url

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Dragon Age 2 Patch 1.03"
TITLE_REQUIRED="Dragon Age 2"
PREFIX="DA2"
PVERSION="1.03"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/da2/top.jpg" "http://files.playonlinux.com/resources/setups/da2/left.jpg" "$TITLE"
POL_SetupWindow_Init

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

# Check if it's Steam version
STEAM=`find "$WINEPREFIX" -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
    POL_SetupWindow_Close
    exit 0
fi

# Asking about patch local or not
POL_SetupWindow_InstallMethod "LOCAL"

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_USER_ROOT/tmp"
    PATCH_URL="http://na.llnet.bioware.cdn.ea.com/u/f/eagames/bioware/dragonage2/patch/pc/DragonAge2-1.03.exe"
    PATCH_EXE="DragonAge2-1.03.exe"
    POL_Download "$PATCH_URL"
    POL_Wine start /unix "DragonAge2-1.03.exe"
    POL_Wine_WaitExit "$TITLE"
    rm "$PATCH_EXE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHv0wgACgkQ5TH6yaoTykchJACdHXdC21ZGEf6jz8bpLwjFhnlO
SxQAoKQa2K98i5mLpnUm5000geGjweIb
=40K+
-----END PGP SIGNATURE-----
