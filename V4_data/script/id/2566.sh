#!/usr/bin/env playonlinux-bash
# Date : (2015-06-27 15-45)
# Last revision : (2015-06-27 15-45)
# Wine Version used: 1.7.45-staging
# Distribution used to test: Fedora 22
# Author: Marius_Linux
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Stronghold HD"
PREFIX="StrongholdHD"
STEAM_APP_ID=40950
SHORTCUT_NAME="Stronghold HD"
#Load setup image

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Firefly Studios" "http://german-gamer-guy.blogspot.de" "Marius_Linux"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

Set_OS "winxp"
POL_Call POL_Install_steam
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe" "steam://install/$STEAM_APP_ID"
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_VMS "64"
POL_Shortcut "steam.exe" "$TITLE" "${TITLE}.png" "steam://rungameid/$STEAM_APP_ID -no-dwrite" "Game;StrategyGame"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNaKAAAKCRDlMfrJqhPK
R+bRAKChp8sEbg5cs4rgr8cTMn3xTSMd9gCgjHxTvtu3ov9lOKVz2JkjyfZ+83w=
=7TRy
-----END PGP SIGNATURE-----
