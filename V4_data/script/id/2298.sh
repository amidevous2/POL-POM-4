#!/bin/bash
# Date : (2014-10-10 18:32)
# Last Revision : (2015-10-18 22:18)
# Wine Version used : 1.6.2-scummvm_support
# Distribution used to test : Ubuntu 15.04
# Author: ertaiNL
# Script license : GPL v2
# Programm license : Retail
# Depend :

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Stronghold Crusader"
PREFIX="StrongholdCrusader"
PUBLISHER="Firefly Studios"
PUBLISHER_URL="http://www.fireflyworlds.com/"
AUTHOR="ErtaiNL"
WORKING_WINE_VERSION="1.6.2-scummvm_support"
CD_PATH="Disk1"
CD_INSTALL_FILE="Setup.exe"
STARTUP_FILE="Stronghold Crusader.exe"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$PUBLISHER_URL" "$AUTHOR" "$PREFIX"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "$CD_PATH/$STARTUP_FILE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Check the disc again since the user could have removed it at this point
POL_SetupWindow_check_cdrom "$CD_PATH/$STARTUP_FILE"
POL_Wine "$CDROM/$CD_PATH/$CD_INSTALL_FILE"
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'NOTICE: If you get an error the first time you start Stronghold Crusader. Normally it works the second time.')" "$TITLE"

POL_Shortcut "$STARTUP_FILE" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlYlbugACgkQ5TH6yaoTykc76ACglJrlB5JTxfdew9rAHq+klUDF
PkUAnRhIz95g6vTe1FnXwPJuicK3N7HL
=rXV1
-----END PGP SIGNATURE-----
