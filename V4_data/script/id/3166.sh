#!/bin/bash
# Date : (2018-04-14 00-21)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 19.10 x64
# Author : ferdesign

#
# CHANGELOG
# [ferdesign] (2017-04-20 19-00)
#   Initial script.
# [ferdesign] (2018-04-14 00-21)
#   Updates.
# [Dadu042] (2020-03-10 20:00)
#   Wine 2.6 (outdated) -> 3.0.3.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Fakin' The Funk?"
PREFIX="FakinTheFunk"
WORKING_WINE_VERSION="3.0.3"
EDITOR="Ulrich Decker Software"
APP_URL="https://fakinthefunk.net + https://www.udse.de"
AUTHOR="ferdesign"
FILE="FakinTheFunk_Setup139.exe"
MD5="104444e44a1286638cc0d6eef15f9d13"

# set environment variable
export WINEDLLOVERRIDES="mscoree,mshtml="

# start the script
POL_SetupWindow_Init
POL_SetupWindow_SetID
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$APP_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.1.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# set prefix path
POL_Wine_SelectPrefix "$PREFIX"

# download wine if necessary and create prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# use Windows 7
Set_OS "win7"

# install dependencies
mkdir -p "$WINEPREFIX/drive_c/windows/Resources/Themes/light"
cd "$WINEPREFIX/drive_c/windows/Resources/Themes/light"
POL_Download_Resource "https://www.udse.de/download/light.msstyles" "d04873067f502ee85050201fffef7ba5"
cp "$POL_USER_ROOT/ressources/light.msstyles" "$WINEPREFIX/drive_c/windows/Resources/Themes/light/"
POL_Download_Resource "https://www.udse.de/download/light.reg" "3947fd2b2e266e1489c26760ea2527b8"
POL_Wine regedit "$POL_USER_ROOT/ressources/light.reg"

mkdir -p "$WINEPREFIX/drive_c/windows/Fonts"
cd "$WINEPREFIX/drive_c/windows/Fonts/"
POL_Download "https://www.udse.de/download/Ubuntu-B.ttf" "e0008b580192405f144f2cb595100969"
cp "$POL_USER_ROOT/ressources/Ubuntu-B.ttf" "$WINEPREFIX/drive_c/windows/Fonts/"
POL_Download "https://www.udse.de/download/Ubuntu-BI.ttf" "242df10047b6bae57bee2326cdabe1d2" 
cp "$POL_USER_ROOT/ressources/Ubuntu-BI.ttf" "$WINEPREFIX/drive_c/windows/Fonts/"
POL_Download "https://www.udse.de/download/Ubuntu-R.ttf" "1c5965c2b1dcdea439b54c3ac60cee38"
cp "$POL_USER_ROOT/ressources/Ubuntu-R.ttf" "$WINEPREFIX/drive_c/windows/Fonts/"
POL_Download "https://www.udse.de/download/Ubuntu-RI.ttf" "ce8018018a4db697f103a765b0e61469"
cp "$POL_USER_ROOT/ressources/Ubuntu-RI.ttf" "$WINEPREFIX/drive_c/windows/Fonts/"

# POL_Install_RegisterFonts edit
cat << EOF > "$POL_USER_ROOT/tmp/register_fonts.reg"
 
REGEDIT 4
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion\Fonts]
"Ubuntu Bold (TrueType)"="Ubuntu-B.ttf"
"Ubuntu Bold Italic (TrueType)"="Ubuntu-BI.ttf"
"Ubuntu (TrueType)"="Ubuntu-R.ttf"
"Ubuntu Italic (TrueType)"="Ubuntu-RI.ttf"

[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\Fonts]
"Ubuntu Bold (TrueType)"="Ubuntu-B.ttf"
"Ubuntu Bold Italic (TrueType)"="Ubuntu-BI.ttf"
"Ubuntu (TrueType)"="Ubuntu-R.ttf"
"Ubuntu Italic (TrueType)"="Ubuntu-RI.ttf"
EOF
 
POL_Wine regedit "$POL_USER_ROOT/tmp/register_fonts.reg"

# smoothing fonts anti-aliasing
POL_Call POL_Function_FontsSmoothRGB

# begin app installation
mkdir -p "$WINEPREFIX/drive_c/Program Files"
cd "$WINEPREFIX/drive_c/Program Files/"
POL_Download "https://www.udse.de/download/$FILE" "$MD5"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$FILE"

# create shortcut
POL_Shortcut "FakinTheFunk.exe" "$TITLE" "" "" "Audio;"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXmqZOwAKCRDlMfrJqhPK
R0t6AKCSH33EZPg7fQUtoMESXNJt9yGokACdHI2g3sU8JskUC7Pma4kKRwYlc/o=
=PWKV
-----END PGP SIGNATURE-----
