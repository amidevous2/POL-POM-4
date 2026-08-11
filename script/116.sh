#!/bin/bash
# Date : (2010-31-08 13-00)
# Last revision : (2013-07-24 14-32)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-07-24 14-32)
#   Update gettext messages
#   Clean code
#   Fix InstallMethod (Missing POL_SetupWindow_InstallMethod)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Dark Messiah of Might and Magic Patch 1.02"
TITLE_REQUIRED="Dark Messiah of Might and Magic"
PREFIX="DarkMessiah"
PVERSION="1.02"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/top.jpg" "http://files.playonlinux.com/resources/setups/darkmessiah/left.jpg" "$TITLE"
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
    exit
fi

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

# Asking about patch local or not
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Select first patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit
    POL_SetupWindow_browse "$(eval_gettext 'Select second patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit
else
    cd "$POL_USER_ROOT/tmp"
    PATCH_URL_1="http://patches.ubi.com/dark_messiah/dark_messiah_1.01_us_uk_fr_it_sp.exe"
    PATCH_EXE_1="dark_messiah_1.01_us_uk_fr_it_sp.exe"
    PATCH_MD5_1="d71331075733361d0f2797a49c7d18a7"
    PATCH_URL_2="http://patches.ubi.com/dark_messiah/dark_messiah_1.02_us_uk_fr_it_sp.exe"
    PATCH_EXE_2="dark_messiah_1.02_us_uk_fr_it_sp.exe"
    PATCH_MD5_2="80c1ea63cdbd5801b8979ff4b8bc4929"
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
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHvzhIACgkQ5TH6yaoTykenOQCgieXKB4VQDmRAqxItEmskIt9W
2m8AoJFyOeCMKjbaQ6hQPZIwRW6Frunp
=42da
-----END PGP SIGNATURE-----
