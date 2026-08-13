#!/usr/bin/env playonlinux-bash
# Date : 2019-04-28T14:43:28
# Last revision : 2019-04-28T14:43:28
# Wine version used : 4.0
# Distribution used to test : Ubuntu 19.04
# Author : Benjamin Altpeter <hi@bn.al>
# Repo : https://github.com/baltpeter/playonlinux-scripts/

# CHANGELOG
# [Benjamin Altpeter] (2019-04-28)
#   First script.
# [Dadu042] (2019-09-17)
#   Add POL version warning.
#   Add software category.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="MagicaVoxel 0.99.3"
PREFIX="MagicaVoxel"
WINE_VERSION="4.0"
 
ZIP_URL="https://github.com/ephtracy/ephtracy.github.io/releases/download/v0.99.3/MagicaVoxel-0.99.3-alpha-win32.zip"
MD5="b62c9abd9f46e453c1e0c2f9fe892a2b"
ZIP_NAME="MagicaVoxel-0.99.3-alpha-win32.zip"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "ephtracy" "https://ephtracy.github.io/" "Benjamin Altpeter <hi@bn.al>" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE_VERSION"
 
INSTALL_DIR="$WINEPREFIX/drive_c/$PREFIX"
 
mkdir -p "$INSTALL_DIR"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "$TITLE"
    ARCHIVE="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$INSTALL_DIR"
    POL_Download "$ZIP_URL" "$MD5"
    ARCHIVE="$INSTALL_DIR/$ZIP_NAME"
fi
 
POL_Wine_WaitBefore "$TITLE"
echo "unzip \"$ARCHIVE\" -d \"$INSTALL_DIR\""
unzip "$ARCHIVE" -d "$INSTALL_DIR" || POL_Debug_Error "Unable to extract archive."
 
POL_Shortcut "MagicaVoxel.exe" "$TITLE" "" "" "3DGraphics;"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXYe4eAAKCRDlMfrJqhPK
R0uLAJ9IB/qd2n8Ky7Xy9CizGqgiL2JLyQCePhRHLTz3jQzcsnyJcRYvcILiQSA=
=qi8X
-----END PGP SIGNATURE-----
