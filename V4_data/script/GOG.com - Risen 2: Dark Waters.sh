#!/bin/bash
# Date : (2014-08-20 20:18)
# Last Revision : see changelog
# Wine Version used : 
# Distribution used to test : Debian testing/jessie
# Author: Hoshpak
# Script license : GPL v2
# Programm license : Retail
# Depend :

# CHANGELOG
# [Hoshpak] (2014-08-20 20:18)
#   Initial script
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.7.20 (outdated) -> 2.22
#   Add POL_System_SetArch "x86"

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID_BASE="risen_2_dark_waters"
GOGID_GOLD="risen_2_dark_waters_gold_edition"
PREFIX="Risen2_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Risen 2: Dark Waters"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Piranha Bytes" "http://www.gog.com/game/$GOGID_BASE" "Hoshpak" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID_BASE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"

POL_SetupWindow_question "$(eval_gettext 'Do you want to install the Gold Edition Upgrade now? This will only be possible if you purchased the Gold Edition, you can still install it later if you want.')" "$TITLE"

if [ "$APP_ANSWER" == "TRUE" ];
then
        POL_SELECTED_FILE=""
        POL_Call POL_GoG_setup "$GOGID_UPGRADE"
        POL_Call POL_GoG_install
fi

POL_Call POL_Install_d3dx9_36

Set_OS winxp

# Configure the shortcut
GOGPATH="$GOGROOT/Risen 2 - Dark Waters"
POL_Shortcut "Risen.exe" "Risen 2: Dark Waters" "" "" "Game;"
POL_Shortcut "Settings.exe" "Risen 2: Dark Waters Settings" "" "" "Game;"

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnJ+qwAKCRDlMfrJqhPK
R7fAAJwKKQ8rcOkvfskInewVjvlKeukqwQCdH2zK/34Zx2SnLecQJMD5+54IdCI=
=a5C6
-----END PGP SIGNATURE-----
