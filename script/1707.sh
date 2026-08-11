#!/bin/bash
# Date : (2013-05-22 13-30)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Xubuntu 13.04
# Author : Pascal Reinhard dev@ovocean.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# CHANGELOG
# [Pascal Reinhard] (2019-09-29)
#   First script.
# [Dadu042] (2020-05-26)
#   Wine 1.4.1 (2013, outdated) -> system version (v3.0 as of 2019)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="Sacrifice"
WORKING_WINE_VERSION=""

TITLE="Sacrifice"
SHORTCUT_NAME="Sacrifice"

# Patch needed, doesn't work without
PATCHFILE="SacrificePatch3.exe"
DOWNLOAD_URL="http://files.playonlinux.com/$PATCHFILE"
DOWNLOAD_MD5="c1c6269e9c5840d705843886407b8647"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1707
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Shiny Entertainment / Interplay" "http://en.wikipedia.org/wiki/Sacrifice_%28video_game%29" "Xodetaetl" "$PREFIX"

POL_SetupWindow_message "$(eval_gettext 'This will let you install Sacrifice, then will download and install its patch #3. Do not launch the game until the patch is installed.')" "$(eval_gettext 'Note')"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_InstallMethod "LOCAL,CD"

if [ "$INSTALL_METHOD" == "LOCAL" ]; then
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
	POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
	POL_Wine start /unix "$APP_ANSWER"
elif [ "$INSTALL_METHOD" == "CD" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "Sacrifice.ex_"
	POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
	POL_Wine start /unix "$CDROM/Setup.exe"
fi
POL_Wine_WaitExit "$TITLE"

# Needs Win NT4.0 to launch
Set_OS "nt40"

# Install patch
cd "$POL_USER_ROOT/tmp"
POL_Download "$DOWNLOAD_URL" "$DOWNLOAD_MD5"
TMP_FILE="$POL_USER_ROOT/tmp/$PATCHFILE"
POL_Wine "$TMP_FILE"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "Sacrifice.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/Program Files/Shiny/Sacrifice/Readme.txt"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXs0G1wAKCRDlMfrJqhPK
RyOnAKCNjk7OuXseL3PP8ZNpie1Pv3ZPTACgsPdQftyw4erNOLzZQS7caVKqTMM=
=njyn
-----END PGP SIGNATURE-----
