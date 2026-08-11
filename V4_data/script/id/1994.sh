#!/bin/bash

# Date : 2014-04-09 01-00
# Last revision : (2014-04-09 01-00)
# Wine version used : 1.6.2
# Distribution used to test : Debian Jessie
# Author : Tr4sK

# CHANGELOG
# [Tr4sK] (2014-04-09 01-00)
#        Initial release

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"


TITLE="Seals With Clubs"
WINEVERSION="1.6.2"
EDITOR="Seals with Clubs"
EDITOR_URL="https://sealswithclubs.eu"
PREFIX="SwC"
SwC_URL="https://sealswithclubs.eu/pcclient/swc_client-Windows%20v0.2.18.exe"
FILE_DL="swc_client-Windows%20v0.2.18.exe"
FILE="Setup_swc_client-Windowsv0.2.18.exe"
FILE_EXEC="swc_client-Windows v0.2.18.exe"
DIR="swc_client-Windows v0.2.18"

POL_GetSetupImages "https://sealswithclubs.eu/wp-content/themes/twentytwelve/ui/headerlogo2.png" "" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1994
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "Tr4sK" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate

POL_Call POL_Install_LunaTheme

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Some dependencies
if [ "$POL_SELECTED_FILE" ]; then
	SetupFile="$POL_SELECTED_FILE"
else
	POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
	if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
		POL_Download "$SwC_URL" "a5e45d668ada412f16b3474edb944d54"
		SetupFile="$POL_System_TmpDir/$FILE_DL"
	elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
		POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
		SetupFile="$APP_ANSWER"
	fi
fi

cp "$SetupFile" "$WINEPREFIX/drive_c/$FILE"
cd "$WINEPREFIX/drive_c/"

POL_System_TmpDelete

POL_Wine "$FILE"
sleep 5
cd "$DIR"

POL_Shortcut "$FILE_EXEC" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNFwlcACgkQ5TH6yaoTykdRbgCeJThKtGI1GQpLCsohIszu5XuJ
QrUAn11rul6OzXZC2ig/LE4sSs9Zs7bY
=CSf1
-----END PGP SIGNATURE-----
