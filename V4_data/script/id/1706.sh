#!/bin/bash
# Date : (2013-05-21 20-47)
# Last revision : (2013-07-23 22-37)
# Wine version used : 1.5.30
# Distribution used to test : Xubuntu 13.04
# Author : Pascal Reinhard dev@ovocean.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

# CHANGELOG
# [SuperPlumus] (2013-07-23 22-37)
#   Update gettext messages

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE_REQUIRED="GOG.com - Populous 3: The Beginning"
PREFIX="Populous3TheBeginning_gog"
WORKING_WINE_VERSION="1.5.30"

TITLE="GOG.com - Populous 3: The Beginning - High-resolution patch"
SHORTCUT_NAME="Populous 3: The Beginning - High-res patch"

PATCHFILE="popres.exe"
DOWNLOAD_URL="http://popre.net/files/$PATCHFILE"
DOWNLOAD_MD5="9fd53c2c5fe9f9b7e6ef55e169b93b88"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1706
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "ALACN" "http://www.popre.net/" "Xodetaetl" "$PREFIX"

# Verify base game existence
if [ "$(POL_Wine_PrefixExists $PREFIX)" != "True" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Please install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit 1
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_AutoSetVersionEnv

GAMEPATH="$WINEPREFIX/drive_c/GOG Games/Populous - The Beginning"

# Download patch
cd "$POL_USER_ROOT/tmp"
POL_Download "$DOWNLOAD_URL" "$DOWNLOAD_MD5"
cp "$POL_USER_ROOT/tmp/$PATCHFILE" "$GAMEPATH/$PATCHFILE"

cat <<_EOF_ > "$GAMEPATH/popres_readme.txt"
Notice:
-----------------------------------------
Populous 3 only supports resolutions up to:
1440x900 (for 16:10) and 1280x1024 (for 4:3).
It doesn't seem to support 16:10 resolutions.
For color depth, enter "16".
_EOF_

POL_SetupWindow_message "This patch doesn't work with the 'software rendering' version of Populous 3. Be also aware that it let's you enter any resolution, but the game actually only supports resolutions up to: 1440x900 (for 16:10) and 1280x1024 (for 4:3). It doesn't seem to support 16:10 resolutions. For color depth, enter '16'." "Important note"

POL_Shortcut "$PATCHFILE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GAMEPATH/popres_readme.txt"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMwZJMACgkQ5TH6yaoTykfStACgnqYfthHoyUqEWibyHaWg7YND
oC8An2OmlO1Duk0EJyCu6mut4cnqgxbl
=Xqv3
-----END PGP SIGNATURE-----
