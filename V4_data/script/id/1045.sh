#!/bin/bash
# Date : (2012-02-05 18-36)
# Last revision : (2012-10-15 10-54)
# Wine version used : 1.5.15
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Freeware
# Depend :

# Tested with install archives:
# TSR-SkiChallenge12.exe 71513656 "ca54f9f503159f933ac97ba123647cfb"
# TSR-SkiChallenge12.exe ? "5434f04497aa6e5376ac781e3c1040dc"

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="SkiChallenge2012"
WORKING_WINE_VERSION="1.5.15"

TITLE="Ski Challenge 2012"
URL="http://www.skichallenge.ch/fr/"
SHORTCUT_NAME="Ski Challenge 12 (FTV)"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1045
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Greentube" "$URL" "Pierre Etchemaite" "$PREFIX"

if [ -n "$POL_SELECTED_FILE" ]; then
    ARCHIVE="$POL_SELECTED_FILE"
else
    cd "$POL_USER_ROOT/tmp"
    POL_Download "http://download.greentube.com/magic/games/sc12/FR_FTV_MAIN/installer/FTV-SkiChallenge12.exe" "45bd1ce7ac1e12c8161f62907c7cbcdd"
    ARCHIVE="$POL_USER_ROOT/tmp/FTV-SkiChallenge12.exe"
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Wine_WaitBefore "$TITLE"

POL_Wine --ignore-errors "$ARCHIVE"
case "$?" in
    0|2)
        ;;
    *)
        POL_Debug_Fatal "$(eval_gettext 'Error while installing archive')"
        ;;
esac


POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Games/Ski Challenge 12 (FTV)/Updater.exe" "$SHORTCUT_NAME"
POL_ExtractIcon "$WINEPREFIX/drive_c/Games/Ski Challenge 12 (FTV)/Game.exe" "$POL_USER_ROOT/icones/32/$SHORTCUT_NAME"
POL_ExtractBiggestIcon "$WINEPREFIX/drive_c/Games/Ski Challenge 12 (FTV)/Game.exe" "$POL_USER_ROOT/icones/Full_size/$SHORTCUT_NAME"

POL_SetupWindow_Close

exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlB71L4ACgkQ5TH6yaoTykdhvgCgji3AL6AeJzYtSuBUoc7wrQjX
WhEAnRSmI/eg0Dopx4uuZk2Q2WQtTBld
=1BuM
-----END PGP SIGNATURE-----
