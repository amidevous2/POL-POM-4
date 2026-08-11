#!/bin/bash
# Date : (2010-03-12 21-00)
# Last revision : (2013-07-24 08-45)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-07-24 08-45)
#   Update gettext messages
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Baldur's Gate : Tales of the Sword Coast Patch 1.3.5512"
TITLE_REQUIRED="Baldur's Gate : Tales of the Sword Coast"
PREFIX="BaldursGate1"
PVERSION="1.3.5512"

#starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/BG1/top.jpg" "http://files.playonlinux.com/resources/setups/BG1/left.jpg" "$TITLE"
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
    POL_SetupWindow_browse "$(eval_gettext 'Select first patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
    POL_SetupWindow_browse "$(eval_gettext 'Select second patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_USER_ROOT/tmp"
    POL_SetupWindow_menu "$(eval_gettext 'Which version do you have?')" "$TITLE" "$(eval_gettext 'US or Canadian version')~$(eval_gettext 'UK version')~$(eval_gettext 'International version')" "~"
    if [ "$APP_ANSWER" = "$(eval_gettext 'US or Canadian version')" ]; then
        PATCH_URL_1="http://downloads.bioware.com/baldursgate1/BGTalesUS5512.exe"
        PATCH_URL_2="http://downloads.bioware.com/baldursgate1/BGTalesDX8English.exe"
        PATCH_EXE_1="BGTalesUS5512.exe"
        PATCH_EXE_2="BGTalesDX8English.exe"
        PATCH_MD5_1="26f2d8b73bcdf940c52f60e4d7ba95e2"
        PATCH_MD5_2="b539c05ffee2a02717b7bbd17bf00d0b"
    elif [ "$APP_ANSWER" = "$(eval_gettext 'UK version')" ]; then
        PATCH_URL_1="http://downloads.bioware.com/baldursgate1/BGTalesUK5512.exe"
        PATCH_URL_2="http://downloads.bioware.com/baldursgate1/BGTalesDX8English.exe"
        PATCH_EXE_1="BGTalesUK5512.exe"
        PATCH_EXE_2="BGTalesDX8English.exe"
        PATCH_MD5_1="fbe9f755c08652bb32cabf90a45b3729"
        PATCH_MD5_2="b539c05ffee2a02717b7bbd17bf00d0b"
    else
        PATCH_URL_1="http://downloads.bioware.com/baldursgate1/BGTalesIntl5512.exe"
        PATCH_URL_2="http://downloads.bioware.com/baldursgate1/BGTalesDX8Intl.exe"
        PATCH_EXE_1="BGTalesIntl5512.exe"
        PATCH_EXE_2="BGTalesDX8Intl.exe"
        PATCH_MD5_1="1b7e6551727112f0b3c7926c9c2c4530"
        PATCH_MD5_2="76ed0209829bba8ce86a426b10201149"
    fi
    POL_Download "$PATCH_URL_1" "$PATCH_MD5_1"
    POL_Download "$PATCH_URL_2" "$PATCH_MD5_2"
    POL_Wine start /unix "$PATCH_EXE_1"
    POL_Wine_WaitExit
    POL_Wine start /unix "$PATCH_EXE_2"
    POL_Wine_WaitExit
    rm "$PATCH_EXE_1"
    rm "$PATCH_EXE_2"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHve4EACgkQ5TH6yaoTykeILACglgnUKwbPcGUx8zIly+NeMKWD
ewUAnjH+T3XrxL6PH0tIqFTF+uoYRFAU
=lAzI
-----END PGP SIGNATURE-----
