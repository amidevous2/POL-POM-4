#!/bin/bash
# Date : (2011-21-03 21-00)
# Last revision : (2013-09-30 09-31)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-05-20 14-29)
#   gettext
#   POL_SetupWindow_download -> POL_Download
# [SuperPlumus] (2013-09-30 09-31)
#   Update gettext messages
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Assassin's Creed Brotherhood Patch 1.03"
TITLE_REQUIRED="Assassin's Creed Brotherhood"
PREFIX="AssassinsCreedBrotherhood"
PVERSION="1.03"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/ACB/top.jpg" "http://files.playonlinux.com/resources/setups/ACB/left.jpg" "$TITLE"
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

# Asking if patch is local or not
cd "$HOME"
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_USER_ROOT/tmp"
    PATCH_URL="http://static3.cdn.ubi.com/ac_brotherhood/ac_brotherhood_1.03_wwonline.exe"
    PATCH_EXE="ac_brotherhood_1.03_wwonline.exe"
    POL_Download "$PATCH_URL" "fc95ea88a5e329a110071a5cdc72fcc5"
    POL_Wine start /unix "$PATCH_EXE"
    POL_Wine_WaitExit "$TITLE"
    rm "$PATCH_EXE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJJKe0ACgkQ5TH6yaoTykcO+QCeKjGdLqq6b0Ok8vV9zDjSy4eF
m1kAnRja14/VawUekJcpC223/FZbkL5q
=v1We
-----END PGP SIGNATURE-----
