#!/bin/bash
# Date : (2010-03-12 21-00)
# Last revision : (2013-07-24 08-18)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-07-24 08-18)
#   Update gettext messages
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Baldur's Gate II : Throne of Bhaal Patch 2.5.26498"
TITLE_REQUIRED="Baldur's Gate II : Throne of Bhaal"
PREFIX="BaldursGate2"
PVERSION="2.5.26498"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/BG2/top.jpg" "http://files.playonlinux.com/resources/setups/BG2/left.jpg" "$TITLE"
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

#Using specific Wine
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_USER_ROOT/tmp"
    POL_SetupWindow_menu "$(eval_gettext 'Which version do you have?')" "$TITLE" "$(eval_gettext 'English version')~$(eval_gettext 'International version')" "~"
    if [ "$APP_ANSWER" = "$(eval_gettext 'English version')" ]; then
        PATCH_URL="http://downloads.bioware.com/baldursgate2/BGII-ThroneofBhaal_Patch_26498_ENGLISH.exe"
        PATCH_EXE="BGII-ThroneofBhaal_Patch_26498_ENGLISH.exe"
        PATCH_MD5="f1f50a8018343dcdf34b3ac2965c03ed"
    else
        PATCH_URL="http://downloads.bioware.com/baldursgate2/BGII-ThroneofBhaal_Patch_26498_EUROPEAN.exe"
        PATCH_EXE="BGII-ThroneofBhaal_Patch_26498_EUROPEAN.exe"
        PATCH_MD5="d32adae416e7e38f189b26e5f96a2cfc"
    fi
    POL_Download "$PATCH_URL" "$PATCH_MD5"
    POL_Wine start /unix "$PATCH_EXE"
    POL_Wine_WaitExit "$TITLE"
    rm "$PATCH_EXE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHvdAQACgkQ5TH6yaoTykchUQCgmzlQc70nGsWvlwnbWBCvG1El
tRkAoIEyasYRWATCpTjKzYy6vZavMskX
=Y98S
-----END PGP SIGNATURE-----
