#!/bin/bash
# Date : (2010-03-12 21-00)
# Last revision : (2013-07-24 08-32)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-07-24 08-32)
#   Update gettext messages
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Baldur's Gate Patch 1.1.4315"
TITLE_REQUIRED="Baldur's Gate"
PREFIX="BaldursGate1"
PVERSION="1.1.4315"

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
cd "$HOME"
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext 'Select first patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
    POL_SetupWindow_browse "$(eval_gettext 'Select second patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_USER_ROOT/tmp"
    POL_SetupWindow_menu "$(eval_gettext 'Which version do you have?')" "$TITLE" "$(eval_gettext 'US or Canadian version')~$(eval_gettext 'International version')" "~"
    if [ "$APP_ANSWER" = "$(eval_gettext 'US or Canadian version')" ]; then
        PATCH_URL_1="http://downloads.bioware.com/baldursgate1/bg114315.exe"
        PATCH_URL_2="http://downloads.bioware.com/baldursgate1/BG1DX8English.exe"
        PATCH_EXE_1="bg114315.exe"
        PATCH_EXE_2="BG1DX8English.exe"
        PATCH_MD5_1="d41d8cd98f00b204e9800998ecf8427e"
        PATCH_MD5_2="eeef9a92e117f973f5ebcaf0ded9d534"
    else
        PATCH_URL_1="http://downloads.bioware.com/baldursgate1/bgintl114315.exe"
        PATCH_URL_2="http://downloads.bioware.com/baldursgate1/BG1DX8Intl.exe"
        PATCH_EXE_1="bgintl114315.exe"
        PATCH_EXE_2="BG1DX8Intl.exe"
        PATCH_MD5_1="5d2217e5039779b6d4419ff340d3ea02"
        PATCH_MD5_2="2daa7eec28600c87b3cf682bc15a780e"
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

iEYEABECAAYFAlHvd7QACgkQ5TH6yaoTykfxFQCgsuU9UAQB9Bg5H3iw+3bSI961
c+EAn2JnqpbbVZZjZFDGRey3bcsTntcX
=Esfi
-----END PGP SIGNATURE-----
