#!/bin/bash
# Date : (2009-28-03 12-00)
# Last revision : (2013-05-20 22-04)
# Wine version used : 1.2.2-Mousepatch, 1.3.26
# Distribution used to test : Debian Testing x64
# Author : Berillions & GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-05-20 22-04)
#   Clean script + gettext

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Borderlands Patch 1.41"
PREFIX="Borderlands"
WORKING_WINE_VERSION="1.3.26"
PVERSION="1.41"

POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION installer for $TITLE')"

if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "False" ]; then
POL_SetupWindow_message "$(eval_gettext 'Please install $TITLE_REQUIRED first')"
POL_SetupWindow_Close
exit
fi

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

#Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
    POL_SetupWindow_Close
    exit
fi

# Asking about patch local or not
cd "$HOME"
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_USER_ROOT/tmp"
    PATCH_URL="http://updates.gearboxsoftware.com/dlc/Borderlands_Worldwide_Update_PC1.41.zip"
    PATCH_ZIP="Borderlands_Worldwide_Update_PC1.41.zip"
    PATCH_EXE="Borderlands_Worldwide_Update_PC1.41/Setup.exe"
    POL_Download "$PATCH_URL" "c3925631f178d433a4d8a56879e2cf8d"
    unzip -o "$PATCH_ZIP"
    POL_Wine start /unix "$PATCH_EXE"
    POL_Wine_WaitExit "$TITLE"
    rm "$PATCH_ZIP"
fi

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGah2kACgkQ5TH6yaoTykdPogCggnj9cvdBorcCs35PRZBQHAuX
q8oAoJpTeh0K0ywVc4/Su9JxuUa9CSdK
=VNz4
-----END PGP SIGNATURE-----
