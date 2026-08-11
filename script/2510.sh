#!/bin/bash
# Date : (2015-04-28 17-45)
# Last revision : (2015-04-28 17-45)
# Distribution used to test : OS X 10.10.3
# Author : Simon Wörner
# Script licence : GPLv3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="EASy68K"
WORKING_WINE_VERSION="4.0.4"
PREFIX="EASy68K"
DOWNLOAD_LINK="http://www.easy68k.com/files/EASy68K.zip"

POL_SetupWindow_Init

POL_Debug_Init

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_presentation "$TITLE" "EASy68K Team" "http://www.easy68k.com/" "Simon Wörner" "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the EASy68K.zip file to install')" "$TITLE"
    INSTALL_FILE="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "$DOWNLOAD_LINK"
    INSTALL_FILE="$POL_System_TmpDir/EASy68K.zip"
else
    POL_Debug_Fatal "Unknown install method."
fi

unzip "$INSTALL_FILE" -d "$POL_System_TmpDir/"
POL_SetupWindow_licence "Licence:" "$TITLE" "$POL_System_TmpDir/EASy68K/License.txt"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

mv "$POL_System_TmpDir/EASy68K" "$WINEPREFIX/drive_c/EASy68K"
INSTALL_PATH="$WINEPREFIX/drive_c/EASy68K/"

POL_Shortcut "EDIT68K.exe" "Edit68K Editor Assembler"
POL_Shortcut "EASyBIN.exe" "EASyBIN"
POL_Shortcut "SIM68K.exe"  "Sim68K Simulator"

POL_Shortcut_Document "Edit68K Editor Assembler" "readme.txt"

POL_System_TmpDelete
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYMUW7AAKCRDlMfrJqhPK
R6d/AKCoXIaO6k2iqgtxhUe4m5aZ2aaqwQCgpzAtRjHNKhgFHXYMkoo/cshrivw=
=4gNJ
-----END PGP SIGNATURE-----
