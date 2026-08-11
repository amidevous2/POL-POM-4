#!/bin/bash
#
# Date : (2016-08-01 23-55)
# Last revision : see changelog
# Wine version used : see changelog
# Distribution used to test : Manjaro Linux 16.06.1
# Author : OdzioM
# Licence : Retail

# CHANGELOG
# [OdzioM] (2016-08-01 23-55)
#   First script.
# [Dadu042] (2020-03-28)
#   Wine 1.9.15-staging (outdated) -> 3.0.3 (not tested)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Tony Hawk's Pro Skater 4"
INFO1="Beenox Inc."
INFO2="http://beenox.com/"
AUTHOR="OdzioM"
PREFIX="THPS4"
WORKING_WINE_VERSION="3.0.3"
WINE_ARCH="x86"
GAME_VMS="64"


POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$INFO1" "$INFO2" "$AUTHOR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"

POL_System_SetArch "$WINE_ARCH"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_InstallMethod "CD,LOCAL"

if [ "$INSTALL_METHOD" == "CD" ]; then
        POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disc drive.')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "PlayDiskStart.exe"
        POL_Wine start /unix "$CDROM/Win/setup.exe"
        POL_Wine_WaitExit "$TITLE"
else
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi

POL_SetupWindow_VMS $GAME_VMS

POL_Shortcut "Start.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_message "Installation complete!\n\nTo run $TITLE please select $TITLE icon from your desktop." "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXn/aaAAKCRDlMfrJqhPK
R1NeAKCnn5GH9FrxNbmP3R0QSEYGzfRA5QCdHd5KZFqgw8I1+ZnawmFwPqYmMvA=
=SohN
-----END PGP SIGNATURE-----
