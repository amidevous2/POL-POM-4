#!/bin/bash
# Date : (2015-12-16 18-47)
# Wine version used : 1.8-rc4-staging
# Distribution used to test : Mac OS
# Author : Quentin PÂRIS
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Black Mesa"
PREFIX="BlackMesa"
WORKING_WINE_VERSION="1.8-staging"
STEAM_ID="362890"
POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Valve" "" "Quentin PÂRIS" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES


POL_SetupWindow_InstallMethod "STEAM"

if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"
	POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
fi

POL_Wine_VMS
POL_Call POL_Install_tahoma

if [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "Steam.exe" "steam://install/$STEAM_ID"
fi
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlaAADsACgkQ5TH6yaoTykf9fwCeMkNbwbsv+JkXi3epPOA3k+Gh
iqAAoKV1umZKnDMjVcRpiXABtPB1ZSnD
=65se
-----END PGP SIGNATURE-----
