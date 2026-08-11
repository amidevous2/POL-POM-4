#!/bin/bash
# Date : (2013-02-18 ??-??)
# Last revision : (2013-12-08 19-04)
# Distribution used to test : Ubuntu 12.10 LTS
# Author : lahtis

# CHANGELOG
# [SuperPlumus] (2013-12-08 19-04)
#   Update gettext messages
#   Clean code

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Tree[d]"
PREFIX="treed"
WORKING_WINE_VERSION="1.5.17"
EDITOR="Giles"
GAME_URL="http://www.frecle.net"
AUTHOR="lahtis"


POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

Set_OS "winxp"

POL_SetupWindow_InstallMethod "LOCAL, DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://www.frecle.net/treed/tree[d]-setup310.exe"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "tree[d]-setup310.exe"
    POL_Wine_WaitExit "$TITLE"
fi
POL_System_TmpDelete

POL_Shortcut 'tree\[d\].exe' "$TITLE"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKkuH8ACgkQ5TH6yaoTykd2wQCggVJ9hdL/ArBX2kZdgmM8lKT8
huIAniWB6jxem0OYQK6RNAe21aMWrhOl
=7Uuh
-----END PGP SIGNATURE-----
