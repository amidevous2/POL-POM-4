#!/bin/bash

# CHANGELOG
# [SuperPlumus] (2013-06-27 11-52)
# [kmiksi] (2016-02-23 13-00)
#   Clean Code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Resource Hacker"
PREFIX="ResourceHacker"
WORKING_WINE_VERSION="1.4"

EDITOR="Resource Hacker"
EDITOR_URL="http://www.angusj.com/resourcehacker/"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "Tinou" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_LunaTheme

cd "$WINEPREFIX/drive_c"
test -e reshacker_setup.exe ||
POL_Download "http://www.angusj.com/resourcehacker/reshacker_setup.exe" "f2e04857b30ed7c6a5f3a7e72b772e56"

POL_Wine_WaitBefore "$TITLE"
POL_Wine reshacker_setup.exe
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "ResourceHacker.exe"  "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlbTFecACgkQ5TH6yaoTykd+AQCgkD/lCZ2WSPWyuZERi+FrW1Fp
MVMAoIdLJBV+jfD1o/HVp4y8Wr0FIXdo
=tDy4
-----END PGP SIGNATURE-----
