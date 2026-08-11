#!/bin/bash
# Date : (2010-22-11 21-00)
# Last revision : (2013-09-30 09-59)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-05-20 14-52)
#   gettext
#   POL_SetupWindow_download -> POL_Download
# [SuperPlumus] (2013-09-30 09-59)
#   Update gettext messages
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Bioshock Patch 1.1"
TITLE_REQUIRED="Bioshock"
PREFIX="bioshock"
PVERSION="1.1"

# Starting the script
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/bioshock/top.jpg" "http://files.playonlinux.com/resources/setups/bioshock/left.jpg" "$TITLE"
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

POL_System_TmpCreate "$PREFIX"

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system')" "$TITLE"
    POL_SetupWindow_Close
    exit
fi

# Asking if patch is local or not

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_System_TmpDir"
    POL_Download "http://downloads.2kgames.com/bioshock/patch/Bioshock_Version_11_Patch_Worldwide_Retail.zip" "c17bb708f52f5c88dfc022163e5fd589"
    unzip -o "Bioshock_Version_11_Patch_Worldwide_Retail.zip"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "Bioshock Version 1.1 Patch Worldwide Retail.exe"
    POL_Wine_WaitExit "$TITLE"
fi

POL_System_TmpDelete

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJJNNsACgkQ5TH6yaoTyket2ACfTPgLlNM2OmiVIor4NirmBfaW
OjsAoIj0wE4M8Ui3RjlLzZlRzIZMJdy6
=on5L
-----END PGP SIGNATURE-----
