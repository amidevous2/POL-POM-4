#!/bin/bash
# Date : (2011-07-22 12-32)
# Last revision : (2013-05-19 20-53)
# Wine version used : N/A
# Distribution used to test : Ubuntu 10.04
# Author : SuperPlumus

# CHANGELOG
# [Aymeric PETIT / MulX] (2011-10-29 19-20)
#   Updated translations
# [Quentin PÂRIS] (2011-10-29 19-57)
#   Updated translations
#   Removed new line at the end of the file
# [SuperPlumus] (2013-05-12 17-08)
#   Remove POL_Wine_PrefixCreate and POL_System_SetArch
#   Add test prefix exist
#   Update URL to download
# [SuperPlumus] (2013-05-19 20-53)
#   gettext

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Wow Cartographe"
TITLE_REQUIRED="World of Warcraft"
PREFIX="WorldOfWarcraft"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Tixu" "http://tixu.scribe.free.fr/" "SuperPlumus" "$PREFIX"

if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "False" ]; then
POL_SetupWindow_message "$(eval_gettext 'Please install $TITLE_REQUIRED first')"
POL_SetupWindow_Close
exit
fi

POL_Wine_SelectPrefix "$PREFIX"

POL_System_TmpCreate "$PREFIX"


POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
cd "$POL_System_TmpDir"
POL_Download "http://mcguffin.free.fr/WowCartoInstall120.exe" "f25b92f306c5ef635d6a1fdfddf374a7"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "WowCartoInstall120.exe"
POL_Wine_WaitExit "$TITLE"
fi

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
fi

POL_Wine_SetVideoDriver
POL_System_TmpDelete

POL_Shortcut "WowCartographe.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGZIRcACgkQ5TH6yaoTykey7gCfQVushp6vMRujmR7yqsDFWwvY
luUAnR8Uj+rHT6FihKs23XaHiagAUZ5y
=oIZ+
-----END PGP SIGNATURE-----
