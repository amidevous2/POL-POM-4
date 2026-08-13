#!/bin/bash
# Date : (2012-05-20 19-45)
# Last revision : (2019-06-26 00-34)
# Wine version used : 4.0.1
# Distribution used to test : Linux Mint 19.1 Cinnamon - 64-bit
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2

# CHANGELOG
# [SuperPlumus] (2013-06-27 12-04)
#   Clean code

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Universal Extractor"
PREFIX="UniversalExtractor"
WORKING_WINE_VERSION="4.0.1"

INSTALLBIN="uniextract161.exe"
URL="http://www.legroom.net/software/uniextract"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1217
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Legroom" "$URL" "Pierre Etchemaite" "$PREFIX"
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update"

if [ -n "$POL_SELECTED_FILE" ]; then
    ARCHIVE="$POL_SELECTED_FILE"
else
    cd "$POL_USER_ROOT/tmp"
    POL_Download "http://files.playonlinux.com/$INSTALLBIN" "551ab65daa00a24089b40725d9f97be1"
    ARCHIVE="$POL_USER_ROOT/tmp/$INSTALLBIN"
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_LunaTheme

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$ARCHIVE" || POL_Debug_Fatal "$(eval_gettext 'Error while installing archive')"

POL_Shortcut "UniExtract.exe" "$TITLE" "$TITLE.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg5tHwAKCRDlMfrJqhPK
R3g2AJ9c3vaK02kMqhaQBYUt+4Hzd5Bc/ACfbvq7jBwGtKKCXLt+Q9iPWaG8xvs=
=iTJk
-----END PGP SIGNATURE-----
