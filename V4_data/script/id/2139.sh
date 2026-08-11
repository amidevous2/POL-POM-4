#!/bin/bash
#
# Date : (2014-07-06 11-48)
# Last revision : (2016-08-01 22-55)
# Wine version used : 1.9.15-staging
# Distribution used to test : Manjaro Linux 16.06.1 x64
# Author : OdzioM
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="18 Wheels of Steel: Across America"
PREFIX="18WOSAA"
WORKING_WINE_VERSION="5.0"
GAME_VMS="64"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "SCS Software" "http://www.scssoft.com/aa.php" "OdzioM" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"

POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_InstallMethod "CD,LOCAL"

if [ "$INSTALL_METHOD" == "CD" ]; then
        POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disc drive.')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "$TITLE"
else
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi

POL_SetupWindow_VMS $GAME_VMS

POL_Shortcut "aa.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_message "Installation complete!\n\nTo run $TITLE please select $TITLE icon from your desktop." "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXrgiVwAKCRDlMfrJqhPK
R9pHAJ468SvdNU11MA9V85/hxU6D08TBsACfbEdQBsEJIcNviFZ9QMfH5MxY9sk=
=YPHi
-----END PGP SIGNATURE-----
