#!/bin/bash
# Date : (2011-01-19 12-35)
# Last revision : (2019-06-04)
# Wine version used : 2.22
# Distribution used to test : Xubuntu 19.04
# Author : Twinoatl, updated by SuperPlumus then Dadu042

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="The Truth About Game Development"
PREFIX="Tagd"
WORKING_WINE_VERSION="2.22"

if [ "$POL_LANG" == "fr" ]
then
LNG_WAIT="Veuillez patienter..."
LNG_DOWNLOAD_RUN="Téléchargement en cours..."
LNG_SUCCES="$TITLE a été installé avec succès !"
else
LNG_WAIT="Please wait..."
LNG_DOWNLOAD_RUN="Downloading..."
LNG_SUCCES="$TITLE has been installed successfully."
fi

POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Kloonigames" "http://www.kloonigames.com/blog/games/tagd/" "Twinoatl and SuperPlumus" "$PREFIX"

POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

POL_LoadVar_PROGRAMFILES

TEMP="$REPERTOIRE/tmp/$PREFIX"
mkdir -p "$TEMP"

cd "$TEMP"
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$TITLE" "http://www.kloonigames.com/download.php?file=tagd.zip"
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$TITLE" "http://www.dllbank.com/zip/m/msvcp60.dll.zip"
mv "download.php" "tagd.zip"

#mkdir -p "$WINEPREFIX/drive_c/tagd"
cd "$WINEPREFIX/drive_c"
unzip "$TEMP/tagd.zip"
cd "$WINEPREFIX/drive_c/tagd"
unzip "$TEMP/msvcp60.dll.zip"

POL_SetupWindow_auto_shortcut "$PREFIX" "tagd.exe" "$TITLE"

Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
Set_SoundHardwareAcceleration "Emulation"

chmod -R 777 "$TEMP"
rm -rf "$TEMP"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPYucQAKCRDlMfrJqhPK
R2otAJ9FHr6Yu9Pyo3wuHXMpQZXqYaYhUQCdHTlFgH7pUA6OGoqP3gQkNHwb/Z4=
=deoP
-----END PGP SIGNATURE-----
